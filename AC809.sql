--Jonathan Villalba Moran 1ºK

--Sobre la base de datos retail

--Averigua qué indices existen en las diferentes tablas

    SHOW INDEX FROM categories;
    SHOW INDEX FROM customers;
    SHOW INDEX FROM departments;
    SHOW INDEX FROM order_items;
    SHOW INDEX FROM orders;
    SHOW INDEX FROM products;
    SHOW INDEX FROM tproductospcal;

-- Ejecuta las siguiente consultas analizando su plan de ejecución:

-- a. Productos de pedidos completados

-- Mediante el plan de ejecución, averigua si utilizan índices, cuáles son y cuantos documentos recorren.

 explain select p.product_name, p.product_price
from products p join order_items oi on p.product_id = oi.order_item_product_id
join orders o on oi.order_item_order_id = o.order_id
where o.order_status = "COMPLETE";

--Utiliza 3 indices, dos claves primarias y una clave foranea, recorren 67468

-- A continuación crea un índice sobre la columna order_status. Vuelve a ejecutar la consulta y compara el resultado

CREATE INDEX estado ON orders(order_status);

 explain select p.product_name, p.product_price
from products p join order_items oi on p.product_id = oi.order_item_product_id
join orders o on oi.order_item_order_id = o.order_id
where o.order_status = "COMPLETE";


EXPLAIN select p.product_name, p.product_price
from products p join order_items oi on p.product_id = oi.order_item_product_id
join orders o on oi.order_item_order_id = o.order_id
join customers c on o.order_customer_id = c.customer_id
where o.order_status = "CANCELED" and c.customer_city = "Caguas";

--Ahora recorren solo 33736 documentos

-- b. Productos de pedidos cancelados de clientes que viven en Caguas:

select p.product_name, p.product_price
from products p join order_items oi on p.product_id = oi.order_item_product_id
join orders o on oi.order_item_order_id = o.order_id
join customers c on o.order_customer_id = c.customer_id
where o.order_status = "CANCELED" and c.customer_city = "Caguas";

-- Averigua si utilizan índices, cuáles son y cuantos documentos recorren.

EXPLAIN select p.product_name, p.product_price
from products p join order_items oi on p.product_id = oi.order_item_product_id
join orders o on oi.order_item_order_id = o.order_id
join customers c on o.order_customer_id = c.customer_id
where c.customer_city = "Caguas" AND o.order_status = "CANCELED";

--Utiliza 4 index el de estado que hemos creado el primario de customers la clave foreanea de order_items_orders y la primaria de productos y recorre 1428 documentos


-- A continuación crea un índice sobre la columna customer_city. Vuelve a ejecutar la consulta y compara el resultado

CREATE INDEX ciudad ON customers(customer_city);

EXPLAIN select p.product_name, p.product_price
from products p join order_items oi on p.product_id = oi.order_item_product_id
join orders o on oi.order_item_order_id = o.order_id
join customers c on o.order_customer_id = c.customer_id
where c.customer_city = "Caguas" AND o.order_status = "CANCELED";

-- No ha cambiado ya que sigue usando el index de estado para la consulta

-- c. Categoría y cantidad económica de los productos de pedidos pendientes de clientes que viven en el estado de California (CA):

select ca.category_name, sum(p.product_price)
from categories ca join products p on ca.category_department_id = p.product_category_id
join order_items oi on p.product_id = oi.order_item_product_id
join orders o on oi.order_item_order_id = o.order_id
join customers c on o.order_customer_id = c.customer_id
where o.order_status = "PENDING" and c.customer_state = "CA"
order by ca.category_name;

-- Analiza el plan de ejecución y compáralo con la consulta anterior. A continuación crea los índices que consideres oportunos para mejorar la consulta todo lo que se pueda. Vuelve a ejecutar la consulta y compara el resultado
EXPLAIN select ca.category_name, sum(p.product_price)
from categories ca join products p on ca.category_department_id = p.product_category_id
join order_items oi on p.product_id = oi.order_item_product_id
join orders o on oi.order_item_order_id = o.order_id
join customers c on o.order_customer_id = c.customer_id
where o.order_status = "PENDING" and c.customer_state = "CA"
order by ca.category_name;

-- 4 index el primero de estado con 7610 documentos recorridos
CREATE INDEX estado_Pais ON customers(customer_state);

EXPLAIN select ca.category_name, sum(p.product_price)
from categories ca join products p on ca.category_department_id = p.product_category_id
join order_items oi on p.product_id = oi.order_item_product_id
join orders o on oi.order_item_order_id = o.order_id
join customers c on o.order_customer_id = c.customer_id
where o.order_status = "PENDING" and c.customer_state = "CA"
order by ca.category_name;

--Ahora sigue usando 4 pero usa el de estado del pais recorriendo 2012 documentos
