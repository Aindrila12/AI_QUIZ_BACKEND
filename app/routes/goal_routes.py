from flask import Blueprint, request, jsonify
from validation.goal_validation import *
from dao.goal_dao import *

goal_bp = Blueprint('goal_bp', __name__)

@goal_bp.route('/get_goals', methods=['POST'])
def get_weak_topic_goals(clientid, userid):
    try:
        data = request.json
        if not validate_get_goal_data(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Every field is required to start.',
                'response': None
            })

        # Step 1: Get average score per topic for the user
        topic_scores = get_topic_scores(data)

        if topic_scores is None:
            return []

        # Step 2: Sort topics by average score (ascending)
        sorted_topics = sorted(topic_scores, key=lambda x: x['avg_score'])

        # Step 3: Pick top 3 weakest topics
        weakest_topics = sorted_topics[:3]
        weakest_topic_ids = [t['topic_id'] for t in weakest_topics]

        # Step 4: Get 1 goal per weak topic
        placeholders = ','.join(['%s'] * len(weakest_topic_ids))
        goal_query = f"""
            SELECT topic_id, goal_title, goal_description, duration_days
            FROM goals
            WHERE clientid = %s AND topic_id IN ({placeholders})
            GROUP BY topic_id
            ORDER BY duration_days ASC
        """
        goal_params = (clientid, *weakest_topic_ids)
        goals = readQuery(goal_query, goal_params)

        return goals

    except Exception as e:
        print(f"Error in get_weak_topic_goals: {e}")
        return []
