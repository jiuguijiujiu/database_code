# ------------------------------------案例1：DML语句（数据操作语言）操作表数据（DATA）增------------------------------------
# 1.切库查表
USE DAY01;
SHOW TABLES;

# 2. 创建分类表，分类id，分类名，描述信息
CREATE TABLE category(
    cid INT,
    cname VARCHAR(10),
    info VARCHAR(20)
);
DESC category;

# 3. 往表中添加数据
INSERT INTO CATEGORY(CID, CNAME) VALUES(1, '电脑');
INSERT INTO CATEGORY VALUES(2, '手机', '小米手机');
INSERT INTO CATEGORY VALUES(3, '汽车', '小米'), (4, '平板', '华为');

# 4.查看全表数据
SELECT * FROM category;


# ------------------------------------案例2：DML语句（数据操作语言）操作表数据（DATA）改------------------------------------
# 1.查看全表
SELECT * FROM category;

# 修改数据
UPDATE category SET CNAME='空调', INFO='美的';              # 危险，一次性改所有
UPDATE category SET CNAME='空调', INFO='美的' WHERE CID=1;


# ------------------------------------案例3：DML语句（数据操作语言）操作表数据（DATA）删------------------------------------
# 删除表数据
DELETE FROM category WHERE cid='1';
DELETE FROM category;                   # 危险，会删除所有数据

# 第二种删除
TRUNCATE TABLE category;


# ------------------------------------案例4：拓展：如何备份数据表（数据集较少时可用）------------------------------------
# 0. 查看数据表
SHOW TABLES ;

# 1. 原表
SELECT * FROM category;

# 2. 场景一：备份表不存在
CREATE TABLE category_tmp SELECT * FROM category;

# 3. 场景二：备份表存在
INSERT INTO category_tmp SELECT * FROM category WHERE cid<=3;

# 4.查看备份表数据
SELECT * FROM category_tmp;

# 5.清空备份表
DELETE FROM category_tmp;
