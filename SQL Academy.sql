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

-- 23
SELECT t1.good_name, MAX(t2.unit_price * t2.amount) unit_price
FROM Goods t1
         JOIN Payments t2 ON t1.good_id = t2.good
         JOIN GoodTypes t3 ON t1.type = t3.good_type_id
WHERE t3.good_type_name LIKE 'delicacies'
GROUP BY t1.good_name
ORDER BY MAX(t2.unit_price * t2.amount) DESC
    LIMIT 1

-- 24
SELECT t1.member_name, SUM(t2.unit_price * t2.amount) costs
FROM FamilyMembers t1
         JOIN Payments t2 ON t1.member_id = t2.family_member
WHERE t2.date BETWEEN '2005-06-01' AND '2005-06-30'
GROUP BY t1.member_name

-- 25
SELECT good_name
FROM Goods
WHERE good_id NOT IN (
    SELECT good
    FROM Payments
    WHERE YEAR(date) = 2005
)

-- 26
SELECT DISTINCT good_type_name
FROM GoodTypes t1
         INNER JOIN Goods t2 ON t1.good_type_id = t2.type
WHERE t1.good_type_id NOT IN (
    SELECT good_type_id
    FROM GoodTypes t1
             JOIN Goods t2 ON t1.good_type_id = t2.type
             JOIN Payments t3 ON t2.good_id = t3.good
    WHERE YEAR(date) = 2005
)

-- 27
SELECT t1.good_type_name, SUM(unit_price * amount) costs
FROM GoodTypes t1
         JOIN Goods t2 ON t1.good_type_id = t2.type
         JOIN Payments t3 ON t2.good_id = t3.good
WHERE YEAR(t3.date) = '2005'
GROUP BY t1.good_type_name

-- 28
SELECT COUNT(*) count
FROM Trip
WHERE town_from LIKE 'Rostov' AND town_to LIKE 'Moscow'

-- 29
SELECT DISTINCT t1.name
FROM Passenger t1
         JOIN Pass_in_trip t2 ON t1.id = t2.passenger
         JOIN Trip t3 ON t2.trip = t3.id
WHERE town_to LIKE 'Moscow' AND plane LIKE 'TU-134'

-- 30
SELECT trip, COUNT(*) count
FROM Pass_in_trip
GROUP BY trip
ORDER BY count DESC

-- 31
SELECT *
FROM FamilyMembers
WHERE member_name LIKE '%Quincey'

-- 32
SELECT FLOOR(AVG(FLOOR(DATEDIFF(NOW(), birthday) / 365))) age
FROM FamilyMembers

-- 33
SELECT AVG(unit_price) cost
FROM Goods t1
         INNER JOIN Payments t2 ON t1.good_id = t2.good
WHERE good_name = 'red caviar' OR good_name = 'black caviar'

-- 34
SELECT COUNT(*) count
FROM Class
WHERE name LIKE '10%'

-- 35
SELECT DISTINCT COUNT(*) count
FROM Class t1
    JOIN Schedule t2 ON t1.id = t2.class
WHERE date = '2019-09-02'

-- 36
SELECT *
FROM Student
WHERE address LIKE 'ul. Pushkina%'

-- 37
SELECT FLOOR(MIN(DATEDIFF(NOW(), birthday) / 365)) year
FROM Student
-- или
SELECT MIN(TIMESTAMPDIFF(YEAR, birthday, CURRENT_DATE)) year
FROM Student

-- 38
SELECT COUNT(*) count
FROM Student
WHERE first_name = 'Anna'

-- 39
SELECT COUNT(*) count
FROM Class t1
    JOIN Student_in_class t2 ON t1.id = t2.class
WHERE t1.name = '10 B'

-- 40
SELECT DISTINCT name subjects
FROM Subject t1
         JOIN Schedule t2 ON t1.id = t2.subject
         JOIN Teacher t3 ON t2.teacher = t3.id
WHERE t3.first_name = 'Pavel' AND t3.middle_name = 'Petrovich'
  AND t3.last_name = 'Romashkin'

-- 41
SELECT start_pair
FROM Timepair
WHERE id = 4

-- 42
SELECT SEC_TO_TIME(SUM(TIMEDIFF(end_pair, start_pair))) time
FROM Timepair
WHERE id = 2 OR id = 4

-- 43
SELECT t1.last_name
FROM Teacher t1
         JOIN Schedule t2 ON t1.id = t2.teacher
         JOIN Subject t3 ON t2.subject = t3.id
WHERE t3.name LIKE 'Physical Culture'
ORDER BY t1.last_name

-- 44
SELECT FLOOR(DATEDIFF(NOW(), t1.birthday) / 365) max_year
FROM Student t1
         JOIN Student_in_class t2 ON t1.id = t2.student
         JOIN Class t3 ON t2.class = t3.id
WHERE t3.name LIKE '10%'
ORDER BY birthday
    LIMIT 1

-- 45
SELECT classroom
FROM Schedule
GROUP BY classroom
HAVING COUNT(classroom) = (
    SELECT COUNT(classroom)
    FROM Schedule
    GROUP BY classroom
    ORDER BY COUNT(classroom) DESC
    LIMIT 1
)

-- 46
SELECT DISTINCT t3.name
FROM Teacher t1
         JOIN Schedule t2 ON t1.id = t2.teacher
         JOIN Class t3 ON t2.class = t3.id
