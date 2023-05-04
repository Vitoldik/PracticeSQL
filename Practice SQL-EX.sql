-- 1
SELECT `model`, `speed`, `hd`
FROM `pc`
WHERE `price` < 500

-- 2
SELECT DISTINCT `maker`
FROM `product`
WHERE `type` = 'Printer'
)

-- 3
SELECT `l`.`model`, `l`.`ram`, `l`.`screen`
FROM `laptop` `l`
WHERE `price` > 1000

-- 4
SELECT *
FROM `printer`
WHERE color = 'y'

-- 5
SELECT `model`, `speed`, `hd`
FROM `pc`
WHERE (`cd` = 12 OR `cd` = 24) AND `price` < 600

-- 6
SELECT DISTINCT `p`.`maker`, `l`.`speed`
FROM `laptop` `l`
INNER JOIN `product` `p` USING(`model`)
WHERE `l`.`hd` >= 10

-- 7
SELECT `model`, `price`
FROM `pc` WHERE `model` IN (
  SELECT `model` FROM `product` WHERE `maker` = 'B' AND 
  `type` = 'PC'
)
UNION
SELECT `model`, `price`
FROM `laptop` WHERE `model` IN (
  SELECT `model` FROM `product` WHERE `maker` = 'B' AND 
  `type` = 'Laptop'
)
UNION
SELECT `model`, `price`
FROM `printer` WHERE `model` IN (
  SELECT `model` FROM `product` WHERE `maker` = 'B' AND 
  `type` = 'Printer'
)

-- 8
SELECT DISTINCT `maker`
FROM `product`
WHERE `type` = 'PC' AND `maker` NOT IN (
  SELECT `maker`
  FROM `product`
  WHERE `type` = 'Laptop'
)

--9
SELECT DISTINCT `maker`
FROM `product`
INNER JOIN `pc` `pc` USING(`model`)
WHERE `pc`.`speed` >= 450

-- 10
SELECT `model`, `price`
FROM `printer`
WHERE `price` IN (
  SELECT MAX(`price`)
  FROM `printer`
)

-- 11
SELECT AVG(`speed`)
FROM `pc`

-- 12
SELECT AVG(`speed`)
FROM `laptop`
WHERE `price` > 1000

-- 13
SELECT AVG(`speed`)
FROM `pc`
INNER JOIN `product` `p` USING(`model`)
WHERE `p`.`maker` = 'A'

-- 14
SELECT `s`.`class`, `s`.`name`, `c`.`country`
FROM `Ships` `s`
INNER JOIN `Classes` `c` USING(`class`)
WHERE `c`.`numGuns` >= 10

-- 15
SELECT `hd`
FROM `pc`
GROUP BY `hd`
HAVING COUNT(`hd`) > 1

-- 16
SELECT DISTINCT p1.model, p2.model, p1.speed, p1.ram
FROM pc p1, pc p2
WHERE p1.speed = p2.speed AND p1.ram = p2.ram AND p1.model > p2.model

-- 17
SELECT DISTINCT `p`.`type`, `p`.`model`, `l`.`speed`
FROM `laptop` `l`
JOIN `product` `p` USING(`model`)
WHERE `l`.`speed` < (SELECT MIN(speed) FROM `pc`)

-- 18
SELECT DISTINCT pt.maker, t1.minPrice price
FROM (
         SELECT MIN(price) minPrice
         FROM Printer
         WHERE color ='y'
     ) t1
         INNER JOIN Printer p ON t1.minPrice = p.price
         INNER JOIN Product pt ON p.model = pt.model
WHERE p.color = 'y'

-- 19
SELECT t1.maker, AVG(t2.screen)
FROM product t1
         INNER JOIN laptop t2 ON t1.model = t2.model
GROUP BY t1.maker

-- 20
SELECT maker, COUNT(model)
FROM product
WHERE type = 'pc'
GROUP BY maker
HAVING COUNT(DISTINCT model) >= 3

-- 21
SELECT t1.maker, MAX(t2.price)
FROM product t1
         JOIN pc t2 ON t1.model = t2.model
GROUP BY t1.maker

-- 22
SELECT speed, AVG(price)
FROM pc
WHERE speed > 600
GROUP BY speed


-- 23
SELECT DISTINCT t1.maker
FROM product t1
         JOIN pc t2 ON t1.model = t2.model
WHERE t2.speed >= 750 AND t1.maker IN (
    SELECT maker
    FROM product p
             JOIN laptop l ON p.model = l.model
    WHERE l.speed >= 750
)

-- 24
SELECT model
FROM (
         SELECT model, price
         FROM pc
         UNION
         SELECT model, price
         FROM Laptop
         UNION
         SELECT model, price
         FROM Printer
     ) t1
WHERE price = (
    SELECT MAX(price)
    FROM (
             SELECT price
             FROM pc
             UNION
             SELECT price
             FROM Laptop
             UNION
             SELECT price
             FROM Printer
         ) t2
)

-- 25
SELECT DISTINCT maker
FROM product
WHERE model IN (
    SELECT model
    FROM pc
    WHERE ram = (
        SELECT MIN(ram)
        FROM pc
    )
      AND speed = (
        SELECT MAX(speed)
        FROM pc
        WHERE ram = (
            SELECT MIN(ram)
            FROM pc
        )
    )
)
  AND
        maker IN (
        SELECT maker
        FROM product
        WHERE type='printer'
    )

-- 26
SELECT sum(t.price) / sum(t.amount) avgPrice
FROM (
    SELECT price, 1 amount
    FROM product
    JOIN pc ON product.model = pc.model
    WHERE product.maker = 'A'
    UNION all
    SELECT price, 1 amount
    FROM product
    JOIN laptop ON product.model = laptop.model
    WHERE product.maker = 'A'
) t

-- 27
SELECT t1.maker maker, AVG(t2.hd) avg_hd
FROM product t1
         JOIN pc t2 ON t1.model = t2.model
GROUP BY t1.maker
HAVING t1.maker IN (
    SELECT DISTINCT maker
    FROM product
    WHERE type = 'Printer'
)

-- 28
SELECT COUNT(maker)
FROM product
WHERE maker IN (
    SELECT maker
    FROM product
    GROUP BY maker
    HAVING COUNT(model) = 1
)