/*
	
	[02] Урок 2. Фильтрация строк WHERE. Регулярные выражения LIKE. AND и OR
	
*/

SELECT *
FROM products
WHERE ProductName = 'Tofu'

SELECT * 
FROM `products` 
WHERE CategoryID = 3

SELECT * 
FROM `products` 
WHERE UnitPrice >= 10

SELECT * 
FROM `products` 
WHERE UnitPrice <> 10 -- больше, меньше

SELECT * 
FROM `products` 
WHERE UnitPrice != 10

-- IN
SELECT *
FROM Products
WHERE ProductName IN ('Tofu', 'Konbu', 'Chang')

-- IS NULL IS NOT NULL
SELECT *
FROM Customers
WHERE region is not null

/*
	Шаблонные выражения - выражения для поиска строк по шаблонам
	-- LIKE
*/

SELECT ContactName, ContactTitle
FROM Customers
WHERE ContactTitle = 'Sales Manager'

SELECT ContactName, ContactTitle
FROM Customers
WHERE ContactTitle LIKE 'Sales%'

SELECT ContactName, ContactTitle
FROM Customers
WHERE ContactName LIKE 'A%'

SELECT ContactName, ContactTitle
FROM Customers
WHERE ContactTitle LIKE '%Manager'

SELECT ContactName, ContactTitle
FROM Customers
WHERE ContactTitle LIKE '%Sales%'

/*
	OR, AND, BETWEEN
*/

-- OR
SELECT ContactName, city, Country
FROM Customers
WHERE Country = 'France'
OR city = 'London'

-- AND
SELECT ContactName, city, Country
FROM Customers
WHERE Country = 'France'
AND city LIKE 'L%' 

-- BETWEEN
SELECT ProductName, UnitPrice
FROM products
WHERE UnitPrice > 10 AND UnitPrice < 15

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice between 10 and 15


-- Приоритеты AND и OR

SELECT Productid, UnitPrice
FROM Products
WHERE ProductID = 1 OR ProductID = 2 AND UnitPrice = 19 -- Вначале выполняется AND

SELECT Productid, UnitPrice
FROM Products
WHERE (ProductID = 1 OR ProductID = 2) AND UnitPrice = 19


-- Решение задач

SELECT COUNT(*) 
FROM `Products` 
WHERE UnitPrice > 100

SELECT COUNT(*) 
FROM `customers` 
WHERE `Country` = 'Spain'

SELECT City
FROM `customers` 
WHERE City LIKE 'W%'

SELECT COUNT(*)
FROM `customers` 
WHERE `Phone` LIKE '%5555%'

SELECT ContactName
FROM `customers`
WHERE `Country` = 'USA' AND `ContactTitle` = 'Marketing Assistant'

SELECT ProductName, UnitPrice 
FROM `products`
WHERE `UnitPrice` > 100 OR `ProductName` = 'Chai'

/*

	[03] Урок 3. Сортировка строк ORDER BY

*/

-- Сортировка по 1 полю
SELECT ProductName, CategoryID, UnitPrice
FROM Products
ORDER BY UnitPrice -- от меньшего к большему (пишется всегда в конце)

SELECT ProductName, CategoryID, UnitPrice
FROM Products
ORDER BY UnitPrice DESC -- сортировка от большего к меньшему

-- Сортировка по 2 полям
SELECT ProductName, CategoryID, UnitPrice
FROM Products
WHERE UnitPrice < 10
ORDER BY CategoryID ASC, UnitPrice DESC

-- Решение задач
SELECT `Freight` 
FROM `orders` 
WHERE `OrderDate` = '1998-02-26 00:00:00.000'
ORDER BY `Freight` DESC

SELECT `EmployeeID`, `Freight`
FROM `orders` 
WHERE `OrderDate` = '1998-02-26 00:00:00.000'
ORDER BY `EmployeeID`, `Freight`

/*

	[04] Урок 4. Агрегирующие функции: COUNT, SUM, MIN, MAX, AVG. Алиасы

*/

