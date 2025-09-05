

import sqlite3
from func_timeout import func_set_timeout


class SyntaxAgent:
    def __init__(self, dataset_name: str):
        self.dataset_name = dataset_name

        if self.dataset_name == 'bird':
            self.data_path = "datasets/bird/dev/dev_databases"
        elif self.dataset_name == 'spider':
            self.data_path = "datasets/spider/database"
        else:
            raise ValueError(f"dataset {dataset_name} not supported")
        
    @func_set_timeout(120)
    def _execute_sql(self, sql: str, db_id: str) -> dict:
        # Get database connection
        db_path = f"{self.data_path}/{db_id}/{db_id}.sqlite"
        conn = sqlite3.connect(db_path)
        conn.text_factory = lambda b: b.decode(errors="ignore")
        cursor = conn.cursor()
        try:
            cursor.execute(sql)
            result = cursor.fetchall()
            return {
                "sql": str(sql),
                "data": result[:5],
                "critique": "",
                "exception_class": ""
            }
        except sqlite3.Error as er:
            return {
                "sql": str(sql),
                "critique": str(' '.join(er.args)),
                "exception_class": str(er.__class__)
            }
        except Exception as e:
            return {
                "sql": str(sql),
                "critique": str(e.args),
                "exception_class": str(type(e).__name__)
            }

    def _is_executable(self, exec_result: dict):
        # spider exist dirty values, even gold sql execution result is None
        if self.dataset_name == 'spider':
            if 'data' not in exec_result:
                return False
            return True
        
        data = exec_result.get('data', None)
        if data is not None:
            if len(data) == 0:
                exec_result['critique'] = 'no data selected'  
                return False
            for t in data:
                for n in t:
                     if n is None:  # fixme fixme fixme fixme fixme
                        exec_result['critique'] = 'exist None value, you can add `NOT NULL` in SQL'
                        return False
            return True
        else:
            return False

    def execute(self, sql: str, db_id: str) -> tuple:
        exec_result = self._execute_sql(sql, db_id)
        is_executable = self._is_executable(exec_result)

        return is_executable, exec_result  


# if __name__=="__main__":
#     syntax_agent = SyntaxAgent("bird")
#     sql = "SELECT `Free Meal Count (K-12)` / `Enrollment (K-12)` FROM frpm WHERE `County Name` = 'Alameda' ORDER BY (CAST(`Free Meal Count (K-12)` AS REAL) / `Enrollment (K-12)`)"
#     db_id = "california_schools"
#     print(syntax_agent.execute(sql, db_id))