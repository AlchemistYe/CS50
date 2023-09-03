-- Keep a log of any SQL queries you execute as you solve the mystery.
SELECT *
FROM crime_scene_reports
WHERE year = 2021
AND month = 7
AND day = 28
AND street = "Humphrey Street"
AND description LIKE "%duck%";
-- something important in description: 10:15am at bakery. Three witnesses all mentioned the bakery
SELECT *
FROM interviews
WHERE year = 2021
AND month = 7
AND day = 28
AND transcript LIKE "%bakery%";
-- 10:15 ~ 10:25am theft's car left
-- Eugene: recognized. theft withdrew money from ATM on Leggett Street
-- A call with accomplice at about 10:15am as to helping the theft buy earliest flight out of Fiftyville on 29th.
CREATE TEMPORARY TABLE suspect AS
    SELECT *
    FROM people
    WHERE license_plate IN
        (SELECT license_plate
        FROM bakery_security_logs
        WHERE year = 2021
        AND month = 7
        AND day = 28
        AND hour = 10
        AND minute >= 15 AND minute <= 25)
    AND phone_number IN
        (SELECT caller
        FROM phone_calls
        WHERE year = 2021
        AND month = 7
        AND day = 28
        AND duration <= 60);
--
CREATE TEMPORARY TABLE suspect_2 AS
    SELECT *
    FROM people
    WHERE id IN
        (SELECT person_id
        FROM bank_accounts
        WHERE account_number IN
            (SELECT account_number
            FROM atm_transactions
            WHERE year = 2021
            AND month = 7
            AND day = 28
            AND atm_location = "Leggett Street"
            AND transaction_type = "withdraw"))
    AND id IN
        (SELECT id
        FROM suspect);
SELECT *
FROM suspect_2;
--
CREATE TEMPORARY TABLE calls AS
    SELECT caller, receiver
    FROM phone_calls
    WHERE year = 2021
    AND month = 7
    AND day = 28
    AND duration <= 60
    AND caller in
        (SELECT phone_number
        FROM suspect_2);
CREATE TEMPORARY TABLE accomplice AS
    SELECT *
    FROM people
    WHERE phone_number IN
        (SELECT receiver
        FROM calls);
SELECT *
FROM accomplice;
SELECT *
FROM calls
WHERE caller IN
    (SELECT caller
    FROM suspect_2);
-- narrow down the range of suspects and accomplices
-- next find the flight
CREATE TEMPORARY TABLE fli AS
    SELECT *
    FROM passengers
    WHERE flight_id in
        (SELECT id
        FROM flights
        WHERE year = 2021
        AND month = 7
        AND day = 29
        AND origin_airport_id =
            (SELECT id
            FROM airports
            WHERE city = "Fiftyville"))
    AND passport_number IN
        (SELECT passport_number
        FROM suspect_2);
SELECT *
FROM fli;
--
SELECT city
FROM airports
WHERE id =
    (SELECT destination_airport_id
    FROM flights
    WHERE id IN
        (SELECT flight_id
        FROM fli)
    ORDER BY hour ASC
    LIMIT 1);
-- Now we find the passport_number of the theft
-- Theft: Bruce
-- Accomplice: Robin
-- City of destination: New York City
DROP TABLE suspect;
DROP TABLE suspect_2;
DROP TABLE calls;
DROP TABLE accomplice;
DROP TABLE fli;
-- drop the temporary table


