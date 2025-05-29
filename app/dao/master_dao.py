from app.database.dbconnection import readQuery, writeQuery
import config


def insert_topic(data, clientid):
    try:
        topic_name = data['topic_name']
        description = data["description"]
        categories = data.get('categories', [])

        # Insert topic
        topic_query = """
            INSERT INTO mst_topics (name, description, clientid)
            VALUES (%s, %s, %s)
        """
        topic_params = (topic_name, description, clientid)
        topic_result = writeQuery(topic_query, topic_params)
        topic_id = topic_result.lastrowid

        if categories:
            insert_categories(data, topic_id, clientid)

        return True

    except Exception as e:
        print(f"Error in insert_topic: {e}")
        return None
    
def insert_categories(data, topic_id, clientid):
    try:
        categories = data.get('categories', [])

        if categories:
            cleaned_categories = [cat.strip() for cat in categories if cat.strip()]
            if cleaned_categories:
                placeholders = ", ".join(["(%s, %s, %s)"] * len(cleaned_categories))
                category_query = f"""
                    INSERT INTO mst_categories (categoryname, topicid, clientid)
                    VALUES {placeholders}
                """
                category_params = []
                for cat in cleaned_categories:
                    category_params.extend([cat, topic_id, clientid])

                writeQuery(category_query, tuple(category_params))

        return True

    except Exception as e:
        print(f"Error in insert_categories: {e}")
        return None

    
def insert_error_log(data, clientid):
    try:
        log_query = """
            INSERT INTO error_log (uploadtype, filename, clientid)
            VALUES (%s, %s, %s)
        """
        writeQuery(log_query, (data["type"], data["filename"], clientid))

    except Exception as e:
        print(f"Error in insert_error_log: {e}")
        return None
    
def get_categories(clientid):
    try:
        # Fetch categories grouped by topicid
        category_query = """
            SELECT topicid, GROUP_CONCAT(categoryname SEPARATOR ', ') AS categories
            FROM mst_categories
            WHERE clientid = %s
            GROUP BY topicid
        """

        category_rows = readQuery(category_query, (clientid,))
        return category_rows

    except Exception as e:
        print(f"Error in insert_error_log: {e}")
        return None
    
def fetch_all_topics(data):
    try:
        search = ""
        search_params = ()
        if data.get("search"):
            search = " name LIKE %s AND "
            search_params += (f"%{data['search']}%",)
        query = f"SELECT topic_id, clientid, name, description, image, {config.QSN_COUNT} AS total_qsn FROM mst_topics WHERE " + search +  " clientid = %s LIMIT %s OFFSET %s"
        search_params += (data["clientid"], int(data["limit"]), int(data["offset"]))
        result = readQuery(query, search_params)
        return result if result else []
    except Exception as e:
        print(f"Error in fetch_all_topics: {e}")
        return []
    
def fetch_all_questions(data):
    try:
        search = ""
        search_params = ()
        if data.get("search"):
            search = " q.question_text LIKE %s AND "
            search_params += (f"%{data['search']}%",)
        query = f"SELECT q.question_id, q.clientid, q.topic_id, q.categoryid, q.level_id, q.question_text, q.questiontype, t.name AS topicname, c.categoryname, l.name AS level FROM mst_questions q, mst_topics t, mst_categories c, mst_levels l WHERE " + search +  " q.clientid = %s AND q.topic_id = t.topic_id AND q.categoryid = c.categoryid AND q.level_id = l.level_id LIMIT %s OFFSET %s"
        search_params += (data["clientid"], int(data["limit"]), int(data["offset"]))
        result = readQuery(query, search_params)
        return result if result else []
    except Exception as e:
        print(f"Error in fetch_all_questions: {e}")
        return []
    
def update_topic_data(data):
    try:
        query = "UPDATE mst_topics SET image = %s WHERE topic_id = %s AND clientid = %s"
        writeQuery(query, (data["image"], data["topicid"], data["clientid"]))
        return True
    except Exception as e:
        print(f"Error in update_topic_data: {e}")
        return False
    
def get_topic_details(data):
    try:
        query = "SELECT * FROM mst_topics  WHERE topic_id = %s AND clientid = %s"
        result = readQuery(query, ( data["topicid"], data["clientid"]))
        return result[0] if result else {};
    except Exception as e:
        print(f"Error in update_topic_data: {e}")
        return False
