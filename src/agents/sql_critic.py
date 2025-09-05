# TODO: 实现 SQLCritic 类，负责「执行 SQL」、「调度两种 Critic Agent 进行批评」，「调度 PromptFactory 获得修正 prompt 并进行修正」，最后执行「替换无效的修正结果」，得到最终的修正版本。 
from src.agents.semantic_agent import SemanticAgent
from src.agents.syntax_agent import SyntaxAgent
from src.agents.prompt_factory import PromptFactory
from src.utils.gpt_generation import GPT
from src.utils.sql_tools import clean_sql


class SQLCritic:
    def __init__(self, semantic_agent_path: str, dataset_name: str, api_key: str, base_url: str):
        """
        初始化三个 Agent 和 PromptFactory
        """
        self.semantic_agent = SemanticAgent(model_name_or_path=semantic_agent_path)
        self.syntax_agent = SyntaxAgent(dataset_name=dataset_name)
        self.refine_agent = GPT(api_key=api_key, base_url=base_url, model="gpt-3.5-turbo")
        self.prompt_factory = PromptFactory()

    def process(self, item_dict: dict) -> dict:
        """
        主流程：执行语法检查、语义批评和 SQL 修复
        """
        pred_sql = item_dict.get("pred_sql")
        db_name = item_dict.get("db_name")

        self._check_syntax(item_dict, pred_sql, db_name)

        if item_dict["is_executable"]:
            self._perform_critique(item_dict)

        if item_dict["error_type"] != "correct":
            self._refine_sql(item_dict)

        return item_dict

    def _check_syntax(self, item_dict: dict, sql: str, db_id: str):
        """
        语法检查：调用 SyntaxAgent 执行 SQL 并更新状态
        """
        is_executable, exec_result = self.syntax_agent.execute(sql=sql, db_id=db_id)
        item_dict["is_executable"] = is_executable

        item_dict["exception_class"] = exec_result.get("exception_class", "")
        item_dict["critique"] = exec_result.get("critique", "")

        if not is_executable:
            item_dict["error_type"] = "syntax error"

    def _perform_critique(self, item_dict: dict):
        """
        语义检查：通过 SemanticAgent 对可执行的 SQL 进行批评
        """
        try:
            prompt_for_critic = self.prompt_factory.create(error_type="", context=item_dict)
            
            response = self.semantic_agent.chat(prompt=prompt_for_critic)
            critique = response[0].get("generated_text", "") if response else "No critique available."

            item_dict["critique"] = critique

            if "This SQL Query is correct." in critique:
                item_dict["error_type"] = "correct"
            else:
                item_dict["error_type"] = "semantic error"
        except Exception as e:
            item_dict["critique"] = f"Error during critique: {str(e)}"
            item_dict["error_type"] = "unknown"

    def _refine_sql(self, item_dict: dict):
        """
        SQL 修复：根据错误类型和批评结果修正 SQL
        """
        try:
            prompt = self.prompt_factory.create(error_type=item_dict["error_type"], context=item_dict)
            
            refined_sql = self.refine_agent.generate(prompt)
            refined_sql = clean_sql(refined_sql)

            is_valid, _ = self.syntax_agent.execute(sql=refined_sql, db_id=item_dict["db_name"])
            if is_valid:
                item_dict["refined_sql"] = refined_sql
            else:
                item_dict["refined_sql"] = "INVALID_SQL"
        except Exception as e:
            item_dict["refined_sql"] = "ERROR"
