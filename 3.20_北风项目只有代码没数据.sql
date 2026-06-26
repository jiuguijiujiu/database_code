# 需求1： 选中 employees表 查看所有数据
select * from employees;

# 需求2：查询每个客户的 ID, company name, contact name, contact title, city, 和 country, 并按照国家名字排序
select customer_id, company_name, contact_name, contact_title, city, country from customers order by country;

-- 替换快捷键：ctrl + 字母R
-- 需求3：查询每一个商品的product_name, category_name, quantity_per_unit, unit_price, units_in_stock 并且通过 unit_price 字段排序
-- 方式1：显示内连接
select
    product_name, category_name, quantity_per_unit, unit_price, units_in_stock
from
    categories as c
inner join
    products as p
on
    c.category_id = p.category_id
order by
    unit_price;

-- 方式2：隐式内连接.
select
    product_name, category_name, quantity_per_unit, unit_price, units_in_stock
from
    categories as c,
    products as p
where
    c.category_id = p.category_id
order by
    unit_price;

# 需求4：列出所有提供了4种以上不同商品的供应商列表所需字段：supplier_id, company_name, and products_count（提供的商品种类数量）。
# step1: 计算 每个供应商 提供的商品种类数,且大于4
select
    supplier_id, company_name,
    count(*) as products_count
from
    products as p
inner join
    suppliers as s
on
    p.supplier_id = s.supplier_id
group by
    supplier_id, company_name
having
    products_count >= 4;

# step2：验证
select * from products where supplier_id = 16;


-- 需求34：统计所有订单的运费，将运费高低分为三档
-- 报表中包含三个字段
-- low_freight freight值小于“ 40.0”的订单数
-- avg_freight freight值大于或等于“ 40.0”但小于“ 80.0”的订单数
-- high_freight freight值大于或等于“ 80.0”的订单数

select count(order_id) as low_freight from orders where freight < 40;
select count(order_id) as avg_freight from orders where freight >= 40 and freight < 80;
select count(order_id) as high_freight from orders where freight <= 80;

select
    count(if(freight < 40, 1, null)) as low_freight,
    count(if(freight >= 40 and freight < 80, 1, null)) as avg_freight,
    count(if(freight <= 80, 1, null)) as avg_freight
from
    orser;

# if(条件，值1，值2) ——> 条件成立返回值1，不成立返回值2
select if(5 > 3, 5, 3);  # 条件成立，返回5