SELECT COUNT(*)
FROM Customers
WHERE Country = 'Canada'

SELECT COUNT(*), COUNT(ContactTitle), COUNT(city), COUNT(Country)
FROM Customers

-- DISTINCT исключение повторений
SELECT COUNT(DISTINCT Country)
FROM Customers

SELECT MIN(UnitPrice) `минимальная цена`, MAX(UnitPrice) `максимальная цена`, AVG(UnitPrice) `средняя цена товара`, SUM(UnitPrice) `сумма всех цен`, COUNT(UnitPrice) `количество товаров`
FROM Products

-- Решение задач
SELECT MIN(`CategoryID`) `min_price`, MAX(`CategoryID`) `max_price`, AVG(`CategoryID`) `avg_price`
FROM `products`
WHERE `CategoryID` = 3

SELECT COUNT(DISTINCT `ContactTitle`) 
FROM `Customers` 
WHERE `Country` = 'UK'

SELECT SUM(`UnitPrice`) 
FROM `products` 
WHERE CategoryID IN (4, 5)

/*

	[05] Урок 5. Группировка строк GROUP BY и HAVING

*/

SELECT CustomerID, ContactName, ContactTitle, Country
FROM Customers

SELECT Country, COUNT(*)
FROM Customers
WHERE Country != 'Germany' -- фильтрация начального списка
GROUP BY Country
HAVING COUNT(*) > 10 -- фильтрация сгруппированных строк

SELECT CategoryID, COUNT(*), MIN(UnitPrice), MAX(UnitPrice), AVG(UnitPrice), SUM(UnitPrice)
FROM Products
WHERE CategoryID <> 8
GROUP BY CategoryID
HAVING COUNT(*) > 10

-- Группировка по нескольким столбцам
SELECT Country, COUNT(*)
FROM Customers
WHERE ContactTitle = 'Marketing Manager'
GROUP BY Country

SELECT Country, ContactTitle, COUNT(*)
FROM Customers
GROUP BY Country, ContactTitle
HAVING COUNT(*) > 1
ORDER BY Country, ContactTitle

SELECT OrderID, SUM(Quantity * UnitPrice * (1 - Discount))
FROM `Order Details`
GROUP BY OrderID

SELECT SUM(Quantity * UnitPrice * (1 - Discount))
FROM `Order Details`
WHERE OrderID = 10251

-- Решение задач
SELECT `City`, COUNT(*)
FROM `customers` 
GROUP BY `City`
HAVING COUNT(*) > 4

SELECT `CategoryID`, AVG(`UnitPrice`)
FROM `products` 
GROUP BY `CategoryID`
ORDER BY AVG(`UnitPrice`) DESC

SELECT OrderDate, COUNT(*)
FROM orders
WHERE OrderDate BETWEEN '1998-03-01 00:00:00.000' AND '1998-03-31 00:00:00.000'
GROUP BY OrderDate
HAVING COUNT(*) = 4

SELECT OrderID, SUM(`UnitPrice` * `Quantity` * (1 - `Discount`))
FROM `order details` 
GROUP BY `OrderID`
HAVING SUM(`UnitPrice` * `Quantity` * (1 - `Discount`))

/*
	
	[06] Практика по итогам первых 5 уроков
	
*/

SELECT COUNT(*) 
FROM `customers` 
WHERE `ContactTitle` LIKE '%Sales%' AND `Region` IS NULL

SELECT `ContactTitle`, COUNT(*) 
FROM `customers` 
GROUP BY `ContactTitle`
ORDER BY COUNT(`ContactTitle`) DESC

SELECT `CategoryID`, MIN(`UnitPrice`) min_price, MAX(`UnitPrice`) max_price, MAX(`UnitPrice`) - MIN(`UnitPrice`) max_min
FROM `products` 
GROUP BY `CategoryID`
ORDER BY MAX(`UnitPrice`) - MIN(`UnitPrice`) DESC

SELECT `OrderID`, SUM(`Quantity`)
FROM `order details` 
GROUP BY `OrderID`
ORDER BY SUM(`Quantity`) DESC

