from flask import Flask, render_template, request, redirect, url_for, flash, session
from werkzeug.utils import secure_filename
from datetime import timedelta
import mysql.connector
import json
import os

app = Flask(__name__)
app.secret_key = "hello"
app.permanent_session_lifetime = timedelta(minutes=60)
app.config['UPLOAD_FOLDER'] = 'orphanage_docs'

config = {
    'user': 'root',
    'password': 'root',
    'host': 'db',
    'port': '3306',
    'database': 'orl',
    'autocommit': True
}
# connection = mysql.connector.connect(**config)


# def createConnection():
#     cursor = connection.cursor()
#     return cursor


# admin modules
@app.route('/admin/dashboard/approved-orphanages')
def approvedorphanages():
    return render_template('Admindashboard-approved.html')


@app.route('/admin/dashboard/pending-orphanages')
def pendingorphanages():
    return render_template('Admindashboard-pending.html')


@app.route('/admin/dashboard/view-orphanage-details')
def vieworphanages():
    return render_template('Admindashboard-viewdetails.html')


@app.route('/login')
def login():
    return render_template('login.html')

# orphanage modules


@app.route('/orphanage/register')
def orphanageregister():
    return render_template('Orphanagesignup.html')


@app.route('/orphanage/manage-profile')
def orphanagemanageprofile():
    return render_template('Orphanage-Manageprofile.html')


@app.route('/orphanage/login')
def orphanagelogin():
    path = request.path
    flash(path)
    print(path)
    return render_template('login.html')


@app.route('/logout')
def logout():
    session.pop("user")
    if "user" not in session:
        print("Logged Out")
    return redirect('/login')


@app.route('/submitOrphanageLogin', methods=['POST'])
def submitOrphanageLogin():
    email = request.form.get('email')
    password = request.form.get('password')
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    query = "SELECT * FROM orphanage_users WHERE email_id = %s"
    cursor.execute(query, (email,))
    results = cursor.fetchall()
    print("Results")
    print(results)
    final = [dict(zip([key[0] for key in cursor.description], row))
             for row in results]
    if cursor.rowcount != 0:
        if(final[0]["email_id"] == email) and final[0]["password"] == password:
            user = final[0]["or_user_id"]
            session['user'] = user
            cursor.close()
            connection.close()
            return redirect(url_for('dashboard'))
        else:
            cursor.close()
            connection.close()
            return "Error"
    else:
        cursor.close()
        connection.close()
        return "No Users found. Please login again"


@app.route('/submitSignup', methods=['POST'])
def submitSignup():
    fname = request.form.get('first_name')
    lname = request.form.get('last_name')
    email = request.form.get('email')
    password = request.form.get('password')
    mobile = request.form.get('mobile')
    confirm_password = request.form.get('confirm_password')
    if (password == confirm_password):
        connection = mysql.connector.connect(**config)
        cursor = connection.cursor()
        query = "SELECT * FROM users WHERE email_id = %s"
        cursor.execute(query, (email,))
        results = cursor.fetchall()
        print("Results")
        print(results)
        final = [dict(zip([key[0] for key in cursor.description], row))
                 for row in results]
        print("Final")
        print(final)
        if final:
            for data in final:
                if(data["email_id"] == email):
                    cursor.close()
                    connection.close()
                    return "Email Already Exists. Please use a different email."
                else:
                    print("Inside else 2")
                    query = "INSERT INTO users (first_name, last_name, phone_number, email_id, password) VALUES (%s, %s, %s, %s, %s)"
                    cursor.execute(
                        query, (fname, lname, mobile, email, password,))
                    cursor.close()
                    connection.close()
                    return "Success"
        else:
            query = "INSERT INTO users (first_name, last_name, phone_number, email_id, password) VALUES (%s, %s, %s, %s, %s)"
            cursor.execute(query, (fname, lname, mobile, email, password,))
            cursor.close()
            connection.close()
            return "Success"
    else:
        cursor.close()
        connection.close()
        return "Error"

