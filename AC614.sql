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
    select sum(oi.order_item_quaintity) as total_productos from customers c 
    join orders on c.customers_id = o.order_customer_id
    join order_items oi on o.order_id = oi.order_item_id
    where c.customer_city ="Bronx" and customer_fname like 'M%';

-- Recupera el nombre, email y ciudad de los clientes que tengan pedidos pendientes de pago.
    select c.customers_fname, c.customers_email, c.customer_city from customers c
    join orders o on c.customers_id = o.order_customer_id
    where o.order_status = "PENDING_PAYMENT";

-- Recupera el nombre de los departamentos que tengan pedidos pendientes de pago.
    select distinct (d.department_name) from departments d
    join categories c on department_id = c.category_department_id
    join products p on c.category_id = p.product_category_id
    join order_items ot on p.product_id = oi.order_item_product_id
    join orders o on oi.order_items = o.order_id
    where o.order_status = "PENDING_PAYMENT";

-- Recupera el nombre de los departamentos que han vendido algún producto a un cliente que vive en Phoenix.
    select distinct(d.department_name) from departaments d
    join categories c on department_id = c.category_department_id
    join products p on c.category_id = p.product_category_id
    join order_items oi on p.product_id = oi.order_item_product_id
    join customer cu on cu.customer_id = o.order_customer_id
    where cu.customer_city = "Phoneix"


-- Recupera todos los productos cuya categoría contenga la palabra Golf.
    select p.product_id from products p
    join categories c on p.product_category_id = c.category_id
    where lower(c.category_name) like '%golf%'

-- Para todos los elementos de pedido, comprueba si el valor del subtotal cuadra con el producto del precio por su cantidad.

-- Recupera todos los clientes que no han hecho ningún pedido.
select c.customer_id from customers c
left join orders o on c.customers_id = o.order_customer_id
where o.order_customer_id is null

-- Recupera todas las categorías que no tienen productos (usando combinaciones externas)
select category_id from categories c
left join products p on c.categories_id = p.product_category_id
where p.product_category_id is null