SELECT `OrderID` `номер_заказа`, SUM(`UnitPrice` * `Quantity` * `Discount`) `скидка`
FROM `order details` 
GROUP BY `OrderID`
HAVING SUM((`UnitPrice` * `Quantity`) * `Discount`) > 3000
ORDER BY `UnitPrice` * `Quantity` * `Discount` DESC

/*

	[07] Урок 6.  Понятия первичный ключ и внешний ключ. Типы связей в БД

*/

/*
	Типы связей:
	
	1. Один ко многим
	2. Один к одному
	3. Многие ко многим
*/

/*

	[08] Урок 7. Формирование запросов из нескольких таблиц. INNER JOIN и Aлиасы

	JOIN операторы, необходимые для объединения нескольких таблиц по общему ключу

*/

SELECT Products.CategoryID, CategoryName, ProductName 
FROM `Products` 
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Seafood'

SELECT t1.CategoryID, CategoryName, ProductName 
FROM `Products` t1
INNER JOIN Categories t2 ON t1.CategoryID = t2.CategoryID
WHERE CategoryName = 'Seafood'

SELECT t2.City, COUNT(*), COUNT(DISTINCT t2.CustomerID) 
FROM `orders` t1
INNER JOIN `customers` t2 ON t1.CustomerID = t2.CustomerID
WHERE t2.Country = 'Germany'
GROUP BY t2.City
ORDER BY COUNT(*) DESC

SELECT t2.ProductName, SUM(t1.UnitPrice * t1.Quantity * (1 - Discount))
FROM `order details` t1
INNER JOIN `products` t2 ON t1.ProductID = t2.ProductID
WHERE CategoryID = 1
GROUP BY t2.ProductName

SELECT * 
FROM `orders` t1
INNER JOIN `employees` t2 ON t1.EmployeeID = t2.EmployeeID
INNER JOIN Customers t3 ON t1.CustomerID = t3.CustomerID

SELECT DISTINCT t3.ContactTitle 
FROM `orders` t1
INNER JOIN `employees` t2 ON t1.EmployeeID = t2.EmployeeID
INNER JOIN Customers t3 ON t1.CustomerID = t3.CustomerID
WHERE t2.FirstName = 'Robert' and t2.LastName = 'King'

SELECT COUNT(*) 
FROM `orders` t1
INNER JOIN `employees` t2 ON t1.EmployeeID = t2.EmployeeID
WHERE t2.FirstName = 'Andrew' AND t2.LastName = 'Fuller'

-- Решение задач
SELECT COUNT(*) 
FROM `orders` t1
INNER JOIN `employees` t2 USING (EmployeeID)
WHERE t2.FirstName = 'Andrew' AND t2.LastName = 'Fuller'

SELECT SUM(t1.UnitPrice * t1.Quantity * (1 - t1.Discount))
FROM `order details` t1
INNER JOIN `orders` t2 USING (OrderID)
WHERE YEAR(t2.OrderDate) = '1997'

SELECT t2.CategoryName, COUNT(*)
FROM `products` t1
INNER JOIN `categories` t2 USING (CategoryID)
GROUP BY t2.CategoryName

SELECT DISTINCT t3.FirstName, t3.LastName 
FROM `customers` t1 
INNER JOIN `orders` t2 USING (CustomerID)
INNER JOIN `employees` t3 USING (EmployeeID)
WHERE t1.ContactName = 'Francisco Chang'

/*

	[09] Урок 8. LEFT JOIN и остальные виды JOIN-ов

	LEFT JOIN - тип соединения, при котором в любом случае выведутся все строки левой таблицы, 
	вне зависимости есть ли ключи в другой
	
	RIGHT JOIN - тип соединения, при котором в любом случае выведутся все строки правой таблицы, 
	вне зависимости есть ли ключи в другой
	
	FULL JOIN - выведет все строки с левой таблицы и правой
	
	CROSS JOIN - декартово произведение, каждая строка из левой таблицы объединится с правой (получим все возможные пары)
*/

