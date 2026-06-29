# ------------------------------------案例1：窗口函数mysql8.x------------------------------------
#准备数据——>建库 切换库 查表
create database if not exists day03;
use day03;
show tables ;

#准备数据——>建表 添加数据
create table employee (empid int, ename varchar(20) , deptid int , salary decimal(10, 2));

insert into employee values(1, '刘备', 10, 5500.00);
insert into employee values(2, '赵云', 10, 4500.00);
insert into employee values(2, '张飞', 10, 3500.00);
insert into employee values(2, '关羽', 10, 4500.00);

insert into employee values(3, '曹操', 20, 1900.00);
insert into employee values(4, '许褚', 20, 4800.00);
insert into employee values(5, '张辽', 20, 6500.00);
insert into employee values(6, '徐晃', 20, 14500.00);

insert into employee values(7, '孙权', 30, 44500.00);
insert into employee values(8, '周瑜', 30, 6500.00);
insert into employee values(9, '陆逊', 30, 7500.00);

# 查看数据
select * from employee;

# 案例1：分组排名，需求按照部门id（deptid）分组，按照工资（salary）降序排列
# 场景1：如何给表新增一列
select *, 'haha' from employee;
select *, 10/3 from employee;
select *, deptid + 10 from employee;

# 场景2：引入窗口函数
select
    *,
    # sum(salary) over () as rn                                       # 没写partition by，统计全表
    # sum(salary) over (partition by deptid) as rn                    # 写了partition by，没写order by,统计全组
    sum(salary) over (partition by deptid order by salary desc) as rn # 写了partition by，写了order by,统计组内 第一行 到 当前行
from
    employee;

# 场景3：分组排名:需求按照部门id（deptid）分组，按照工资（salary）降序排列
select
    *,
    row_number()over (partition by deptid order by salary desc) as rn,
    rank()over (partition by deptid order by salary desc) as rk,
    dense_rank()over (partition by deptid order by salary desc) as dr
from
    employee;

# 场景4：分组排名求topn，需求：找出每组工资最高的两人信息（考虑并列）
# 如下代码，思路没问题，但是语法格式有问题，在 where后面加入的字段 必须是 表里已经有的字段
select
    *,
    rank() over(partition by deptid order by salary desc) as rk
from
    employee
where
    rk <= 2;

# 解决方案如下
# 思路1：子查询写法
select * from(
    select
        *,
        rank() over(partition by deptid order by salary desc) as rk
    from
        employee
    ) as t1 where rk <= 2;

# 思路2：cte 公共表表达式，可以吧常用的数据集封装成新表,方便操作
with t1 as(select *, rank() over(partition by deptid order by salary desc) as rk from employee)
select * from t1 where rk <= 2;

# 拓展：一个需求表达cte的强大
with t1 as (select * from employee),
     t2 as (select * from employee where deptid = 10),
     t3 as (select * from employee where deptid = 20),
     t4 as (select * from employee where deptid = 30),
     t5 as (select *, sum(salary) over() from employee)
select * from t5;

# ------------------------------------案例2：自关联（自连接）查询------------------------------------
# 查表
show tables ;

# 查看表数据
select * from areas;

# 1. 查看河南省的信息
select * from areas where title = '河南省';

# 2. 查看河南省所有市
select * from areas where pid = '410000';

# 3. 查看新乡市所有的县区
select * from areas where pid = '410700';

# 4. 查看所有省，所有市，所有县区的信息
select
    province.id, province.title,    # 省级id与名字
    city.id, city.title,            # 市级id与名字
    county.id, county.title         # 县区级id与名字
from
    areas as county     # 县区表
inner join
    areas as city on county.pid = city.id   # 市级表
inner join
    areas as province on city.pid = province.id;    # 省级表

# 5.精准查找
select
    province.id, province.title,    # 省级id与名字
    city.id, city.title,            # 市级id与名字
    county.id, county.title         # 县区级id与名字
from
    areas as county     # 县区表
inner join
    areas as city on county.pid = city.id   # 市级表
inner join
    areas as province on city.pid = province.id    # 省级表
where
    # county.id = '340322';        # 给身份证号前6位
    city.id = '340300';        # 给身份证号前4位
