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