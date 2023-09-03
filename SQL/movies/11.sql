SELECT title FROM stars, people, ratings, movies
WHERE people.name = "Chadwick Boseman"
AND stars.movie_id = ratings.movie_id
AND movies.id = stars.movie_id
AND stars.person_id = people.id
ORDER BY rating DESC
LIMIT 5;