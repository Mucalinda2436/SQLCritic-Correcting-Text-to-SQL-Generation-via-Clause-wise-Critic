import json
import yaml
from typing import List, Any


def load_json(file_path: str) -> Any:
    """
    Load JSON data from a file.

    Args:
        file_path (str): Path to the JSON file.

    Returns:
        Any: Parsed JSON data.
    """
    with open(file_path, 'r') as f:
        return json.load(f)


def load_sql(file_path: str) -> List[str]:
    """
    Load SQL queries from a file.

    Args:
        file_path (str): Path to the SQL file.

    Returns:
        List[str]: List of SQL queries.
    """
    with open(file_path, 'r') as f:
        return [line.strip() for line in f]


def dump_json(data: Any, file_path: str) -> None:
    """
    Write JSON data to a file.

    Args:
        data (Any): Data to be written to the JSON file.
        file_path (str): Path to the output JSON file.
    """
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)


def dump_sql(sqls: List[str], file_path: str) -> None:
    """
    Write a list of SQL queries to a file, each query on a new line.

    Args:
        sqls (List[str]): List of SQL queries.
        file_path (str): Path to the output file.
    """
    with open(file_path, 'w') as f:
        for sql in sqls:
            f.write(sql.strip() + '\n')


def load_yaml(file_path: str) -> Any:
    """
    Load YAML data from a file.

    Args:
        file_path (str): Path to the YAML file.

    Returns:
        Any: Parsed YAML data.
    """
    with open(file_path, 'r') as f:
        return yaml.safe_load(f)


def dump_yaml(data: Any, file_path: str) -> None:
    """
    Write data to a YAML file.

    Args:
        data (Any): Data to be written to the YAML file.
        file_path (str): Path to the output YAML file.
    """
    with open(file_path, 'w') as f:
        yaml.safe_dump(data, f, default_flow_style=False, sort_keys=False)