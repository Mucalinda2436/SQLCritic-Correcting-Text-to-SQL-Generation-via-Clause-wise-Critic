# def format_sql(sql):
#     try:
#         sql_list = sql.split()  # 将字符串按任意数量的空白字符（包括连续的空白字符）进行分割，并返回一个不含空白字符的列表
#         index = sql_list.index('SELECT')
#         new_sql = sql_list[index:]
#         return ' '.join(new_sql).strip()
    
#     except Exception as e:
#         print(e)
#         sql_list = f'SELECT {sql}'.split()  # 将字符串按任意数量的空白字符（包括连续的空白字符）进行分割，并返回一个不含空白字符的列表
#         index = sql_list.index('SELECT')
#         new_sql = sql_list[index:]
#         print(' '.join(new_sql).strip())
#         return ' '.join(new_sql).strip()


from sql_metadata import Parser
import re
from src.utils.file_process import *


TABLE_INFO = '/Users/chenjikai/PythonProject/database_and_tools/spider/tables.json'


def extract_aliases(sql_query):
        # 正则表达式匹配表名和别名，包括使用AS关键字的情况，并处理反引号
        pattern = r'\bFROM\s+`?(\w+)`?\s+(?:AS\s+)`?(\w+)`?\b|\bJOIN\s+`?(\w+)`?\s+(?:AS\s+)`?(\w+)`?\b'
        matches = re.findall(pattern, sql_query, re.IGNORECASE)
        
        alias_dict = {}
        for match in matches:
            if match[0] and match[1]:
                alias_dict[match[1]] = match[0]
            if match[2] and match[3]:
                alias_dict[match[3]] = match[2]

        return alias_dict


def remove_table_alias(sql_query):
    alias_dict = extract_aliases(sql_query)
    # 使用正则表达式匹配别名并替换为原始表名
    for alias, original_name in alias_dict.items():
        pattern = r'\b' + re.escape(alias) + r'\.'
        replacement = original_name + '.'
        sql_query = re.sub(pattern, replacement, sql_query)
    
    # 删除FROM和JOIN子句中的AS部分及其后的别名，并处理反引号
    sql_query = re.sub(r'(\bFROM\s+`?\w+`?\s+AS\s+`?\w+`?|\bJOIN\s+`?\w+`?\s+AS\s+`?\w+`?)', lambda match: re.sub(r'\s+AS\s+`?\w+`?', '', match.group(0), flags=re.IGNORECASE), sql_query, flags=re.IGNORECASE)

    for alias, original_name in alias_dict.items():
        pattern = r'\b' + re.escape(alias) + r'\b'
        sql_query = re.sub(pattern, '', sql_query)
    
    return sql_query.strip()
 

def load_tables_info(tables_path):
    tables_info = {}
    tables = load_json(tables_path)
    for table in tables:
        tables_info[table['db_id']] = {
            'tables': table['table_names_original'],
            'columns': [column_name_original[1] for column_name_original in table['column_names_original'][1:]]
        }

    return tables_info


def convert_schema_to_lower(str_for_replacement, db_name):
    """
    convert the table and column names in a string into lower format.
    """
    tables_info = load_tables_info(TABLE_INFO)
    for table_name in tables_info[db_name]['tables']:
        pattern = fr"\b{table_name}\b"
        str_for_replacement = re.sub(pattern, table_name.lower(), str_for_replacement, re.IGNORECASE)
    for column_name in tables_info[db_name]['columns']:
        pattern = fr"\b{column_name}\b"
        str_for_replacement = re.sub(pattern, column_name.lower(), str_for_replacement, re.IGNORECASE)
    
    return str_for_replacement


def format_sql(sql, db_name):
    try:
        sql = sql.replace('```', "").replace('select', 'SELECT')
        sql_list = sql.split()  # 将字符串按任意数量的空白字符（包括连续的空白字符）进行分割，并返回一个不含空白字符的列表
        index = sql_list.index('SELECT')
        new_sql_list = sql_list[index:]
        new_sql = ' '.join(new_sql_list).strip()

        new_sql = remove_table_alias(new_sql)
        new_sql = convert_schema_to_lower(new_sql, db_name)
        new_sql = ' '.join(new_sql.split()).strip()

        return new_sql

    except Exception as e:
        print(f"{e}:\n{sql}\nis not a valid SQL")
        return "Invalid SQL statement."
