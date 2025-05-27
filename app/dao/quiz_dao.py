from app.database.dbconnection import readQuery, writeQuery
import config

def fetch_all_topics(data):
    try:
        query = f"SELECT topic_id, clientid, name, description, image, {config.QSN_COUNT} AS total_qsn FROM mst_topics WHERE clientid = %s"
        result = readQuery(query, (data["clientid"]))
        return result if result else []
    except Exception as e:
        print(f"Error in fetch_all_topics: {e}")
        return []
        return False
    


def create_attempt(data):
    try:
        userid = data.get('userid')
        topicid = data.get('topicid')

        query = """
            INSERT INTO trn_attempts (userid, topicid)
            VALUES (%s, %s)
        """
        params = (userid, topicid)

        # Insert and get last inserted id (attemptid)
        attemptid = writeQuery(query, params).lastrowid
        return attemptid
    except Exception as e:
        print(f"Error in create_attempt: {e}")
        return None
    
def check_attempt(data):
    try:
        query = """
            SELECT attemptid, iscompleted FROM trn_attempts WHERE attemptid = %s 
        """
        params = (data["attemptid"])

        # Insert and get last inserted id (attemptid)
        attemptid = readQuery(query, params)
        return attemptid[0]
    except Exception as e:
        print(f"Error in create_attempt: {e}")
        return None
    

def check_user_consent(userid):
    try:
        query = "SELECT consent FROM trn_user_consent WHERE userid = %s AND consent = 1"
        result = readQuery(query, (userid))
        print("result >>>>>>>>>", result)
        return bool(result)
    except Exception as e:
        print(f"Error in check_user_consent: {e}")
        return False

def get_previous_performance(userid, topicid):
    try:
        query = """
            SELECT 
                SUM(CASE WHEN iscorrect = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS accuracy
            FROM trn_answers a
            JOIN mst_questions q ON a.questionid = q.question_id
            WHERE a.userid = %s AND q.topic_id = %s
        """
        result = readQuery(query, (userid, topicid))
        return result[0]['accuracy'] if result and result[0]['accuracy'] is not None else None
    except Exception as e:
        print(f"Error in get_previous_performance: {e}")
        return None

def get_next_question_by_level(topicid, levelid, exclude_question_ids=None):
    try:
        query = """
            SELECT q.question_id, q.question_text, q.level_id, l.name AS levelname, q.topic_id, t.name AS topicname, q.categoryid, c.categoryname
            FROM mst_questions q, mst_levels l, mst_categories c, mst_topics t
            WHERE q.topic_id = %s AND q.level_id = %s AND q.level_id = l.level_id AND q.categoryid = c.categoryid AND q.topic_id = t.topic_id
        """
        params = [topicid, levelid]

        # Add exclusion clause if needed
        if exclude_question_ids:
            placeholders = ','.join(['%s'] * len(exclude_question_ids))
            query += f" AND question_id NOT IN ({placeholders})"
            params.extend(exclude_question_ids)

        result = readQuery(query, params)
        return result

    except Exception as e:
        print(f"Error in get_next_question_by_level: {e}")
        return None
    
def get_options_by_questionid(questionid):
    try:
        query = """
            SELECT option_id, option_text, option_label
            FROM mst_options
            WHERE question_id = %s
        """
        options = readQuery(query, (questionid,))
        return options
    except Exception as e:
        print(f"Error in get_options_by_questionid: {e}")
        return []
    
def get_option_correct_flag(optionid):
    try:
        query = "SELECT is_correct FROM mst_options WHERE option_id = %s"
        result = readQuery(query, (optionid,))
        return result[0]['is_correct']
    except Exception as e:
        print(f"Error in get_option_correct_flag: {e}")
        return False
    

def store_user_answer(data):
    try:
        query = """
            INSERT INTO trn_answers (userid, attemptid, topicid, questionid, optionid, iscorrect)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        params = (data['userid'], data['attemptid'], data['topicid'], data['questionid'], data['optionid'], data["iscorrect"])
        return writeQuery(query, params)
    except Exception as e:
        print(f"Error storing answer: {e}")
        return None

def update_attempt_complete(attemptid):
    try:
        query = "UPDATE trn_attempts SET iscompleted = 1 WHERE attemptid = %s"
        return writeQuery(query, (attemptid,))
    except Exception as e:
        print(f"Error updating attempt status: {e}")
        return None

def get_answer_count(attemptid):
    try:
        query = "SELECT COUNT(*) as total FROM trn_answers WHERE attemptid = %s"
        result = readQuery(query, (attemptid,))
        return result[0]['total'] if result else 0
    except Exception as e:
        print(f"Error in get_answer_count: {e}")
        return 0

def get_correct_answer_count(attemptid):
    try:
        query = "SELECT COUNT(*) as correct FROM trn_answers WHERE attemptid = %s AND iscorrect = 1"
        result = readQuery(query, (attemptid,))
        return result[0]['correct'] if result else 0
    except Exception as e:
        print(f"Error in get_correct_answer_count: {e}")
        return 0
    
def get_all_answers_for_attempt(attemptid):
    try:
        query = """
            SELECT a.iscorrect, a.questionid, a.optionid
            FROM trn_answers a
            WHERE a.attemptid = %s
        """
        return readQuery(query, (attemptid,))
    except Exception as e:
        print(f"Error in get_all_answers_for_attempt: {e}")
        return []


def get_answers_by_attemptid(attemptid, topicid):
    try:
        query = "SELECT iscorrect, topicid FROM trn_answers WHERE attemptid = %s AND topicid = %s"
        return readQuery(query, (attemptid, topicid))
    except Exception as e:
        print(f"Error in get_answers_by_attemptid: {e}")
        return []

def get_completed_attempts_by_user(userid, topicid):
    try:
        query = """
            SELECT attemptid, createdat FROM trn_attempts
            WHERE userid = %s AND topicid = %s AND iscompleted = 1 ORDER BY createdat ASC
        """
        return readQuery(query, (userid, topicid))
    except Exception as e:
        print(f"Error in get_completed_attempts_by_user: {e}")
        return []


def save_user_consent(clientid, userid, consent):
    try:
        query = """
            INSERT INTO trn_user_consent (clientid, userid, consent)
            VALUES (%s, %s, %s)
        """
        writeQuery(query, (clientid, userid, consent))
        return True
    except Exception as e:
        print("Database error:", e)
        return False
    
def get_topic_name(topicid):
    try:
        query = """
            SELECT name FROM mst_topics WHERE topic_id = %s
        """
        result = readQuery(query, (topicid))
        if len(result) > 0:
            return result[0]['name']
        else:
            return None
    except Exception as e:
        print("Database error:", e)
        return False


