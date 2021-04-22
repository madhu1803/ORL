import tracking_config
# import pymysql
# from db import mysql
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

def track_visitor():
	if not tracking_config.is_tracking_allowed():
		return
	else:		
		print("track visitor else 1st")
		ip_address = request.remote_addr
		requested_url = request.url
		referer_page = request.referrer
		page_name = request.path
		query_string = request.query_string
		user_agent = request.user_agent.string
				
		if tracking_config.track_session():
			print("Log Check")
			log_id = session['log_id'] if 'log_id' in session else 0
			no_of_visits = session['no_of_visits']
			current_page = request.url
			previous_page = session['current_page'] if 'current_page' in session else ''
			print("log id")
			print(log_id)
			# print("visits")
			# print(no_of_visits)
			# print("Current")
			# print(current_page)
			# print("Previous")
			# print(previous_page)
			
			if previous_page != current_page:
				print("track visiton else 1 if")
				
				log_visitor(ip_address, requested_url, referer_page, page_name, query_string, user_agent, no_of_visits)
		else:	
			print("track visitor else 2nd")
			conn = None
			cursor = None
			
			session.modified = True
			
			try:
				print("Try")				
				conn = mysql.connector.connect(**config)
				cursor = conn.cursor()
				
				log_id = log_visitor(ip_address, requested_url, referer_page, page_name, query_string, user_agent)
				
				print('log_id', log_id)
				session['log_id'] = log_id
				
				if log_id > 0:				
					sql = 'select max(count) as next from visits limit 1'
					
					conn = mysql.connector.connect(**config)
					cursor = conn.cursor(dictionary=True)
					
					cursor.execute(sql)
					row = cursor.fetchone()
					
					count = 0
					if row['next']:
						count += 1
					else:
						count = 1
					
					sql = 'UPDATE visits set count = %s WHERE log_id = %s'
					data = (count, log_id,)
					
					cursor.execute(sql, data)
					
					conn.commit()
					
					session['track_session'] = True
					session['no_of_visits'] = count
					session['current_page'] = requested_url				
				else:
					session['track_session'] = False
			except Exception as e:
				print(e)
				session['track_session'] = False
			finally:
				cursor.close()
				conn.close()
				
def log_visitor(ip_address, requested_url, referer_page, page_name, query_string, user_agent, no_of_visits=None):
	sql = None
	data = None
	conn = None
	cursor = None
	log_id = 0
	print("User")
	print(session['user'])
	if no_of_visits == None:
		print("1st query")
		sql = "INSERT INTO visits(count, user_id, ip_address, requested_url, referer_page, query_string, user_agent) VALUES(%s, %s, %s, %s, %s, %s, %s)"
		data = (no_of_visits, session['user'], ip_address, requested_url, referer_page, query_string, user_agent,)
	else:
		print("2nd Query")
		sql = "INSERT INTO visits(ip_address, user_id, requested_url, referer_page, query_string, user_agent) VALUES(%s, %s, %s, %s, %s, %s)"
		data = (ip_address, session['user'], requested_url, referer_page, query_string, user_agent,)
	
	try:	
		print("Try 2")			
		conn = mysql.connector.connect(**config)
		cursor = conn.cursor()
		
		cursor.execute(sql, data)
		
		conn.commit()
		
		log_id = cursor.lastrowid
		
		return log_id
	except Exception as e:
		print("exception 2")
		print(e)
	finally:
		cursor.close()
		conn.close()