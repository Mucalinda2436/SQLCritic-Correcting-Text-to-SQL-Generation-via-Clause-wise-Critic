import collections
import json
import os
import re
import tiktoken
import sqlite3

from transformers import AutoTokenizer
from src.utils.file_process import *


class Cleaner:
    def __init__(self, dataset_name: str='bird', mode: str='dev'):
        self.table_info_dict = {
            'bird': {
                'train': 'datasets/bird/train/train_tables.json',
                'dev': 'datasets/bird/dev/dev_tables.json'
            },
            'spider': {
                'train': 'datasets/spider/tables.json',
                'dev': 'datasets/spider/tables.json'
            }
        }
        self.dataset_name = dataset_name
        self.mode = mode

    def _load_tables_info(self, tables_path):
        tables_info = {}
        tables = load_json(tables_path)
        for table in tables:
            tables_info[table['db_id']] = {
                'tables': table['table_names_original'],
                'columns': [column_name_original[1] for column_name_original in table['column_names_original'][1:]]
            }
        return tables_info

    def _convert_schema_to_lower(self, str_for_replacement, db_name):
        """
        convert the table and column names in a string into lower format.
        """
        tables_info = self._load_tables_info(self.table_info_dict[self.dataset_name][self.mode])
            
        for table_name in tables_info[db_name]['tables']:
            pattern = fr"\b{table_name}\b"
            str_for_replacement = re.sub(pattern, table_name.lower(), str_for_replacement, flags=re.IGNORECASE)
        for column_name in tables_info[db_name]['columns']:
            pattern = fr"\b{column_name}\b"
            str_for_replacement = re.sub(pattern, column_name.lower(), str_for_replacement, flags=re.IGNORECASE)
        
        return str_for_replacement

    def _remove_alias(self, sql_query):
        # 正则表达式匹配表名和别名，包括使用AS关键字的情况，并处理反引号
        pattern = r'FROM\s+`?(\w+)`?\s+(?:AS\s+)?`?(\w+)`?|JOIN\s+`?(\w+)`?\s+(?:AS\s+)?`?(\w+)`?'
        matches = re.findall(pattern, sql_query, re.IGNORECASE)
        
        alias_dict = {}
        for match in matches:
            if match[0] and match[1]:
                alias_dict[match[1]] = match[0]
            if match[2] and match[3]:
                alias_dict[match[3]] = match[2]
        # 使用正则表达式匹配别名并替换为原始表名
        for alias, original_name in alias_dict.items():
            pattern = r'\b' + re.escape(alias) + r'\.'
            replacement = original_name + '.'
            sql_query = re.sub(pattern, replacement, sql_query)
        
        # 删除FROM和JOIN子句中的AS部分及其后的别名，并处理反引号
        sql_query = re.sub(r'(\bFROM\s+`?\w+`?\s+AS\s+`?\w+`?|\bJOIN\s+`?\w+`?\s+AS\s+`?\w+`?)', lambda match: re.sub(r'\s+AS\s+`?\w+`?', '', match.group(0), flags=re.IGNORECASE), sql_query, flags=re.IGNORECASE)
        
        return sql_query.strip()

    def format_sql(self, sql_query, db_name):
        sql_query = self._convert_schema_to_lower(sql_query, db_name)
        sql_query = self._remove_alias(sql_query)
        return sql_query
    

def clean_sql(sql):
    cleaned_sql = ' '.join(sql.split())
    cleaned_sql = cleaned_sql.replace('```sql', '').replace('```', '')

    bos = cleaned_sql.find("SELECT")
    cleaned_sql = cleaned_sql[bos:]

    return cleaned_sql.strip()
    

def get_info_dict(dataset: str='bird'):
    if dataset == 'bird':
        return load_json("datasets/bird/schema_infos.json")
    elif dataset == 'spider':
        return load_json("")

