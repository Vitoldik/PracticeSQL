/*
    В этом файле будут мои варианты решения задач
    с сайта sql-academy.org.
*/

-- 1
SELECT name
FROM Passenger

-- 2
SELECT name
FROM Company

-- 3
SELECT *
FROM Trip
WHERE town_from LIKE 'Moscow'

-- 4
SELECT name
FROM Passenger
WHERE name LIKE '%man'

-- 5
SELECT COUNT(*) as count
FROM Trip
WHERE plane LIKE 'TU-134'

-- 6
SELECT DISTINCT name
FROM Company t1
         JOIN Trip t2 ON t1.id = t2.company
WHERE t2.plane LIKE 'Boeing'

-- 7
SELECT DISTINCT plane
FROM Trip
WHERE town_to LIKE 'Moscow'

-- 8
SELECT town_to,
       TIMEDIFF(time_in, time_out) flight_time
FROM Trip
WHERE town_from LIKE 'Paris'