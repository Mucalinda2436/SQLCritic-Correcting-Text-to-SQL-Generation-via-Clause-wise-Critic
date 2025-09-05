from src.utils.file_process import *
from typing import Any, List, Tuple


# Define the path of dataset
DATASET_PATHS = {
    'spider': {
        'train': 'datasets/spider/train_spider_and_others.json',
        'dev': 'datasets/spider/dev.json'
    },
    'bird': {
        'train': 'datasets/bird/train/train.json',
        'dev': 'datasets/bird/dev/dev.json'
    }
    # adding more dataset
}


def load_db_and_pred_info(data_name: str, mode: str, pred_sql_file: str="") -> Tuple[List[str], List[str], List[str], List[str]]:
    if data_name in DATASET_PATHS and mode in DATASET_PATHS[data_name]:
        db_items = load_json(DATASET_PATHS[data_name][mode])
    else:
        raise ValueError(f"Unsupported data_name '{data_name}' or mode '{mode}'")
    
    db_names = [db_item['db_id'] for db_item in db_items]
    questions = [db_item['question'] for db_item in db_items]
    if data_name == "spider":
        gold_sqls = [db_item['query'] for db_item in db_items]
        kgs = []
    elif 'bird':
        gold_sqls = [db_item['SQL'] for db_item in db_items]
        kgs = [db_item['evidence'] for db_item in db_items]
        
    pred_sqls = load_sql(pred_sql_file) if pred_sql_file != "" else []
    
    return db_names, questions, gold_sqls, pred_sqls, kgs