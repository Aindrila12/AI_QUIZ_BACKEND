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
        query = f"SELECT topic_id, clientid, name, description, image, {config.QSN_COUNT} AS total_qsn FROM mst_topics WHERE " + search +  " clientid = %s ORDER BY topic_id DESC LIMIT %s OFFSET %s"
        search_params += (data["clientid"], int(data["limit"]), int(data["offset"]))
        result = readQuery(query, search_params)
        return result if result else []
    except Exception as e:
        print(f"Error in fetch_all_topics: {e}")
        return None
    
def fetch_all_questions(data):
    try:
        search = ""
        search_params = ()
        if data.get("search"):
            search = " (q.question_text LIKE %s OR t.name LIKE %s) AND "
            search_params += (f"%{data['search']}%", f"%{data['search']}%")
        query = f"SELECT q.question_id, q.clientid, q.topic_id, q.categoryid, q.level_id, q.question_text, q.questiontype, t.name AS topicname, c.categoryname, l.name AS level FROM mst_questions q JOIN mst_topics t ON q.topic_id = t.topic_id JOIN mst_levels l ON q.level_id = l.level_id LEFT JOIN mst_categories c ON q.categoryid = c.categoryid WHERE " + search +  " q.clientid = %s ORDER BY q.question_id DESC LIMIT %s OFFSET %s"
        search_params += (data["clientid"], int(data["limit"]), int(data["offset"]))
        result = readQuery(query, search_params)
        return result if result else []
    except Exception as e:
        print(f"Error in fetch_all_questions: {e}")
        return None
    
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
        return result[0] if result else {}
    except Exception as e:
        print(f"Error in update_topic_data: {e}")
        return None
    
def fetch_levels(data):
    try:
        query = "SELECT level_id, name FROM mst_levels WHERE clientid = %s"
        result = readQuery(query, (data["clientid"]))
        return result
    except Exception as e:
        print(f"Error in fetch_levels: {e}")
        return False
    
def get_all_categories(data):
    try:
        query = "SELECT categoryid, categoryname, topicid FROM mst_categories  WHERE clientid = %s"
        result = readQuery(query, (data["clientid"]))
        return result
    except Exception as e:
        print(f"Error in fetch_levels: {e}")
        return False
    
def insert_question(data):
    try:
        print("Inserting question with options:", data)
        # Insert question
        question_query = """
            INSERT INTO mst_questions 
            (clientid, topic_id, categoryid, level_id, question_text, questiontype, descriptiveanswer)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        question_params = (
            data['clientid'],
            data.get('topic_id'),
            data.get('category_id', None),
            data.get('level_id'),
            data['question'],
            data['question_type'],
            data.get('descriptive_answer', '')
        )

        question_id = writeQuery(question_query, question_params).lastrowid

        if not question_id:
            return False

        # If MCQ, insert options
        if data['question_type'] == 1:
            insert_option(data, question_id)

        return question_id

    except Exception as e:
        print(f"Error in insert_question_with_options: {e}")
        return False

def insert_option(data, question_id):
        try:
            options = data.get('options', [])
            correct_answer = data.get('correct_answer', '')


            cleaned_options = [opt.strip() for opt in options if opt.strip()]
            if cleaned_options:
                placeholders = ", ".join(["(%s, %s, %s, %s, %s)"] * len(cleaned_options))
                option_query = f"""
                    INSERT INTO mst_options 
                    (clientid, question_id, option_label, option_text, is_correct)
                    VALUES {placeholders}
                """
                option_params = []
                for idx, opt_text in enumerate(cleaned_options):
                    label = chr(97 + idx)  # 'a', 'b', 'c', ...
                    is_correct = 1 if opt_text.strip().lower() == correct_answer.strip().lower() else 0
                    option_params.extend([
                        data['clientid'],
                        question_id,
                        label,
                        opt_text,
                        is_correct
                    ])

                writeQuery(option_query, tuple(option_params))
        except Exception as e:
            print(f"Error in insert_option: {e}")   
            return False


def insert_users(insert_values):
    try:
        # insert_values should already contain tuples with all required fields including clientid
        placeholders = ', '.join(['(%s, %s, %s, %s, %s, %s, %s)'] * len(insert_values))
        flat_values = [val for row in insert_values for val in row]

        query = f"""
            INSERT INTO users (
                clientid, email, name, username, password,
                image, usertype
            )
            VALUES {placeholders}
        """
        writeQuery(query, tuple(flat_values))
        return True

    except Exception as e:
        print(f"Error in insert_users: {e}")
        return False

    
def fetch_all_users(data):
    try:
        search = ""
        search_params = ()
        if data.get("search"):
            search = " (u.name LIKE %s OR u.username LIKE %s) AND "
            search_params += (f"%{data['search']}%", f"%{data['search']}%")
        query = f"""
            SELECT userid, clientid, email, name, username, image, usertype 
            FROM users
            WHERE {search} clientid = %s AND usertype = 3 AND isdeleted = 0 ORDER BY userid DESC
            LIMIT %s OFFSET %s
        """
        search_params += (data["clientid"], int(data["limit"]), int(data["offset"]))
        result = readQuery(query, search_params)
        return result if result else []
    except Exception as e:
        print(f"Error in fetch_all_users: {e}")
        return None
    
def fetch_all_error_logs(data):
    try:
        type = ""
        search_params = ()
        if data.get("search"):
            type = " uploadtype LIKE %s AND "
            search_params += (f"%{data['search']}%",)
        query = f"""
            SELECT logid, clientid, uploadtype, filename
            FROM error_log
            WHERE {type} clientid = %s AND deleted = 0
            LIMIT %s OFFSET %s
        """
        search_params += (data["clientid"], int(data["limit"]), int(data["offset"]))
        result = readQuery(query, search_params)
        return result if result else []
    except Exception as e:
        print(f"Error in fetch_all_error_logs: {e}")
        return None



