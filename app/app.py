from flask import Flask, render_template, request
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
    final = []
    dic = {}
    print("Results\n")
    print(results)
    for i in results:
        for j in range(0, len(i)):
            if(j == 2):
                dic.update({"Address_Line1": i[j]})
            elif(j == 3):
                dic.update({"Address_Line2": i[j]})
            elif(j == 4):
                if(i[j] != ''):
                    dic.update({"Address_line3": i[j]})
            elif(j == 5):
                dic.update({"Area": i[j]})
            elif(j == 6):
                dic.update({"City": i[j]})
            elif(j == 7):
                dic.update({"PIN_Code": i[j]})
            elif(j == 8):
                dic.update({"Latitude": i[j]})
            elif(j == 9):
                dic.update({"Longitude": i[j]})
            elif(j == 11):
                dic.update({"Orphanage_Name": i[j]})
            elif(j == 12):
                dic.update({"Phone_Number": i[j]})
            elif(j == 13):
                dic.update({"Caretaker_Name": i[j]})
            elif(j == 14):
                dic.update({"Email": i[j]})
            elif(j == 15):
                dic.update({"Distance":i[j]})
        final.append(dic)

    cursor.close()
    connection.close()
    return {"result":final}

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, ssl_context='adhoc')
