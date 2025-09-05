# TODO: 接收「待修正的 .sql 文件」、「dataset 类型」、「SemanticAgent 模型」，通过 SQLCritic 实现「批评 + 修正」的逻辑。
import argparse
import os

from src.utils.file_process import *
from src.utils.load_database_and_prediction_info import load_db_and_pred_info
from src.utils.sql_tools import Cleaner, get_info_dict
from src.agents.sql_critic import SQLCritic


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--semantic_agent_path", type=str, required=True, help="path to the SemanticAgent model")
    parser.add_argument("--dataset_name", type=str, required=True, help="dataset name")
    parser.add_argument("--mode", type=str, default="dev", help="mode")
    parser.add_argument("--sql_file_path", type=str, required=True, help="path to the .sql file for correction")
    parser.add_argument("--output_dir", type=str, required=True, help="directory of the outputs")
    parser.add_argument("--api_key", type=str, required=True, help="GPT API key")
    parser.add_argument("--base_url", type=str, default="", help="base url for the API")
    args = parser.parse_args()

    # 初始化 SQLCritic
    sql_critic = SQLCritic(semantic_agent_path=args.semantic_agent_path, dataset_name=args.dataset_name)

    # 初始化 Cleaner
    cleaner = Cleaner(dataset_name=args.dataset_name, mode=args.mode)

    # 读取待修正的 .sql 文件和 数据集信息
    db_names, questions, gold_sqls, pred_sqls, kgs = load_db_and_pred_info(args.dataset_name, args.mode, args.sql_file_path)
    schema_infos = get_info_dict(args.dataset_name)

    assert len(db_names) == len(questions) == len(gold_sqls) == len(pred_sqls) == len(kgs), "Lengths of lists are not equal!"

    # 构建 item_dict
    item_dicts = []
    for i in range(len(db_names)):
        item_dict = {
            "db_name": db_names[i],
            "question": questions[i],
            "gold_sql": cleaner.format_sql(sql_query=gold_sqls[i], db_name=db_names[i]),
            "pred_sql": cleaner.format_sql(sql_query=pred_sqls[i], db_name=db_names[i]),
            "kg": kgs[i],
            "db_schema": schema_infos[db_names[i]]
        }
        item_dicts.append(item_dict)
    
    # 执行主流程
    final_sqls = []
    # for test
    item_dicts = item_dicts[:1]
    # for test
    for item_dict in item_dicts:
        item_dict = sql_critic.process(item_dict)
        if item_dict["error_type"] == "correct":
            final_sqls.append(item_dict["pred_sql"])
        elif item_dict["refined_sql"] == "INVALID_SQL":
            final_sqls.append(item_dict["pred_sql"])
        else:
            final_sqls.append(item_dict["refined_sql"])
    
    if args.dataset_name == "bird":
        bird_outputs = {}
        for i in range(len(final_sqls)):
            bird_outputs[str(i)] = final_sqls[i] + '\t----- bird -----\t' + db_names[i]
        dump_json(bird_outputs, os.path.join(args.output_dir, "refined_output_bird.json"))
    else:
        dump_sql(final_sqls, os.path.join(args.output_dir, "refined_output_spider.sql"))
    
    dump_json(item_dicts, os.path.join(args.output_dir, "item_dicts.json"))

    print(f"All files saved in the directory: {{args.output_dir}}!")