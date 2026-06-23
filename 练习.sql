SHOW DATABASES ;
USE practice;
SHOW TABLES ;
CREATE TABLE test(
    cid INT,
    cname VARCHAR(10),
    description VARCHAR(20)
);
DESC test;

SELECT * FROM test;
SELECT * FROM test_tmp;


INSERT INTO TEST(CID, CNAME) VALUE(1, '手机');
INSERT INTO TEST VALUE(2, '手机', '华为');
INSERT INTO TEST VALUE(3, '空调', '美的'), (4, '汽车', '特斯拉');
INSERT INTO TEST VALUE(5, '空调', '海尔'), (6, '汽车', '小米');


UPDATE TEST SET CNAME='文具', description='得力' WHERE CID=1;

DELETE FROM TEST WHERE CID=2;

TRUNCATE TABLE test_tmp;

CREATE TABLE test_tmp SELECT * FROM test;

INSERT INTO test_tmp SELECT * FROM test WHERE cid>3;