SELECT title, rating FROM movies, ratings
WHERE movies.id = ratings.movie_id
AND movies.year = 2010
AND ratings.rating IS NOT NULL
ORDER BY rating DESC, title ASC;