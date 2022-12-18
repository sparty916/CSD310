# pj ellis - module 10
# creating database

import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="DANcer5627!"
)

mycursor = mydb.cursor()

mycursor.execute("CREATE DATABASE outlandadventures")
