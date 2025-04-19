from flask import Flask, request, jsonify
from transformers import pipeline

app = Flask(__name__)

# تحميل موديل التحليل العاطفي
classifier = pipeline("text-classification", model="cardiffnlp/twitter-xlm-roberta-base-sentiment")

@app.route('/analyze', methods=['POST'])
def analyze_feedback():
    data = request.get_json()  # الحصول على البيانات من الطلب
    text = data.get('text', '')  # النص المدخل من المستخدم

    # تحليل النص باستخدام موديل الـ Transformer
    result = classifier(text)
    label = result[0]['label']  # النتيجة ستكون إما "POSITIVE" أو "NEGATIVE"

    # إرجاع النتيجة للمستخدم
    return jsonify({'label': label})

if __name__ == '__main__':
    app.run(debug=True)  # تشغيل الخادم
