-- Active: 1736359634384@@127.0.0.1@3306@RETAIL


--Calcula el precio medio y el máximo de los productos

SELECT TRUNCATE(AVG(product_price),2) as medPre, MAX(product_price) as maxPre
from products;

--Categorías que no tienen productos
SELECT c.category_name
FROM categories c
LEFT JOIN products p ON c.category_id = product_category_id
GROUP BY c.category_name
HAVING COUNT(p.product_name) = 0;