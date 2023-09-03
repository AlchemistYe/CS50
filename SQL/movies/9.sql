SELECT DISTINCT people.name FROM people, stars, movies
WHERE movies.year = 2004
AND stars.movie_id = movies.id
AND people.id = stars.person_id
ORDER BY birth