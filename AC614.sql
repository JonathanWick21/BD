--Jonathan Villalba Moran 1ºK

-- Realiza las siguientes consultas:

-- ¿Cuántas categorías hay en total?
    select count(*) from categories;

-- Recupera todos los posibles estados que puede tener un pedido (revisa la columna orders.order_status).
    select distinct (order_status) from orders;

-- Recupera el nombre y el primer apellido de los clientes que viven en Caguas.
    select customer_fname, customer_lname from customers where (customer_city = "Caguas"); 

-- ¿Cuál es el producto más caro? ¿Y el más barato?
    select product_name, product_price from products order by product_price desc limit 1;
    select product_name, product_price from products order by product_price asc limit 1;
-- ¿Cuántos pedidos han realizado clientes que viven en el Bronx?
    select count(*) from orders join customers on orders.order_customer_id = customers.customer_id
    where customer_city = "Bronx";

-- ¿Cuántos productos han pedido clientes que viven en el Bronx y su nombre empieza por M?
    

-- Recupera el nombre, email y ciudad de los clientes que tengan pedidos pendientes de pago.


-- Recupera el nombre de los departamentos que tengan pedidos pendientes de pago.


-- Recupera el nombre de los departamentos que han vendido algún producto a un cliente que vive en Phoenix.



-- Recupera todos los productos cuya categoría contenga la palabra Golf.


-- Para todos los elementos de pedido, comprueba si el valor del subtotal cuadra con el producto del precio por su cantidad.


-- Recupera todos los clientes que no han hecho ningún pedido.


-- Recupera todas las categorías que no tienen productos (usando combinaciones externas)