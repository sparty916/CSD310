#PJ ELLIS - MODULE 7
#MOVIES QUERY
#11/24/2022

#connect to database
import mysql.connector

mydb = mysql.connector.connect(
    user="movies_user",
    password="popcorn",
    host="localhost",
    database="movies"
)
#Query 1 - Select all the fields for studio tables
print("-- DISPLAYING Studio RECORDS --")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM studio')

studio = cursor.fetchall()

for studio in studio:
    print("Studio ID: {}\nStudio Name: {}\n".format(studio[0], studio[1]))

#Query 2 - Select all the fields for genre tables
print("-- DISPLAYING Genre RECORDS --")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM genre')

genre = cursor.fetchall()

for genre in genre:
    print("Genre ID: {}\nGenre Name: {}\n".format(genre[0], genre[1]))

#Query 3 - Select the movie names for movies with a run time less than two hours
print("-- DISPLAYING Short Film RECORDS --")

cursor = mydb.cursor()

cursor.execute('SELECT film_name, film_runtime FROM film WHERE film_runtime < 120')

runtime = cursor.fetchall()

for runtime in runtime:
    print("Film Name: {}\nRuntime: {}\n".format(runtime[0], runtime[1]))

#Query 4 - Get a list of film names and directors grouped by Director
print("-- DISPLAYING Director RECORDS in Order --")

cursor = mydb.cursor()

cursor.execute('SELECT film_name, film_director FROM film ORDER BY film_director')

film = cursor.fetchall()

for film in film:
    print("Film Name: {}\nDirector: {}\n".format(film[0], film[1]))