SELECT COUNT(DISTINCT t1.CustomerID) -- расчет количества клиентов, у которых нет заказов
FROM `customers` t1
LEFT JOIN Orders t2 ON t1.CustomerID = t2.CustomerID
WHERE t2.OrderID IS NULL

SELECT ContactName, COUNT(DISTINCT t2.OrderID) -- количество заказов каждого клиента
FROM `customers` t1
LEFT JOIN Orders t2 ON t1.CustomerID = t2.CustomerID
GROUP BY ContactName
ORDER BY COUNT(DISTINCT t2.OrderID)

-- Решение задач
SELECT t1.ContactName, t1.City
FROM `customers` t1
LEFT JOIN `orders` t2 USING (CustomerID)
WHERE t2.OrderID IS NULL AND t1.City IS NOT NULL

/*
	
	[10] Урок 9. Объединение нескольких таблиц с помощью UNION и UNION ALL
	
	UNION - объединяет списки выводя только уникальные должности (без дубликатов)
	UNION ALL - объединяет списки выводя все должности (с дубликатоми)
	EXCEPT - вывести должности, которые присутствуют в первой таблице, но отсутствуют во второй
	INTERSECT - вывести должности, которые присутствуют и в первой и во второй таблице
*/

SELECT Title
FROM `employees` 
UNION
SELECT ContactTitle
FROM `customers`

SELECT Title
FROM `employees` 
UNION ALL
SELECT ContactTitle
FROM `customers`

SELECT Title
FROM `employees` 
EXCEPT
SELECT ContactTitle
FROM `customers`

SELECT Title
FROM `employees` 
INTERSECT
SELECT ContactTitle
FROM `customers`

/*

	[11] Урок 10. Подзапросы

*/
SELECT COUNT(*)
FROM
	(SELECT OrderDate, COUNT(*) count
	FROM Orders
	GROUP BY OrderDate
	HAVING COUNT(*) > 2) table1
	
SELECT *
FROM Orders
WHERE customerid IN (
	SELECT customerid
	FROM Customers
	WHERE Country = 'USA'
)

-- Решение задач
SELECT COUNT(*)
FROM (
	SELECT Country, COUNT(*) count_clients
	FROM Customers
	GROUP BY Country
	HAVING COUNT(*) > 1
) table1

SELECT COUNT(*)
FROM (
	SELECT CustomerID, COUNT(*)
	FROM Orders
	GROUP BY Customerid
	HAVING COUNT(*) > 10
) table1

SELECT SUM(price)
FROM (
    SELECT UnitPrice price
    FROM Products
    WHERE categoryid = 1
) table1

SELECT SUM(Quantity * UnitPrice * (1 - Discount))
FROM `Order Details`
WHERE ProductID IN (
	SELECT ProductID
	FROM Products
	WHERE categoryid = 1
)

/*

	[12] Практика по итогам первых 10 уроков

*/

SELECT COUNT(OrderID)
FROM `order details` t1
INNER JOIN `products` t2 USING (ProductID)
WHERE ProductName = 'Chocolade'

SELECT SUM(t3.UnitPrice * t3.Quantity * (1 - t3.Discount)) 
FROM `categories` t1
INNER JOIN `products` t2 USING (CategoryID)
INNER JOIN `order details` t3 USING (ProductID)
WHERE t1.CategoryName = 'Confections' -- 177099.1000

SELECT t3.CategoryName, SUM(t1.Quantity * t1.UnitPrice * (1 - Discount))
FROM `Order Details` t1 INNER JOIN `Products` t2 USING(ProductID)
INNER JOIN `Categories` t3 USING(CategoryID)
GROUP BY t3.CategoryName
ORDER BY SUM(t1.Quantity * t1.UnitPrice * (1 - Discount)) DESC

SELECT t3.*
FROM `customers` t1
INNER JOIN `orders` t2 USING (CustomerID)
INNER JOIN `employees` t3 USING (EmployeeID)
WHERE t2.OrderDate = '1998-04-29' AND t1.ContactName = 'Simon Crowther'

