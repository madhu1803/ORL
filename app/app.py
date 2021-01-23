from flask import Flask, render_template
import mysql.connector
import json

app = Flask(__name__)

config = {
    'user': 'root',
    'password': 'root',
    'host': 'db',
    'port': '3306',
    'database': 'orl'
}
# connection = mysql.connector.connect(**config)
# cursor = connection.cursor()
# cursor.execute('SELECT * FROM favorite_colors')
# results = [{name: color} for (name, color) in cursor]
# cursor.close()
# connection.close()

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/signup')
def signup():
    return render_template('signup.html')

@app.route('/home')
def home():
    return render_template('DonorHome.html')

@app.route('/orphanage/profile')
def or_profile():
    return render_template('OrphanageProfile.html')


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, ssl_context='adhoc')
