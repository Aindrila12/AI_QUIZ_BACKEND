# app/dao/user_dao.py

from app.database.dbconnection import readQuery

def get_user_by_credentials(data):
    try:
        query = """
            SELECT userid, name, username, clientid, image, password
            FROM users
            WHERE username = %s AND isactive = 1 AND isdeleted = 0
        """
        result = readQuery(query, (data["username"]))
        if result and len(result) > 0:
            return result[0]
        return None
    except Exception as e:
        print(f"Error in get_user_by_credentials: {e}")
        return None

