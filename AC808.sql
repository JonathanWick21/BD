-- Active: 1736359634384@@127.0.0.1@3306@RETAIL

--Jonathan Villalba Moran 1ºK

--Sobre la base de datos retail, a partir de la siguiente consulta que recupera la categoría y cantidad económica 
--de los productos de pedidos pendientes de clientes que viven en el estado de California (CA):

-- a. Crea una vista llamada vproductospcal y una tabla llamada tproductospcal a partir de la consulta. Anota el tiempo aproximado necesario en su creación. ¿Cuál ha tardado más y por qué?
    CREATE VIEW vproductosal AS 
select ca.category_name, sum(p.product_price)
from categories ca join products p on ca.category_department_id = p.product_category_id
join order_items oi on p.product_id = oi.order_item_product_id
join orders o on oi.order_item_order_id = o.order_id
join customers c on o.order_customer_id = c.customer_id
where o.order_status = "PENDING" and c.customer_state = "CA"
order by ca.category_name;

-- La vista ha tardado menos.

    CREATE TABLE tproductospcal AS
    select ca.category_name, sum(p.product_price)
from categories ca join products p on ca.category_department_id = p.product_category_id
join order_items oi on p.product_id = oi.order_item_product_id
join orders o on oi.order_item_order_id = o.order_id
join customers c on o.order_customer_id = c.customer_id
where o.order_status = "PENDING" and c.customer_state = "CA"
order by ca.category_name;

-- La tabla ha tardado más porque ha tenido que copiar los datos.

-- b. A continuación, realiza una consulta sobre la nueva tabla y la nueva vista, anotando sus tiempos de ejecución ¿Cuál ha tardado más y por qué?

    SELECT * from vproductosal;

    --La vista ha tardado más porque ha tenido que volver a hacer la consulta antes de hacer la que le pido yo.

    SELECT * from tproductospcal;

    --La tabla tarda menos.

-- c. Inserta un nuevo pedido en estado pendiente asociado a un cliente de California.

-- d. Analiza si el nuevo dato repercute en la vista y/o en la tabla ¿Por qué?