SELECT COUNT(*) FROM (
	SELECT ShipCity, COUNT(*)
	FROM `orders` 
	WHERE YEAR(OrderDate) = 1997
    GROUP BY ShipCity
    HAVING COUNT(*) > 5
) table1

/*

	[13] Урок 11. Выражение CASE

*/

SELECT ContactName, City, case when region is null then 'not defined' else region end region
FROM `customers` WHERE 1

SELECT ContactName, country, CASE WHEN country IN ('Argentina', 'Brazil') THEN 'South America'
								  WHEN country = 'Canada' THEN 'North America'
								  WHEN country IN ('Spain', 'Portugal') THEN 'Europe' END continent
FROM Customers
WHERE country IN ('Argentina', 'Brazil', 'Canada', 'Spain', 'Portugal')

SELECT ContactName, country, CASE WHEN country IN ('Argentina', 'Brazil') THEN 'South America'
								  WHEN country = 'Canada' THEN 'North America'
								  ELSE 'Europe' END continent
FROM Customers
WHERE country IN ('Argentina', 'Brazil', 'Canada', 'Spain', 'Portugal')

SELECT continent, count(contactname)
FROM (
	SELECT ContactName, country, CASE WHEN country IN ('Argentina', 'Brazil') THEN 'South America'
									  WHEN country = 'Canada' THEN 'North America'
									  ELSE 'Europe' END continent
	FROM Customers
	WHERE country IN ('Argentina', 'Brazil', 'Canada', 'Spain', 'Portugal')
) table1
GROUP BY continent

-- Решение задач
SELECT COUNT(*)
FROM (
    SELECT `FirstName`, `Country`, CASE WHEN `Region` IS NULL THEN 'not defined' ELSE Region END region  
    FROM `employees`
) table1
WHERE table1.region = 'not defined'

SELECT gender, COUNT(*) 
FROM (
    SELECT `FirstName`, `LastName`, CASE WHEN `TitleOfCourtesy` IN ('Ms.', 'Mrs.') THEN 'Women' 
										 WHEN `TitleOfCourtesy` IN ('Mr.', 'Dr.') THEN 'Men' 
										 ELSE `TitleOfCourtesy` END gender
    FROM `employees`
) table1
GROUP BY gender

SELECT `segment`, COUNT(*)
FROM (
    SELECT `ProductName`, CASE WHEN `UnitPrice` BETWEEN 0 AND 9.99 THEN '0-9.99'
                          WHEN `UnitPrice` BETWEEN 10 AND 29.99 THEN '10-29.99'
                          WHEN `UnitPrice` BETWEEN 30 AND 49.99 THEN '30-49.99'
                          WHEN `UnitPrice` >= 50 THEN '50+' END `segment`
    FROM `products`
) table1
GROUP BY `segment`

/*

	[14] Урок 12. Популярные функции для работы со строками

*/

-- округление чисел
SELECT `productname`, `UnitPrice`, ROUND(`UnitPrice`, 1), ROUND(`UnitPrice`, 0)
FROM Products

SELECT `UnitPrice`, ROUND(`UnitPrice`, 0), `Discount`, ROUND(`Discount`, 1) -- Если столбец имеет тип данных REAL, FLOAT происходит не только округление, но и усечение 
FROM `order details`

SELECT ROUND(SUM(`UnitPrice` * `Quantity` * (1 - `Discount`)), 0)
FROM `order details`

-- функции по работе с датами и временем
SELECT `OrderDate`, DAY(`OrderDate`), MONTH(`OrderDate`), YEAR(`OrderDate`)
FROM `Orders`

/*
	Возвращает текущую локальную дату и время на основе системных часов
	 
	NOW() – пары даты и времени
	CURDATE() — возвращает текущую дату (Missing Time)
	CURTIME() — исключительно время (Missing Date)
*/
SELECT NOW()

-- найти разницу между двумя датами в деях
SELECT DATEDIFF(CURDATE(), '2020-11-24')

