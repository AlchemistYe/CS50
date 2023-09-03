SELECT name FROM people, stars, movies
WHERE movies.title = 'Toy Story'
AND stars.movie_id = movies.id
AND people.id = stars.person_id