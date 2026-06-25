# ------------------------------------准备动作：准备数据------------------------------------
use day02;
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

# ------------------------------------案例1：简单查询------------------------------------
# 1. 查询表中所有数据
select * from product;
select pid, pname, price, category_id from product;

select pname, price from product;

select pname as 商品名, price as 价格 from product as p;
select pname 商品名, price 价格 from product as p;

# 2. 修改某列值，比如：查询商品名，价格；但是让价格 +10 块钱运费
select pname, price + 10 as price from product;
select pname, price + 10 price from product;        # 省略as警告，所以不推荐省略as


# ------------------------------------案例2：条件查询------------------------------------
# 1. 查看所有数据
select * from product;

# 2. 演示比较运算符
# 需求1：查找单价再500元以上的产品信息
select * from product where price >= 500;

# 需求2：查找不是c001类别的产品信息
select * from product where category_id != 'c001';
select * from product where category_id <> 'c001';

# 需求3：查找价格800~3000元的产品信息，只显示产品名，价格
select pname, price from product where price between 800 and 3000;
select pname, price from product where price >=800 and price <=3000;

# 需求4：查找 第二个字是霸 的产品，且产品名只有两个字
select * from product where pname like '_霸';

# 需求5：商品里带 斯 字的
select * from product where pname like '%斯%';

# 需求6：查询 价格是 200，800或者5000 的商品信息
select * from product where price in(200, 800, 5000);
select * from product where price=200 or price=800 or price=5000;

# 需求7：查询 价格 不是 200，800或者5000 的商品信息
select * from product where price not in(200, 800, 5000);
select * from product where price!=200 and price!=800 and price!=5000;

# 需求8：查看 没有商品分类id 的商品信息
select * from product where category_id is null;
select * from product where category_id = null;     # 这样是查不出来的


# 需求9：查看 有商品分类id 的商品信息
select * from product where category_id is not null;

# ------------------------------------案例3：排序查询------------------------------------
# 1. 查看表数据
select * from product;

# 2. 按照 价格升序 查找
select * from product order by price asc;
select * from product order by price ;

# 3. 按照 价格降序 查找
select * from product order by price desc;

# 4. 按照 价格降序 排列，如果价格一致，则按照 分类id降序 排列
select * from product order by price desc, category_id desc;

# ------------------------------------案例4：聚合查询------------------------------------
# 1. 查看表数据
select * from product;

# 2. 统计数据条数
select count(*) from product;               # 13
select count(1) from product;               # 13


select count(pid) from product;             # 13
select count(category_id) from product;     # 11，聚合忽略null值

# 3. 查看商品价格求和，最大值，最小值，平均值
select
    sum(price) as sum,
    max(price) as max,
    min(price) as min,
    round(avg(price), 3) as avg
from
    product;


# ------------------------------------案例5：分组查询------------------------------------
# 1. 查看表数据
select * from product;

# 2. 需求1：统计每个类别商品数量
select
    category_id,                # 分组字段
    count(*) as total_cnt       # 聚合函数
from
    product
group by
    category_id;                # 分组字段

# 3. 需求2：统计每个类别商品数量，只显示 商品数量在2以上的数量
select
    category_id,                # 分组字段
    count(*) as total_cnt       # 聚合函数
from
    product
group by
    category_id                 # 分组字段
having
    total_cnt >=2;              # 组后赛选

# ------------------------------------案例6：去重查询------------------------------------
# 1. 查看表数据
select * from product;

# 2. 查看（去重后）所有类别
select distinct category_id from product;

# 3. 按照分类id和价格去重
select distinct category_id, price from product;

# 去重思路2：分组去重
select category_id, price from product group by category_id, price;

# ------------------------------------案例7：分页查询------------------------------------
# 1. 查看表数据
select * from product;

# 2. 场景1：3条/页
select * from product limit 0, 3;   # 起始位置：（页数-1）*条数
select * from product limit 3, 3;
select * from product limit 6, 3;
select * from product limit 9, 3;
select * from product limit 12, 3;

# 3. 场景2：5条/页
select * from product limit 0, 5;   # 起始位置：（页数-1）*条数
select * from product limit 5, 5;
select * from product limit 10, 5;

# 4. 场景3：4条/页，求第二页
select * from product limit 4, 4;

# 5. 不存在也不报错
select * from product limit 100, 5;

# 获取价格次高的商品数据
select * from product order by price desc limit 1, 1;