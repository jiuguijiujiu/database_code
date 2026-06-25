# ------------------------------------准备动作：准备数据------------------------------------
use practice;
# 准备数据
# 1. 创建商品表.
create table product
(
    pid int primary key auto_increment, # 商品id，主键
    pname varchar(20),                  # 商品名
    price double,                       # 商品单价
    category_id varchar(32)             # 商品的分类id
);

# 2. 添加表数据.
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'联想',5000,'c001');
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'海尔',3000,'c001');
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'雷神',5000,'c001');
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'杰克琼斯',800,'c002');
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'真维斯',200,null);
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'花花公子',440,'c002');
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'劲霸',2000,'c002');
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'香奈儿',800,'c003');
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'相宜本草',200,null);
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'面霸',5,'c003');
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'好想你',56,'c004');
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'香飘飘奶茶',1,'c005');
INSERT INTO product(pid,pname,price,category_id) VALUES(null,'海澜之家',1,'c002');

select * from product;
select pid, pname, price from product;
select pid as 商品id, pname as 商品名, price as 商品价格 from product as p;
select pid  商品id, pname  商品名, price  商品价格 from product  p;
select  pname  商品名, price + 10  商品价格 from product  p;
select p.pname, p.price from product as p;

select * from product where price >= 500;
select * from product where category_id != 'c001';
select * from product where category_id <> 'c001';

select pname, price from product where price between 800 and 3000;
select pname, price from product where price >= 800 and price <= 3000;

select * from product where pname like '_霸';
select * from product where pname like '%斯%';

select * from product where price in(200, 800, 5000);
select * from product where price = 200 or price = 800 or price = 5000;

select * from product where price not in(200, 800, 5000);
select * from product where price != 200 and price != 800 and price != 5000;

select * from product where category_id is null;
select * from product where category_id is not null;

select * from product order by price asc;
select * from product order by price;
select * from product order by price desc;

select * from product order by price desc, category_id desc;


select count(*) from product;
select count(1) from product;
select count(category_id) as 行数 from product;

select
    count(price) as count,
    max(price) as max,
    min(price) as min,
    sum(price) as sum,
    round(avg(price), 2) as avg
from
    product;

select category_id, count(category_id) as count from product group by category_id;

select category_id, count(category_id) as count from product group by category_id having category_id <> 'c001';

select distinct category_id, price from product;

select category_id, price as count from product group by category_id, price



