from flask import Flask, render_template, request, redirect, url_for
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

@app.route('/submitLogin', methods=['POST'])
def submitLogin():
    email = request.form.get('email')
    password = request.form.get('password')
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    query = "SELECT * FROM users WHERE email_id = %s"
    cursor.execute(query, (email,))
    results = cursor.fetchall()
    print("Results")
    print(results)
    final = [dict(zip([key[0] for key in cursor.description], row)) for row in results]
    # print(json.dumps({'results': final}))
    print("Final\n")
    print(final)
    cursor.close()
    connection.close()
    if(final[0]["email_id"] == email) and final[0]["password"] == password:
        return redirect(url_for('home'))
    else:
        return "Error"

@app.route('/signup')
def signup():
    return render_template('signup.html')

@app.route('/home')
def home():
    return render_template('DonorHome.html')

@app.route('/orphanage/profile/<id>')
def or_profile(id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    query = "SELECT * FROM orphanage_addresses INNER JOIN orphanage_users ON orphanage_addresses.or_user_id = orphanage_users.or_user_id WHERE orphanage_users.or_user_id = %s"
    cursor.execute(query, (id,))
    results = cursor.fetchall()
    final = [dict(zip([key[0] for key in cursor.description], row)) for row in results]
    print(final)
    cursor.close()
    connection.close()
    return render_template('OrphanageProfile.html', data=final)

@app.route('/getOrphanages')
def getOrphanages():
    lat = float(request.args.get('lat'))
    lon = float(request.args.get('lon'))
    print("Lat ")
    print(type(lat))
    print("lon: ")
    print(type(lon))
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    query = "SELECT *, SQRT(POW(69.1 * (latitude - %s), 2) + POW(69.1 * (%s - longitude) * COS(latitude / 57.3), 2)) AS distance FROM orphanage_addresses INNER JOIN orphanage_users ON orphanage_addresses.or_user_id = orphanage_users.or_user_id HAVING distance < 25 ORDER BY distance;"
    # print("Query\n")
    # print(query)
    cursor.execute(query, (lat, lon,))
    results = cursor.fetchall()
    final = [dict(zip([key[0] for key in cursor.description], row)) for row in results]
    # print(json.dumps({'results': final}))
    print("Final\n")
    print(final)
    print("Results\n")
    print(results)
    cursor.close()
    connection.close()
    return {"result":final}

@app.route('/orphanage/dashboard/requirements/new')
def newRequirements():
    return render_template('newRequirement.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, ssl_context='adhoc')
