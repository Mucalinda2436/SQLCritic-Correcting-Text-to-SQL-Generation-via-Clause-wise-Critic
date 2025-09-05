import sqlite3
import sys
import os
from func_timeout import func_timeout, FunctionTimedOut, func_set_timeout


class Executor:
    def __init__(self, dataset: str, mode: str):
        self.dataset = dataset
        if dataset == 'spider':
            self.db_root = "datasets/spider/database"
        elif dataset == 'bird':
            if mode == 'train':
                self.db_root = "datasets/bird/train/train_databases"
            elif mode == 'dev':
                self.db_root = "datasets/bird/dev/dev_databases"
        else:
            raise ValueError(f"{dataset} dataset is not a valid dataset!")
        
    # def execute(self, predicted_sql: str, gold_sql: str, db_name: str, timeout: int=15) -> any:
    #     """Execute the model with a timeout.

    #     Args:
    #         predicted_sql (str): Predict sql query.
    #         gold_sql (str): Gold sql query.
    #         db_name (str): Database of the current SQLs.
    #         timeout (int): An integer for limiting the execution time.

    #     Returns:
    #         any
    #     """
    #     try:
    #         db_path = os.path.join(self.db_root, f'{db_name}/{db_name}.sqlite')
    #         return func_timeout(timeout, self.__execute_sql, args=(predicted_sql, gold_sql, db_path))
    #     except KeyboardInterrupt:
    #         sys.exit(0)
    #     except FunctionTimedOut:
    #         return 'Time is out, please input the correct SQL query.', -1
    #     except Exception as e:
    #         return str(e), -1

    # def __execute_sql(self, predicted_sql: str, gold_sql: str, db_path: str) -> any:
    #     """No need to change."""
    #     conn = sqlite3.connect(db_path)
    #     cursor = conn.cursor()
    #     try:
    #         cursor.execute(predicted_sql)
    #         predicted_result = cursor.fetchall()
    #         cursor.execute(gold_sql)
    #         gold_result = cursor.fetchall()
    #         if predicted_result == gold_result:
    #             return gold_result, 1
    #         else:
    #             return predicted_result, 0
    #     except Exception as e:
    #         return str(e), -1

    @func_set_timeout(10)
    def _execute_sql(self, sql: str, db_name: str) -> dict:
        db_path = os.path.join(self.db_root, f'{db_name}/{db_name}.sqlite')
        conn = sqlite3.connect(db_path)
        conn.text_factory = lambda b: b.decode(errors="ignore")
        cursor = conn.cursor()
        try:
            cursor.execute(sql)
            result = cursor.fetchall()
            return {
                "sql": str(sql),
                "data": result,
                "sqlite_error": "",
                "exception_class": ""
            }
        except sqlite3.Error as er:
            return {
                "sql": str(sql),
                "data": "sqlite3.Error",  
                "sqlite_error": str(' '.join(er.args)),
                "exception_class": str(er.__class__)
            }
        except Exception as e:
            return {
                "sql": str(sql),
                "data": "sqlite3.Error", 
                "sqlite_error": str(e.args),
                "exception_class": str(type(e).__name__)
            }

    def _is_need_refine(self, exec_result: dict):
        if self.dataset == 'spider':
            return 'data' not in exec_result
        
        data = exec_result.get('data', None)
        if data == "sqlite3.Error":
            return True
        
        if data is not None:
            if len(data) == 0:
                exec_result['sqlite_error'] = 'no data selected'
                return True
            for t in data:
                for n in t:
                    if n is None:
                        exec_result['sqlite_error'] = 'exist None value, you can add `NOT NULL` in SQL'
                        return True
            return False
        else:
            return True
    
    def execute(self, sql: str, gold_sql: str, db_name: str):
        try:
            gold_info = self._execute_sql(gold_sql, db_name)
            error_info = self._execute_sql(sql, db_name)

            # if not gold_info or not error_info:
            #     return None, 0  

            is_need = self._is_need_refine(error_info)
            
            if error_info['data'] == gold_info['data']:
                return gold_info['data'], 1
            elif is_need:
                return error_info.get('sqlite_error', None), -1
            else:
                return error_info.get('data', None), 0
        except FunctionTimedOut:
            return 'Time is out, please input the correct SQL query.', 0  
        except Exception as e:
            return str(e), -1  