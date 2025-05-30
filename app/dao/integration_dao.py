from app.database.dbconnection import readQuery, writeQuery


def checkClient(data):
    try:
        query = """
            SELECT clientid
            FROM mst_clients
            WHERE email = %s AND deleted = 0
        """
        result = readQuery(query, (data["companyEmail"]))
        
        if result and len(result) > 0:
            return True
        
        return None
    
    except Exception as e:
        print(f"Error in get_user_by_credentials: {e}")
        return None
    
    
def checkUser(data):
    try:
        query = """
            SELECT userid
            FROM users
            WHERE (email = %s OR username = %s) AND isdeleted = 0
        """
        result = readQuery(query, (data["email"], data["username"]))
        
        if result and len(result) > 0:
            return True
        
        return None
    
    except Exception as e:
        print(f"Error in get_user_by_credentials: {e}")
        return None
    
    
def insertIntoClient(data):
    try:
        query = """
            INSERT INTO mst_clients (integrationkey, clientname, licenceno, phone, email, logo, agenticaiaccess)
            VALUES
            (%s, %s, %s, %s, %s, %s, %s)
        """
        result = writeQuery(query, (data['integrationkey'], data["companyName"], data["licenceNumber"], data["companyPhone"], data["companyEmail"], data["companyLogo"], data["agenticAccess"]))
        
        return result.lastrowid
    
    except Exception as e:
        print(f"Error in insertIntoClient: {e}")
        return False
    
    
def insertIntoUser(data):
    try:
        query = """
            INSERT INTO users (clientid, email, name, username, password, usertype)
            VALUES
            (%s, %s, %s, %s, %s, %s)
        """
        result = writeQuery(query, (data['insertedClientId'], data["email"], data["name"], data["username"], data["password"], 2))
        
        return result.lastrowid
    
    except Exception as e:
        print(f"Error in insertIntoUser: {e}")
        return False
    
    
    
def checkAuthentication(data):
    try:
        query = """
            SELECT a.userid, a.clientid, a.email, a.name, a.username, a.usertype, a.image, b.clientname, b.logo AS clientlogo, b.agenticaiaccess
            FROM users a, mst_clients b
            WHERE a.username = %s AND a.clientid = b.clientid AND b.integrationkey = %s AND a.isactive = 1 AND a.isdeleted = 0 AND b.active = 1 AND b.deleted = 0
        """
        result = readQuery(query, (data["username"], data["integrationkey"]))
        
        if result and len(result) > 0:
            return result[0]
        
        return False
    
    except Exception as e:
        print(f"Error in get_user_by_credentials: {e}")
        return None