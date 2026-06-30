# ------------------------------------案例1：多表建表之一对多（理解即可，实际开发很少用）------------------------------------
# 需求：新建部门表（dept，department）和 员工表（emp），他们之间是 一对多的关系，请用外键约束，完成限定。

# 1. 切库，查表
use day02;
show tables ;

# 2. 创建主表——>部门表
create table dept(
    id int primary key auto_increment, # 部门id
    name varchar(10)                   # 部门名
);

# 3. 创建外表——>员工表
create table emp(
    id int primary key auto_increment,  # 员工id
    name varchar(10),                   # 员工名
    salary double,                      # 员工薪水
    dept_id int                         # 员工部门id
    # 建表时添加外键
    ,foreign key (dept_id) references dept(id)
);

# 4. 给部门表添加数据
insert into dept values (null, '人事部'), (null, '财务部'), (null, '研发部'), (null, '行政部');

# 5. 给员工表添加数据
insert into emp values (null, '胡歌', 33333, 1);
insert into emp values (null, '刘亦菲', 22222, 2);
insert into emp values (null, '迪丽热巴', 11111, 2);
insert into emp values (null, '一一', 1.2, 3);
insert into emp values (null, '坤哥', 999999999, 10);    # 报错，因为 外表外键列 不能出现 主键表的主键列 没有的数据





# 6. 查看表数据
select * from dept;
select * from emp;

# 7. 删除外键约束
alter table emp drop foreign key emp_ibfk_1;

# 8. 建表后添加外键约束， 前提：但是表数据之间必须合法
alter table emp add constraint fk_dept_emp foreign key (dept_id) references dept(id);

# 查看表结构
desc emp;


# ------------------------------------案例2：多表查询 准备工作------------------------------------
# 1. 创建hero表
create table hero (
    hid int primary key auto_increment, # 英雄id
    hname varchar(255), # 英雄名
    kongfu_id int
);

# 2. 创建kongfu表
create table kongfu (
    kid int primary key auto_increment, # 功夫id
    kname varchar(255) # 功夫名
);

# 3. 添加表数据.
# 插入hero数据
insert into hero values(1, '鸠摩智', 9),(3, '乔峰', 1),(4, '虚竹', 4),(5, '段誉', 12);

# 插入kongfu数据
insert into kongfu values(1, '降龙十八掌'),(2, '乾坤大挪移'),(3, '猴子偷桃'),(4, '天山折梅手');

# 4. 查看表数据.
select * from hero;
select * from kongfu;

# ------------------------------------案例3：多表查询 交叉连接（cross join）------------------------------------
select * from hero, kongfu;

select * from hero join kongfu;


# ------------------------------------案例3：多表查询 内连接（inner join）------------------------------------
select * from hero as h, kongfu as kf where h.kongfu_id = kf.kid;   # 标准
select * from hero, kongfu where kongfu_id = kid;                   # 省略

select * from hero as h inner join kongfu as kf on h.kongfu_id = kf.kid;    # 标准
select * from hero join kongfu on kongfu_id = kid;                          # 省略

# ------------------------------------案例5：多表查询 外连接------------------------------------
# 场景1：左外连接： 左表全集 + 交集
select * from hero as h left join kongfu as kf on h.kongfu_id = kf.kid;


# 场景2：右外连接： 右表全集 + 交集
select * from hero as h right join kongfu as kf on h.kongfu_id = kf.kid;

# 场景3：满外连接（全连接）： 左外连接 + 右外连接
select * from hero as h full join kongfu as kf on h.kongfu_id = kf.kid;     # MySQL不支持full join

# 用union 把 左外连接结果 与 右外连接结果 合并 实现全连接效果
select * from hero as h left join kongfu as kf on h.kongfu_id = kf.kid      # 左外连接
# union distinct 合并去重，distinct可省略
# union
union all   #合并，不去重
select * from hero as h right join kongfu as kf on h.kongfu_id = kf.kid;    # 右外连接

# ------------------------------------案例5：多表查询 子查询------------------------------------
# 需求：查询价格最高的商品信息，只要 商品名，价格，分类id
select * from product;

# 方式1
# step1:查找最高物品价格
select max(price) from product;

# step2:查找价格最高商品信息
select pname, price, category_id from product where price = 5000;


# 方式2：合并版本（子查询）
                        # 主查询（父查询）                                   子查询
select pname, price, category_id from product where price = (select max(price) from product);

# 方式3：实际开发写法，连接查询
select
    *
from
    product as p
inner join
    (select max(price) as price from product) as t1
on
    p.price = t1.price;

# ------------------------------------案例7：case when------------------------------------
# 需求c001 -> 电脑，c002 -> 服装，c003 -> 化妆品，c004 -> 零食，c005 -> 饮料
select * from product;

# 标准
select
    *,
    case
        when category_id = 'c001' then '电脑'
        when category_id = 'c002' then '服装'
        when category_id = 'c003' then '化妆品'
        when category_id = 'c004' then '零食'
        when category_id = 'c004' then '饮料'
        else '未知类别'
    end as 类别
from
    product;

# 简化
select
    *,
    case category_id
        when 'c001' then '电脑'
        when 'c002' then '服装'
        when 'c003' then '化妆品'
        when 'c004' then '零食'
        when 'c004' then '饮料'
        else '未知类别'
    end as 类别
from
    product;