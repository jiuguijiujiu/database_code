# ------------------------------------案例1：DDL语句（数据定义语言）操作数据库（DATABASE）------------------------------------

# 1. 查看已经创建的所有数据库
SHOW DATABASES ;

# 2. 创建数据库
CREATE DATABASE day01 ;
CREATE DATABASE day02 CHARSET='gbk' ;
CREATE DATABASE IF NOT EXISTS day01 ;
# 完整建库
CREATE DATABASE IF NOT EXISTS day03 CHARSET='utf8' ;

# 3. 修改数据库 -->修改码表
ALTER DATABASE day02 CHARSET='utf8' ;

# 4. 删除数据库
DROP DATABASE day01 ;

# 5. 查看当前在哪个数据库
SELECT DATABASE() ;

# 6. 切换数据库
USE day01 ;

# 7. 查看某个已经安装数据库码表
SHOW CREATE DATABASE day01 ;    # 默认utf-8
SHOW CREATE DATABASE day02 ;
SHOW CREATE DATABASE day03 ;


# ------------------------------------案例2：DDL语句（数据定义语言）操作数据表（TABLE）------------------------------------
# 1. 切换库
USE day01;

# 2. 查看数据库中的数据表
SHOW TABLES;

# 3. 创建数据表，学生表：student，字段：sid：学生id，name：学生姓名，age：学生年龄
CREATE TABLE IF NOT EXISTS student(
    sid INT,            # 学生id
    name VARCHAR(20),   # 学生姓名
    age INT             # 学生年龄
);

# 4. 修改数据表（名）将student——>stu
RENAME TABLE student TO stu;

# 5.删除数据表
DROP TABLE IF EXISTS stu;

# 6. 如何查看表结构
SHOW CREATE TABLE student;
/*
CREATE TABLE `student` (
  `sid` int(11) DEFAULT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
 */

DESC student;


# ------------------------------------案例3：DDL语句（数据定义语言）表字段（FIELD）------------------------------------
# 1. 切换库，查表
USE day01;
SHOW TABLES;

# 2. 查看表结构
DESC student;

# 3. 给student报添加字段address varchar（20）
ALTER TABLE student ADD address VARCHAR(20) NOT NULL;

# 4. 修改字段
# 场景1：只修改 数据类型 和 约束
ALTER TABLE student MODIFY address INT;

# 场景2：即修改 数据类型 和 约束，也修改 字段名，address——>addr，INT——>VARCHAR(10)，NOT NULL
ALTER TABLE student CHANGE address addr VARCHAR(10) NOT NULL;

# 5. 删除字段
ALTER TABLE student DROP addr;