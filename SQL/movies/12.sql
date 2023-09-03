SELECT title FROM movies, stars, people
WHERE movies.id = stars.movie_id
AND name = "Johnny Depp"
AND people.id = stars.person_id
AND title in (
    SELECT title FROM movies, stars, people
    WHERE movies.id = stars.movie_id
    AND name = "Helena Bonham Carter"
    AND people.id = stars.person_id
    );