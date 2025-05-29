import pymysql
from pymysql.err import OperationalError

# MySQL configurations
def create_connection():
    connection = None
    try:
        connection = pymysql.connect(
            host='localhost',            # Change if your MySQL server is hosted elsewhere
            user='root',        # Replace with your MySQL username
            password='password',    # Replace with your MySQL password
            database= 'ai_quiz'        # Replace with your database name
        )
    except OperationalError as e:
        print(f"Error: {e}")
    return connection


def readQuery(query, value):
    try:
        connection = create_connection()
        cursor = connection.cursor()
        cursor.execute(query, value)
        rows = cursor.fetchall()
        columns = [column[0] for column in cursor.description]
        
        results = []
        for row in rows:
            results.append(dict(zip(columns, row)))
        
        cursor.close()
        connection.close()
        return results
    except Exception as e:
        print(e)
        return False



def writeQuery(query, value):
    try:
        connection = create_connection()
        cursor = connection.cursor()
        cursor.execute(query, value)
        # inserted_id = cursor.lastrowid
        
        connection.commit()
        cursor.close()
        connection.close()
        return cursor
    except Exception as e:
        print(e)
        return False
