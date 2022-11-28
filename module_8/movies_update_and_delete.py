# PJ ELLIS - MODULE 8
# Movie Database Update and Delete
# 11/24/2022

#connect to database
import mysql.connector

mydb = mysql.connector.connect(
    user="movies_user",
    password="popcorn",
    host="localhost",
    database="movies"
)

cursor = mydb.cursor()

def show_films(cursor, title):
    # method to execute an inner join on all tables.
    # iterate over the dataset and output the results to the terminal window.

    # inner join query
    cursor.execute("SELECT film_name AS Name, film_director AS Director, genre_name as Genre, studio_name as Studio "
                   "FROM film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio ON "
                   "film.studio_id=studio.studio_id")

    # get the results from the cursor object
    films = cursor.fetchall()

    print("\n -- {} --".format(title))

    # iterate over the film data set and display the results
    for film in films:
        print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(film[0], film[1], film[2], film[3]))

#call the function
show_films(cursor, "DISPLAYING FILMS")

#Next Item
#Insert a new record into film
sqlInsert = "INSERT INTO film (film_name, film_releaseDate, film_runtime, film_director, studio_id, genre_id) VALUES ('Jurassic Park', '1993', '127', 'Steven Spielberg', '3', '2')"
cursor.execute(sqlInsert)
mydb.commit() #commit is required to make changes otherwise no changes are made to table

#call the function
show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

#Next Item
#Update the film Alien to a Horror Film
sqlUpdate = "UPDATE film SET genre_id = '1' WHERE film_name = 'Alien'"
cursor.execute(sqlUpdate)
mydb.commit()

#call the function
show_films(cursor, "DISPLAYING FILMS AFTER UPDATE - Changes Alien to Horror")

#Next Item
#Delete the Movie Gladiator
sqlDelete = "DELETE FROM film WHERE film_name = 'Gladiator'"
cursor.execute(sqlDelete)
mydb.commit()

#call the function
show_films(cursor, "DISPLAYING FILMS AFTER DELETE")
