import mysql.connector
from flask import request, session

config = {
	'user': 'root',
	'password': 'root',
	'host': 'db',
	'port': '3306',
	'database': 'orl',
	'autocommit': True
}

def track():
	conn = mysql.connector.connect(**config)
	cursor = conn.cursor(dictionary=True)
	try:
		query = "SELECT * FROM views WHERE user_id = %s"
		cursor.execute(query,(session['user'],))
		results = cursor.fetchall()
		print("Results")
		print(results)
		if not results:
			addEntry()
		else:
			addEntry(results)
	except Exception as e:
		print("Exception")
		print(e)
	finally:
		cursor.close()
		conn.close()

def insertNewRow(or_user_id):
	try:
		conn = mysql.connector.connect(**config)
		cursor = conn.cursor(dictionary=True)
		query = "INSERT INTO views (user_id, or_user_id) VALUES (%s, %s)"
		cursor.execute(query, (session['user'], or_user_id))
	except Exception as e:
		print(e)
	finally:
		cursor.close()
		conn.close()

def addEntry(user_results=None):
	flag = False
	url = request.url
	or_user_id = int(url.split('/')[-1])
	print("OR ID")
	print(or_user_id)
	if user_results != None:
		for result in user_results:
			if or_user_id == result['or_user_id']:
				try:
					conn = mysql.connector.connect(**config)
					cursor = conn.cursor(dictionary=True)
					print("Update")
					query = "UPDATE views SET count = count+1 WHERE id = %s"
					cursor.execute(query, (result['id'],))
					flag = True
				except Exception as e:
					print (e)
				finally:
					cursor.close()
					conn.close()
		if not flag:
			print("Insert")
			insertNewRow(or_user_id)
	else:
		print("Insert New")
		insertNewRow(or_user_id)