WHERE t1.last_name LIKE 'Krauze'

-- 47
SELECT COUNT(*) count
FROM Teacher t1
    JOIN Schedule t2 ON t1.id = t2.teacher
WHERE t1.last_name LIKE 'Krauze' AND t2.date = '2019-08-30'

-- 48
SELECT name, COUNT(t2.student) count
FROM Class t1
    JOIN Student_in_class t2 ON t1.id = t2.class
GROUP BY t2.class
ORDER BY count DESC

-- 49
SELECT (
    SELECT COUNT(t2.student)
    FROM Class t1
        JOIN Student_in_class t2 ON t1.id = t2.class
    WHERE t1.name LIKE '10 A'
) / (
    SELECT COUNT(t2.student)
    FROM Class t1
             JOIN Student_in_class t2 ON t1.id = t2.class
) * 100 percent
-- или
SELECT COUNT(t1.student) * 100 / (SELECT COUNT(student) FROM Student_in_class) AS percent
FROM Student_in_class t1
    JOIN Class t2 ON t1.class = t2.id
WHERE name = '10 A'

-- 50
SELECT FLOOR((COUNT(*) * 100 / (SELECT COUNT(*) FROM Student))) percent
FROM Student
WHERE YEAR(birthday) = '2000'

-- 51
INSERT INTO Goods
SET good_id = (SELECT COUNT(*) + 1 FROM Goods t),
    good_name = 'Cheese',
    type = (
        SELECT good_type_id FROM GoodTypes
        WHERE good_type_name = 'food'
    )
-- или
INSERT INTO Goods VALUES (
    (SELECT COUNT(*) + 1 FROM Goods t),
    'Cheese',
    (SELECT good_type_id FROM GoodTypes
    WHERE good_type_name = 'food')
    )

-- 52
INSERT INTO GoodTypes VALUES (
    (SELECT COUNT(*) + 1 FROM GoodTypes t),
    'auto'
    )

-- 53
UPDATE FamilyMembers
SET member_name = 'Andie Anthony'
WHERE member_name = 'Andie Quincey'

-- 54
DELETE FROM FamilyMembers
WHERE member_name LIKE '%Quincey'

-- 55
DELETE FROM Company
WHERE id IN (
    SELECT company
    FROM Trip
    GROUP BY company
    HAVING COUNT(*) = (
        SELECT COUNT(company)
        FROM Trip
        GROUP BY company
        ORDER BY COUNT(*)
        LIMIT 1
    )
)

-- 56
DELETE FROM Trip
WHERE town_from LIKE 'Moscow'

-- 57
UPDATE Timepair
SET start_pair = ADDDATE(start_pair, INTERVAL 30 MINUTE),
    end_pair = ADDDATE(end_pair, INTERVAL 30 MINUTE)
-- или
UPDATE Timepair
SET start_pair = start_pair + INTERVAL 30 MINUTE,
    end_pair = end_pair + INTERVAL 30 MINUTE

-- 58
INSERT INTO Reviews (id, reservation_id, rating)
SELECT
    (SELECT COUNT(*) + 1 FROM Reviews) id,
    t2.id reservation_id,
    '5'
FROM Rooms t1
         JOIN Reservations t2 ON t1.id = t2.room_id
         JOIN Users t3 ON t2.user_id = t3.id
WHERE address = '11218, Friel Place, New York' AND
        t3.name = 'George Clooney'

-- 59
SELECT *
FROM Users
WHERE phone_number LIKE '+375%'

-- 60
SELECT t1.teacher
FROM Schedule t1
         JOIN Class t2 ON t1.class = t2.id
WHERE t2.name LIKE '11%'
GROUP BY t1.teacher
HAVING COUNT(DISTINCT t2.name) = (
    SELECT COUNT(id)
    FROM Class
    WHERE name LIKE '11%'
)

-- 61
SELECT t1.*
FROM Rooms t1
         JOIN Reservations t2 ON t1.id = t2.room_id
WHERE WEEK(start_date, 1) = 12 AND YEAR(start_date) = 2020

-- 62
SELECT SUBSTRING_INDEX(email, '@', -1) domain,
COUNT(SUBSTRING_INDEX(email, '@', -1)) count
FROM Users
GROUP BY domain
ORDER BY count DESC, domain

-- 63
SELECT CONCAT(last_name, '.', SUBSTRING(first_name, 1, 1), '.') name
FROM Student
ORDER BY name

-- 64
SELECT YEAR(start_date) year, MONTH(start_date) month, COUNT(*) amount
FROM Reservations
GROUP BY year, month
HAVING amount >= 1
ORDER BY year, month

-- 65
SELECT room_id, FLOOR(AVG(t2.rating)) rating
FROM Reservations t1
         JOIN Reviews t2 ON t1.id = t2.reservation_id
         JOIN Rooms t3 ON t1.room_id = t3.id
GROUP BY t1.room_id

-- 66
SELECT t1.home_type, t1.address,
       IFNULL(SUM(DATEDIFF(t2.end_date, t2.start_date)), 0) days,
       IFNULL(SUM(t2.total), 0) total_fee
FROM Rooms t1
         LEFT JOIN Reservations t2 ON t1.id = t2.room_id
WHERE t1.has_tv = 1 AND t1.has_internet = 1 AND t1.has_kitchen = 1
  AND t1.has_air_con = 1
GROUP BY t1.id