@app.route('/submitOrphanageSignup', methods=['POST'])
def submitOrphanageSignup():
    orphanage_name = request.form.get('orphanage_name')
    caretaker_name = request.form.get('caretaker_name')
    email = request.form.get('email')
    mobile = request.form.get('mobile')
    address1 = request.form.get('address_line1')
    address2 = request.form.get('address_line2')
    address3 = request.form.get('address_line3')
    area = request.form.get('locality')
    city = request.form.get('city')
    state = request.form.get('state')
    pin = request.form.get('pin_code')
    no_of_children = request.form.get('child_no')
    about = request.form.get('about')
    latitude = request.form.get('latitude')
    longitude = request.form.get('longitude')
    password = request.form.get('password')
    confirm_password = request.form.get('confirm_password')
    registration = request.files['registration']
    registration_path = os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(registration.filename))
    registration.save(registration_path)
    other = request.files['other']
    other_path = os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(other.filename))
    other.save(other_path)
    if password == confirm_password:
        connection = mysql.connector.connect(**config)
        cursor = connection.cursor()
        query = "SELECT * FROM orphanage_users WHERE email_id = %s"
        cursor.execute(query, (email,))
        results = cursor.fetchall()
        print("Results")
        print(results)
        final = [dict(zip([key[0] for key in cursor.description], row))
                 for row in results]
        print("Final")
        print(final)
        if final:
            for data in final:
                if(data["email_id"] == email):
                    cursor.close()
                    connection.close()
                    return "Email Already Exists. Please use a different email."
                else:
                    print("Inside else 2")
                    query = "INSERT INTO orphanage_users (orphanage_name, phone_number, email_id, caretaker_name, no_of_children, about, password) VALUES (%s, %s, %s, %s, %s, %s, %s)"
                    cursor.execute(query, (orphanage_name, mobile, email, caretaker_name, no_of_children, about, password,))
                    cursor.close()
                    query = "SELECT * FROM orphanage_users ORDER BY or_user_id DESC LIMIT 1"
                    cursor.execute(query)
                    results = cursor.fetchall()
                    final = [dict(zip([key[0] for key in cursor.description], row))
                        for row in results]
                    id = final[0]["or_user_id"]
                    query = "INSERT INTO orphanage_addresses (or_user_id, address_line1, address_line2, address_line3, area, city, pin_code, latitude, longitude) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
                    cursor.execute(query,(id, address1, address2, address3, area, city, pin, latitude, longitude,))
                    cursor.close()
                    query = "INSERT INTO orphanage_files (or_user_id, registration, other) VALUES (%s, %s, %s)"
                    cursor.execute(query, (id, registration_path, other_path,))
                    connection.close()
                    return "Success"
        else:
            query = "INSERT INTO orphanage_users (orphanage_name, phone_number, email_id, caretaker_name, no_of_children, about, password) VALUES (%s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(query, (orphanage_name, mobile, email, caretaker_name, no_of_children, about, password,))
            cursor.close()
            cursor = connection.cursor()
            query = "SELECT * FROM orphanage_users ORDER BY or_user_id DESC LIMIT 1"
            cursor.execute(query)
            results = cursor.fetchall()
            final = [dict(zip([key[0] for key in cursor.description], row))
                 for row in results]
            if final:
                id = final[0]["or_user_id"]
                query = "INSERT INTO orphanage_addresses (or_user_id, address_line1, address_line2, address_line3, area, city, pin_code, latitude, longitude) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
                cursor.execute(query,(id, address1, address2, address3, area, city, pin, latitude, longitude,))
                cursor.close()
                cursor = connection.cursor()
                query = "INSERT INTO orphanage_files (or_user_id, registration, other) VALUES (%s, %s, %s)"
                cursor.execute(query, (id, registration_path, other_path,))
                cursor.close()
            else:
                query = "INSERT INTO orphanage_addresses (or_user_id, address_line1, address_line2, address_line3, area, city, pin_code, latitude, longitude) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
                cursor.execute(query,(1, address1, address2, address3, area, city, pin, latitude, longitude,))
                cursor.close()
                cursor = connection.cursor()
                query = "INSERT INTO orphanage_files (or_user_id, registration, other) VALUES (%s, %s, %s)"
                cursor.execute(query, (1, registration_path, other_path,))
                cursor.close()
            connection.close()
            return "Success"
    else:
        return redirect('/orphanage/register')

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
    final = [dict(zip([key[0] for key in cursor.description], row))
             for row in results]
    print("Final\n")
    print(final)
    if cursor.rowcount != 0:
        if(final[0]["email_id"] == email) and final[0]["password"] == password:
            user = final[0]["user_id"]
            session['user'] = user
            cursor.close()
            connection.close()
            return redirect(url_for('home'))
        else:
            cursor.close()
            connection.close()
            return "Error"
    else:
        cursor.close()
        connection.close()
        return "No users found"


