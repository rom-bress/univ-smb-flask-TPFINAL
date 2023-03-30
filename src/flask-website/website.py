from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def start(): 
    return render_template('start.html')

@app.route("/authentification")
def authentification(): 
    return render_template('authentification.html')
    