SELECT YEAR(`OrderDate`), MONTH(`OrderDate`)
FROM `Orders`
GROUP BY YEAR(`OrderDate`), MONTH(`OrderDate`)
ORDER BY YEAR(`OrderDate`), MONTH(`OrderDate`)

-- DATEPART() вывести часть даты (нет в MariaDB)
SELECT DATEPART('year', `OrderDate`), DATEPART('month', `OrderDate`), COUNT(*)
FROM `Orders`
GROUP BY DATEPART('year', `OrderDate`), DATEPART('month', `OrderDate`)
ORDER BY DATEPART('year', `OrderDate`), DATEPART('month', `OrderDate`)

-- Оставить только заказы, которые были доставлены клиенту в течение 31 дня с момента заказа
SELECT `OrderID`, `OrderDate`, `ShippedDate`
FROM `Orders`
WHERE `ShippedDate` BETWEEN `OrderDate` AND DATE_ADD(DAY, 31, Overdate)

-- Изменение регистра
SELECT `CompanyName`, LOWER(`CompanyName`), UPPER(`CompanyName`)
FROM `Customers` 

-- Вырезание символов
SELECT `UnitPrice`, LEFT(`UnitPrice`, 2), RIGHT(`UnitPrice`, 2)
FROM `Products` 

-- Подсчет количества символов строки
SELECT `ContactName`, LENGTH(`ContactName`)
FROM `Customers`

-- Объединение строк
SELECT `LastName`, `FirstName`, CONCAT(`LastName`, ' ', `FirstName`) `ContactName`
FROM `Employees`

-- Замена части строки
SELECT `ContactTitle`, REPLACE(`ContactTitle`, 'Owner', 'Business owner')
FROM `Customers`

-- Извлечение части строки из строки
SELECT `ContactTitle`, SUBSTRING(`ContactTitle`, 12, 7)
FROM `Customers`
WHERE `ContactTitle` = 'Accounting Manager'

-- Решение задач
SELECT ROUND(SUM(`UnitPrice` * `Quantity` * (1 - `Discount`)), 0)
FROM `Orders` t1 
INNER JOIN `Order Details` t2 USING(`OrderID`)
WHERE `OrderDate` BETWEEN '1996-01-01' AND '1996-12-31'

SELECT EXTRACT(QUARTER FROM `OrderDate`), COUNT(`OrderID`)
FROM `Orders`
WHERE YEAR(`OrderDate`) = 1997 AND MONTH(`OrderDate`) BETWEEN 01 AND 12
GROUP BY EXTRACT(QUARTER FROM `OrderDate`)

SELECT DATEDIFF(`ShippedDate`, `OrderDate`) 
FROM `orders`
ORDER BY DATEDIFF(`ShippedDate`, `OrderDate`) DESC

SELECT COUNT(DISTINCT `Country`) 
FROM `customers`
WHERE LENGTH(`Country`) > 10

-- IFNULL
-- Принимает два аргумента и возвращает первый, если он не равен NULL.
-- Иначе она возвращает второй аргумент.
SELECT IFNULL(1,0); -- возвращает 1
SELECT IFNULL('',1); -- возвращает ''
SELECT IFNULL(NULL,'IFNULL function'); -- возвращает IFNULL function

-- CASE
SELECT ProductName, ProductCount, 
CASE
    WHEN ProductCount = 1 
        THEN 'Товар заканчивается'
    WHEN ProductCount = 2 
        THEN 'Мало товара'
    WHEN ProductCount = 3 
        THEN 'Есть в наличии'
    ELSE 'Много товара'
END AS Category
FROM Products;

-- IF
SELECT ProductName, Manufacturer,
    IF(ProductCount > 3, 'Много товара', 'Мало товара')
FROM Products;

-- Функция COALESCE принимает список значений и возвращает первое из них, которое не равно NULL:
SELECT FirstName, LastName,
        COALESCE(Phone, Email, 'не определено') AS Contacts
FROM Clients;