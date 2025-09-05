# TODO：实现 PromptFactory 类，根据传入的「执行 SQL 后得到的 dict 内容」，自动构造「用于修正的 prompt」。具体来说，如果返回的 dict 中 [error_type] 字段为 "syntax error"，则返回 MAC-SQL 的修正 prompt；如果返回的 dict 中 [error_type] 字段为 "semantic error"，则构造我们设计的修正 prompt。
from abc import ABC, abstractmethod


class PromptStrategy(ABC):
    @abstractmethod
    def generate(self, context: dict) -> str:
        pass


class SemanticCritiqueStrategy(PromptStrategy):
    critic_template = "{db_schema}\n**QUESTION**: {question} {kg}\n\n**PREDICTED SQL QUERY**: {pred_sql}\n\nIs this SQL Query correct? If not, generate a CRITIQUE for the PREDICTED SQL QUERY to point out errors."

    def generate(self, context):
        return self.critic_template.format(db_schema=context['db_schema'], question=context['question'], kg=context['kg'], pred_sql=context['pred_sql'])


class SemanticErrorStrategy(PromptStrategy):
    refiner_template = """### Task: You are given a PREDICTED SQL QUERY along with a CRITIQUE that identifies issues in the query. Your task is to apply the critique to correct the query. After making the necessary changes, provide the REFINED SQL QUERY.\n\n### Examples:\n\n#### Question: Among the days on which over 100 units of item no.5 were sold in store no.3, on which date was the temperature range the biggest? over 100 units refers to units > 100; item no. 5 refers to item_nbr = 5; store no.3 refers to store_nbr = 3; the temperature range was the biggest refers to Max(Subtract(tmax, tmin))\n#### Predicted SQL Query: SELECT tmax - tmin FROM weather INNER JOIN relation ON weather.station_nbr = relation.station_nbr INNER JOIN sales_in_weather ON relation.store_nbr = sales_in_weather.store_nbr WHERE sales_in_weather.item_nbr = 5 AND sales_in_weather.units > 100 AND relation.store_nbr = 3 ORDER BY tmax - tmin DESC LIMIT 1\n#### Critique: 1. The SELECT clause is incorrect; it should select 'sales_in_weather.date' from 'relation' instead of 'tmax - tmin' from 'whether' to align with the user's intent of finding the date on which the temperature range was the biggest.\n2. The WHERE clause contains an unnecessary condition, 'relation.store_nbr = 3', which should be removed, as this information is already covered in the JOIN operations and does not need to be repeated here.\n\n#### Refined SQL Query: SELECT sales_in_weather.date FROM relation INNER JOIN sales_in_weather ON relation.store_nbr = sales_in_weather.store_nbr INNER JOIN weather ON relation.station_nbr = weather.station_nbr WHERE sales_in_weather.store_nbr = 3 AND sales_in_weather.item_nbr = 5 AND sales_in_weather.units > 100 ORDER BY tmax - tmin DESC LIMIT 1\n\n#### Question: State the nick name of player ID 'aubinje01'. List all the teams and season he played for. nick name refers to nameNick; team refers to tmID; season refers to year\n#### Predicted SQL Query: SELECT master.namenick , teams.name , teams.year FROM goalies INNER JOIN master ON goalies.playerid = master.playerid INNER JOIN teams ON goalies.tmid = teams.tmid AND goalies.year = teams.year WHERE master.playerid = 'aubinje01'\n#### Critique: 1. The SELECT clause should select 'DISTINCT master.namenick' to ensure that only unique nick names are listed, then select 'teams.year' and 'teams.name'\n2. The JOIN clauses are incorrect; the query should join 'master' with 'goalies' on 'master.playerid = goalies.playerid', and then join 'teams' on 'goalies.tmid = teams.tmid' to ensuring it starts from the master table as per user requirements.\n\n#### Refined SQL Query: SELECT DISTINCT master.namenick , teams.year , teams.name FROM master INNER JOIN goalies ON master.playerid = goalies.playerid INNER JOIN teams ON goalies.tmid = teams.tmid WHERE master.playerid = 'aubinje01'\n\n#### Question: State the most popular movie? When was it released and who is the director for the movie? most popular movie refers to MAX(movie_popularity); when it was released refers to movie_release_year; director for the movie refers to director_name;\n#### Predicted SQL Query: SELECT director_name, movie_release_year FROM movies ORDER BY movie_popularity DESC LIMIT 1\n#### Critique: 1. The SELECT clause is missing 'movie_title'. This does not align with the user's intent of knowing the title of the most popular movie along with its release year and director's name. And it should select the 'movie_title' first, followed by 'movie_release_year' and 'director_name'.\n\n#### Refined SQL Query: SELECT movie_title, movie_release_year, director_name FROM movies ORDER BY movie_popularity DESC LIMIT 1\n\n{db_schema}\n#### Question: {question} {kg}\n#### Predicted SQL Query: {pred_sql}\n#### Critique: {critique}\n\n#### Refined SQL Query: """

    def generate(self, context):
        return self.refiner_template.format(db_schema=context['db_schema'], question=context['question'], kg=context['kg'], pred_sql=context['pred_sql'], critique=context['critique'])
    

