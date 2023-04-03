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

-- 9
SELECT name
FROM Company t1
         JOIN Trip t2 ON t1.id = t2.company
WHERE t2.town_from LIKE 'Vladivostok'

-- 10
SELECT *
FROM Trip
WHERE time_out BETWEEN '1900-01-01 10:00:00' AND '1900-01-01 14:00:00'

-- 11
SELECT name
FROM Passenger
WHERE LENGTH(name) IN (
    SELECT MAX(LENGTH(name))
    FROM Passenger
)

-- 12
SELECT trip,
       COUNT(passenger) as count
FROM Pass_in_trip
GROUP BY trip

-- 13
SELECT name
FROM Passenger
GROUP BY name
HAVING COUNT(name) > 1

-- 14
SELECT town_to
FROM Trip t1
         JOIN Pass_in_trip t2 ON t1.id = t2.trip
         JOIN Passenger t3 ON t2.passenger = t3.id
WHERE t3.name LIKE 'Bruce Willis'

-- 15
SELECT time_in
FROM Trip t1
         JOIN Pass_in_trip t2 ON t1.id = t2.trip
         JOIN Passenger t3 ON t2.passenger = t3.id
WHERE t3.name LIKE 'Steve Martin'
  AND t1.town_to LIKE 'London'

-- 16
SELECT t1.name,
       COUNT(t2.trip) count
FROM Passenger t1
    JOIN Pass_in_trip t2 ON t1.id = t2.passenger
GROUP BY t2.passenger
HAVING COUNT(t2.trip) >= 1
ORDER BY COUNT(t2.trip) DESC,
    t1.name

-- 17
SELECT t1.member_name,
       t1.status,
       SUM(amount * unit_price) costs
FROM FamilyMembers t1
         JOIN Payments t2 ON t1.member_id = t2.family_member
WHERE YEAR(t2.date) = '2005'
GROUP BY t1.member_name,
    t1.status

-- 18
SELECT member_name
FROM FamilyMembers
GROUP BY member_name
HAVING MAX(NOW() - birthday)
ORDER BY MAX(NOW() - birthday) DESC
    LIMIT 1

-- 19
SELECT DISTINCT t1.status
FROM FamilyMembers t1
         JOIN Payments t2 ON t1.member_id = t2.family_member
         JOIN Goods t3 ON t2.good = t3.good_id
WHERE t3.good_name LIKE 'potato'

-- 20
SELECT t1.status,
       t1.member_name,
       SUM(t2.unit_price * t2.amount) costs
FROM FamilyMembers t1
         JOIN Payments t2 ON t1.member_id = t2.family_member
         JOIN Goods t3 ON t2.good = t3.good_id
         JOIN GoodTypes t4 ON t3.type = t4.good_type_id
WHERE t4.good_type_name LIKE 'entertainment'
GROUP BY t1.status,
         t1.member_name

-- 21
SELECT t1.good_name
FROM Goods t1
         JOIN Payments t2 ON t1.good_id = t2.good
GROUP BY t2.good
HAVING COUNT(t2.good) > 1

-- 22
SELECT member_name
FROM FamilyMembers
WHERE status LIKE 'mother'