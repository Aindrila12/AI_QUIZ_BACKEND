from app.database.dbconnection import readQuery, writeQuery

def get_topic_scores(data):
    try:
        query = """
            SELECT 
                a.topicid,
                t.name AS topic_name,
                AVG(a.score) AS avg_score
            FROM trn_answers a
            JOIN mst_topics t ON a.topicid = t.topic_id
            JOIN trn_attempts ta ON a.attemptid = ta.attemptid
            WHERE ta.clientid = %s AND a.userid = %s
            GROUP BY a.topicid
            ORDER BY avg_score ASC
            LIMIT 3
        """
        results = readQuery(query, (data["clientid"], data["userid"]))
        return results
    except Exception as e:  
        print(f"Error in get_weak_topic_goals: {e}")
        return None