class SyntaxErrorStrategy(PromptStrategy):
    refiner_template = """**Task Description:**
You are an SQL database expert tasked with correcting a SQL query. A previous attempt to run a query
did not yield the correct results, either due to errors in execution or because the result returned was empty
or unexpected. Your role is to analyze the error based on the provided database schema and the details of
the failed execution, and then provide a corrected version of the SQL query.
**Procedure:**
1. Review Database Schema:
- Examine the table creation statements to understand the database structure.
2. Analyze Query Requirements:
- Original Question: Consider what information the query is supposed to retrieve.
- Hint: Use the provided hints to understand the relationships and conditions relevant to the query.
- Executed SQL Query: Review the SQL query that was previously executed and led to an error or
incorrect result.
- Execution Result: Analyze the outcome of the executed query to identify why it failed (e.g., syntax
errors, incorrect column references, logical mistakes).
3. Correct the Query:
- Modify the SQL query to address the identified issues, ensuring it correctly fetches the requested data
according to the database schema and query requirements.
**Output Format:**
Present your corrected query as a single line of SQL code, after Final Answer. Ensure there are
no line breaks within the query.

======= Your task =======
**************************
Table creation statements
{db_schema}
**************************
The original question is:
Question:
{question}
Evidence:
{kg}
The SQL query executed was:
{pred_sql}
The execution result:
{critique}
**************************
Based on the question, table schema and the previous query, analyze the result try to fix the query."""

    def generate(self, context):
        return self.refiner_template.format(question=context['question'], kg=context['kg'], db_schema=context['db_schema'], pred_sql=context['pred_sql'], critique=context['critique'])
    

class PromptFactory:
    def create(self, error_type: str, context: dict) -> str:
        if error_type == "":
            return SemanticCritiqueStrategy().generate(context)
        else:
            error_type = context.get("error_type")
            strategy = self._get_correction_strategy(error_type)
            return strategy.generate(context)
    
    def _get_correction_strategy(self, error_type):
        return {
            "syntax error": SyntaxErrorStrategy(),
            "semantic error": SemanticErrorStrategy()
        }.get(error_type)
    

# if __name__=='__main__':
#     error_type = "semantic error"

#     test_item = {
#         "db_schema": "@@@@@我是 db_schema!@@@@@",
#         "question": "@@@@@我是 question!@@@@@",
#         "kg": "@@@@@我是 kg!@@@@@",
#         "fk": "@@@@@我是 fk!@@@@@",
#         "pred_sql": "@@@@@我是 pred_sql!@@@@@",
#         "critique": "@@@@@我是 critique!@@@@@",
#         "exception_class": "@@@@@我是 exception_class!@@@@@",
#         "error_type": error_type
#     }
    
#     prompt_factory = PromptFactory()

#     print(prompt_factory.create(error_type, test_item))