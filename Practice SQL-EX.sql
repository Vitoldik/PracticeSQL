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