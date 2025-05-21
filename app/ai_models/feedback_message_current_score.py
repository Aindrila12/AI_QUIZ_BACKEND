import pandas as pd
from sklearn.linear_model import LinearRegression
import numpy as np
import random
import joblib

# Sample dataset
data = pd.DataFrame({
    'percentage': [100, 98, 95, 92, 89, 85, 82, 78, 75, 72, 68, 65, 60, 55, 50, 45, 42, 40, 35, 30, 25, 20],
    'score':      [5, 5, 5, 5, 4, 4, 4, 4, 3, 3, 3, 3, 2, 2, 2, 1, 1, 1, 0, 0, 0, 0]
})

# Train a regression model
model = LinearRegression()
model.fit(data[['percentage']], data['score'])

# Define message mapping
score_to_message = {
    5: [
        "Phenomenal! You’ve mastered the subject.",
        "Brilliant result! Truly exceptional work.",
        "Outstanding! Your hard work paid off.",
        "Excellent! You’ve gone above expectations."
    ],
    4: [
        "Great job! Keep pushing your limits.",
        "Very good! You're on the right track.",
        "Strong performance. Just a little more effort!",
        "Well done! You're doing very well."
    ],
    3: [
        "Good job! Try to aim higher next time.",
        "Decent work. A few improvements needed.",
        "Fair effort! Some areas need more focus.",
        "Satisfactory. Review and reinforce concepts."
    ],
    2: [
        "Average performance. Consistent effort needed.",
        "Basic understanding. More practice required.",
        "Getting there. Don't stop now!"
    ],
    1: [
        "Below average. Consider revising key topics.",
        "Weak performance. Seek help if needed.",
        "Not quite there yet. Focus and try again."
    ],
    0: [
        "Poor outcome. Let's identify the gaps.",
        "Needs serious improvement. Don’t lose hope.",
        "Tough result. Try a different learning strategy.",
        "Don't give up! Start from the basics again."
    ]
}

joblib.dump(model, "models/predict_feedback.pkl")
print("Model and data saved to feedback_message_current_score.pkl successfully.")


# Predict a message
# def predict_message(percentage):
#     pred_score = round(model.predict(pd.DataFrame({'percentage': [percentage]}))[0])
#     print(f"Predicted score: {pred_score}")
#     pred_score = max(0, min(5, pred_score))  # Clamp
#     print(f"Clamped score: {pred_score}")
#     return random.choice(score_to_message[pred_score])

# # Example usage

# while True:
#     try:
#         percentage = float(input("Enter your percentage (0-100): "))
#         if 0 <= percentage <= 100:
#             print(predict_message(percentage))
#         else:
#             print("Please enter a valid percentage between 0 and 100.")
#     except ValueError:
#         print("Invalid input. Please enter a number.")
#     except KeyboardInterrupt:
#         print("\nExiting the program.")
#         break
#     except Exception as e:
#         print(f"An unexpected error occurred: {e}")
        # break