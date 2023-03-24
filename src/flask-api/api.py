from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from yourapp import db

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql:///identity.db'
db = SQLAlchemy(app)

class Authentification(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(120), nullable=False)

class Profil(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nom = db.Column(db.String(80), nullable=False)
    prenom = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    authentification_id = db.Column(db.Integer, db.ForeignKey('authentification.id'), nullable=False)
    authentification = db.relationship('Authentification', backref=db.backref('profil', lazy=True))


app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql:///second_db.db'
db = SQLAlchemy(app)

class WebServer(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=True, nullable=False)
    ip_address = db.Column(db.String(120), nullable=False)

class LoadBalancer(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=True, nullable=False)
    ip_address = db.Column(db.String(120), nullable=False)

class ReverseProxy(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=True, nullable=False)
    ip_address = db.Column(db.String(120), nullable=False)


db.create_all()