@app.route('/signup')
def signup():
    return render_template('Donorsignup.html')


@app.route('/home')
def home():
    return render_template('DonorHome.html')


@app.route('/orders/history')
def orderHistory():
    if "user" in session:
        user = session['user']
        connection = mysql.connector.connect(**config)
        cursor = connection.cursor()
        query = "SELECT * FROM transactions WHERE user_id = %s"
        cursor.execute(query, (user,))
        results = cursor.fetchall()
        final1 = [dict(zip([key[0] for key in cursor.description], row))
                  for row in results]
        print("FINAL 1")
        print(final1)
        final2 = []
        query = "SELECT orphanage_name FROM orphanage_users WHERE or_user_id = %s"
        for item in final1:
            cursor.execute(query, (item["or_user_id"],))
            results = cursor.fetchall()
            final = [dict(zip([key[0] for key in cursor.description], row))
                     for row in results]
            print("FINAL")
            print(final)
            final2.append(final[0])
        print("FINAL 2")
        print(final2)
        return render_template('donorOrderHistory.html', data=final1, data2=final2)
    else:
        return redirect('/login')


@app.route('/orphanage/profile/<id>')
def or_profile(id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    query = "SELECT * FROM orphanage_addresses INNER JOIN orphanage_users ON orphanage_addresses.or_user_id = orphanage_users.or_user_id WHERE orphanage_users.or_user_id = %s"
    cursor.execute(query, (id,))
    results = cursor.fetchall()
    final1 = [dict(zip([key[0] for key in cursor.description], row))
              for row in results]
    query = "SELECT * FROM requirements WHERE or_user_id = %s"
    cursor.execute(query, (id,))
    results = cursor.fetchall()
    final2 = [dict(zip([key[0] for key in cursor.description], row))
              for row in results]
    cursor.close()
    connection.close()
    return render_template('OrphanageProfile.html', data=final1, data2=final2)


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
    cursor.execute(query, (lat, lon,))
    results = cursor.fetchall()
    final = [dict(zip([key[0] for key in cursor.description], row))
             for row in results]
    cursor.close()
    connection.close()
    return {"result": final}


@app.route('/orphanage/')
def dashboard():
    return render_template('dashboardHome.html')


@app.route('/orphanage/dashboard/requirements/new', methods=['GET'])
def newRequirements():
    return render_template('newRequirement.html')


@app.route('/orphanage/dashboard/requirements/new/submit', methods=['POST'])
def newRequirementsSubmit():
    item_name = request.form.get('item_name')
    quantity = request.form.get('quantity')
    valid = request.form.get('valid')
    print("Valid")
    print(valid)
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    if "user" in session:
        user = session['user']
        if valid == '':
            query = "INSERT INTO requirements (or_user_id, item_name, quantity) VALUES(%s, %s, %s)"
            cursor.execute(query, (user, item_name, quantity,))
            cursor.close()
            connection.close()
        else:
            query = "INSERT INTO requirements (or_user_id, item_name, quantity, valid_till) VALUES(%s, %s, %s, %s)"
            cursor.execute(query, (user, item_name, quantity, valid,))
            cursor.close()
            connection.close()
        flash("New Requirement Added Successfully", category="success")
        return render_template('newRequirement.html')
    else:
        return redirect('/orphanage/login')


@app.route('/orphanage/dashboard/requirements/view')
def viewRequirements():
    if "user" in session:
        user = session['user']
        connection = mysql.connector.connect(**config)
        cursor = connection.cursor()
        query = "SELECT * FROM requirements WHERE or_user_id = %s"
        cursor.execute(query, (user,))
        results = cursor.fetchall()
        final = [dict(zip([key[0] for key in cursor.description], row))
                 for row in results]
        cursor.close()
        connection.close()
        return render_template('requirementsList.html', data=final)
    else:
        return redirect('/orphanage/login')


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, ssl_context='adhoc')
