# ------------------------------------案例1：演示主键约束------------------------------------
# 建库，切换库，查表
create database if not exists day02;
use day02;
show tables;

# 场景1：建表时添加主键约束
# 删表
drop table if exists stu;

# 1. 创建学生表：字段：id name age
create table if not exists stu(
    id int primary key,
    name varchar(10),
    age int
);

# 2. 查看表结构
desc stu;

# 3.给stu表添加数据
insert into stu value (1, '张三', '18');
insert into stu value (null, '张三', '18');

# 4. 查看表数据
select * from stu;

# 5. 删除主键约束
alter table stu drop primary key;

# 6. 建表后添加主键约束，结合自增
alter table stu add primary key(id);
alter table stu modify id int auto_increment;

# 7. 再次添加数据
insert into stu value (5, '李四', '19');
insert into stu value (null, '李四', '19');

# 回顾delete from与truncate table的区别
delete from stu;

truncate stu;

# ------------------------------------案例2：演示其他约束------------------------------------
# 1. 查表
show tables ;

# 2. 建表，员工表（employee）：字段（id，姓名，手机号，住址）
create table if not exists employee(
    eid int primary key auto_increment,
    name varchar(10) not null ,
    mobil varchar(11) unique ,
    address varchar(20) default '安徽'
);

# 3. 查看表结构
desc employee;

# 4. 插入数据
insert into employee value (null, '一一', '111', '上海');
insert into employee value (null, null, '222', '深圳');       # 报错，姓名不能为空
insert into employee value (null, '三三', '111', '广州');      # 报错，手机号唯一
insert into employee value (null, '一一', '333', '北京');
insert into employee value (null, '四四', '444');             # 报错，值个数要与列个数一致，没写列，默认全列
insert into employee (eid, name, mobil) value (null, '四四', '444');




# 5. 查看数据
select * from employee;

truncate employee;