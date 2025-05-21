import numpy as np
import random
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder
import joblib

# Step 1: Sample data (each entry has multiple messages)
data = [
    ([80, 60, 50, 90], [
        "You showed inconsistency, but there's a clear sign of recovery.",
        "Though your performance varied, you bounced back impressively!",
        "Keep working on consistency — the effort is visible.",
        "There’s progress despite fluctuations. Stay motivated!",
        "An up-and-down journey, but you’re ending strong!"
    ]),
    
    ([90, 85, 88, 92, 89, 91], [
        "Excellent and steady performance!",
        "You are maintaining a very high standard. Great job!",
        "Strong consistency across attempts – well done!",
        "You clearly understand the material – keep it going!",
        "Very reliable performance. You're mastering this."
    ]),

    ([70, 60, 50, 40, 30], [
        "Your scores are going down – let's focus on the basics again.",
        "Performance is slipping. Consider reviewing weak areas.",
        "Don't get discouraged, but a course correction is needed.",
        "Let’s take a step back and rebuild the foundation.",
        "Gradual decline detected. Time for a focused revision."
    ]),

    ([60, 62, 61, 63, 64], [
        "You’re maintaining a steady performance – nice stability.",
        "Your consistency is admirable. Aim to push higher now.",
        "Stable scores – now try to level up.",
        "This is a solid base. Let’s build on it.",
        "Nice and consistent – consider setting higher goals."
    ]),

    ([40, 45, 50, 90, 92], [
        "Great comeback! Early struggles turned around strongly.",
        "You started off slow but finished with a punch – well done!",
        "Impressive recovery – shows resilience.",
        "That ending score speaks volumes about your potential.",
        "A real turnaround story. Keep pushing!"
    ]),

    ([60, 70, 75, 80, 85, 90], [
        "You’re showing steady growth – great job!",
        "Excellent trend. Keep building momentum!",
        "Climbing upward! You’re getting better each time.",
        "This is how progress looks – upward and onward!",
        "Clear improvement. Stay on this track."
    ]),

    ([50, 60, 55, 65, 70, 68], [
        "Some fluctuations, but the trend is promising.",
        "You’re improving even with minor dips — keep going.",
        "Try to smooth out inconsistencies and keep progressing.",
        "You're getting there! Just stay a bit more focused.",
        "Resilience in ups and downs is a strength — keep refining."
    ]),

    ([30, 32, 31, 33, 30, 31], [
        "It’s time to revisit the basics and build from there.",
        "You're consistent, now work on raising the bar.",
        "Steady but low — let’s aim for stronger gains.",
        "Progress starts with awareness — let’s begin again.",
        "Think of this as your starting line, not the finish."
    ]),

    ([90, 88, 60, 45, 40], [
        "A noticeable drop – don’t lose confidence.",
        "Everyone dips sometimes — bounce back strong!",
        "Let’s reflect and reset — you’ve done better before.",
        "It's okay to slip — learn and return stronger.",
        "You have the potential. Let’s turn it around!"
    ]),

    ([30, 50, 70, 72, 71, 73], [
        "Great start! Now push through the plateau.",
        "You made strong early gains — now refine further.",
        "Keep the momentum going beyond the comfort zone.",
        "Plateaus are normal — persistence breaks them.",
        "You’re very close to a breakthrough — keep practicing!"
    ]),

    # Shorter sequences below

    ([92], [
        "Perfect score! You nailed it.",
        "One shot, and you got it right. Excellent job!",
        "Impressive result — shows strong understanding."
    ]),

    ([65, 70], [
        "You’re off to a good start!",
        "A solid start — let's keep building from here.",
        "Your momentum is picking up — nice work!"
    ]),

    ([45, 40], [
        "Tough start — time to review the basics.",
        "Low scores so far — don't give up, just recalibrate.",
        "Start small, grow stronger. Let’s put in the work!"
    ]),

    ([75, 78, 80], [
        "You're improving steadily — great consistency!",
        "Keep pushing. You're moving in the right direction.",
        "Your scores show upward momentum — keep it up!"
    ]),

    ([55, 50, 60], [
        "Some variation, but you’re hovering around the average.",
        "Let’s try to push this average score upward.",
        "Slight inconsistencies — aim for more clarity and focus."
    ])
]



# Step 2: Feature extraction
def extract_features(scores):
    attempts = np.arange(1, len(scores) + 1).reshape(-1, 1)
    scores_np = np.array(scores)

    lr = LinearRegression()
    lr.fit(attempts, scores_np)
    slope = lr.coef_[0]

    avg = np.mean(scores)
    std = np.std(scores)
    mn = np.min(scores)
    mx = np.max(scores)
    length = len(scores)

    return [slope, avg, std, mn, mx, length]

# Step 3: Prepare dataset
X = []
y = []
message_map = {}
for i, (scores, messages) in enumerate(data):
    X.append(extract_features(scores))
    y.append(str(i))  # use group ID as label
    message_map[str(i)] = messages

# Step 4: Train model
label_encoder = LabelEncoder()
y_encoded = label_encoder.fit_transform(y)

model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X, y_encoded)

joblib.dump({
    'model': model,
    'label_encoder': label_encoder,
    'message_map': message_map
}, "historical_performance_prediction.pkl")

print("Model and data saved to feedback_model.pkl successfully.")



# Step 5: Predict message
# def get_feedback_message(scores):
#     features = extract_features(scores)
#     pred_encoded = model.predict([features])[0]
#     group_label = label_encoder.inverse_transform([pred_encoded])[0]
#     messages = message_map[group_label]
#     return random.choice(messages)


