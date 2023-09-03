SELECT DISTINCT name FROM people, stars
WHERE id = person_id
AND NOT name = "Kevin Bacon"
AND stars.movie_id IN (
    SELECT movie_id FROM people, stars
    WHERE name = "Kevin Bacon"
    AND birth = 1958
    AND id = person_id
    )
ORDER BY name;