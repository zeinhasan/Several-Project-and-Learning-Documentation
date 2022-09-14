from flask import Flask, render_template, request
import pickle

app = Flask(__name__)
model = pickle.load(open('D:\Semester 4\Praktikum Komputasi Statistika 2\Laprak UAS_Komstat2_Kelompok 2\webapp\model.pkl', 'rb'))

@app.route("/")
def hello():
    return render_template('index.html')

@app.route("/predict", methods=['POST'])
def predict():
    name = str(request.form['name'])
    age = int(request.form['Age'])
    value = int(request.form['Value'])
    wage = int(request.form['Wage'])
    height = int(request.form['Height'])
    weight = int(request.form['Weight'])
    prediction = model.predict([[age, value, wage, height, weight]])
    output = prediction.item(0)
    return render_template('index.html', prediction_text=f'Player bernama {name} dengan usia {age}, dengan value sebesar {value} usd dollar ($), besar gaji {wage} dollar, tinggi badan {height} cm, dan berat badan {weight} kg, memiliki release clause sebesar {output} usd dollar ($)')

if __name__ == "__main__":
    app.run(host='0.0.0.0',debug=True , port=5007,threaded=True)