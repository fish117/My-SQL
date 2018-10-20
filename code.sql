-- 创建数据库
create database test;

-- 查看创建好的数据库
show create database test;

-- 查看所有数据库列表
show databases;

-- 使用数据库
use test;

-- 删除数据库
drop database test;

-- 创建员工信息表
create table emp(
	depid char(3),
	depname varchar(20),
	peoplecount int
);
        
-- 查看表是否创建成功
show tables;

-- 删除数据表
drop table emp;

-- 创建带约束条件的emp表
create table emp(
		depid char(3) primary key,
		depname varchar(20) not null default '-',
		peoplecount int unique
);

-- 创建含各种约束条件的数据表
CREATE TABLE example(id INT PRIMARY KEY AUTO_INCREMENT, -- 创建整数型自增主键
			name VARCHAR(4) NOT NULL, -- 创建非空字符串字段
			math INT DEFAULT 0, -- 创建默认值为0的整数型字段
			minmax FLOAT UNIQUE -- 创建唯一约束小数型字段
 );

-- 创建fruits数据表
create table fruits(
	f_id char(10) not null,
	s_id int not null,
	f_name varchar(255) not null,
	f_price decimal(8,2) not null,
	primary key(f_id)
);

-- 插入数据
insert into fruits(f_id,s_id,f_name,f_price)
values('a1',101,'apple',5.2),
('b1',101,'blackberry',10.2),
('bs1',102,'orange',11.2),
('bs2',105,'melon',8.2),
('t1',102,'banana',10.3),
('t2',102,'grape',5.3),
('o2',103,'coconut',9.2),
('c0',101,'cherry',3.2),
('a2',103,'apricot',25.2),
('l2',104,'lemon',6.4),
('b2',104,'berry',7.6),
('m1',106,'mango',15.6),
('m2',105,'xbabay',2.6),
('t4',107,'xbababa',3.6),
('b5',107,'xxxx',3.6);

select * from fruits;

-- 创建大气质量表
create table Monthly_Indicator(
	city_name varchar(20) not null,
    month_key date not null,
    aqi int(4) not null default 0,
    aqi_range varchar(20) not null default '-',
    air_quality varchar(20) not null default '-',
    pm25 float(6,2) not null default 0,
    pm10 float(6,2) not null default 0,
    so2 float(6,2) not null default 0,
    co float(6,2) not null default 0,
    no2 float(6,2) not null default 0,
    o3 float(6,2) not null default 0,
    ranking int(4) not null default 0,
    primary key(city_name,month_key)
    );
    
-- 为Monthly_Indicator表导入外部txt文件
load data local infile 'D:/liwork/CDA/MySQL - Li Qi/data/all.txt' 
	into table Monthly_Indicator 
    fields terminated by '\t'
    ignore 1 lines;
    
-- 检查倒入内容Monthly_Indicator
Select * from Monthly_Indicator;

-- 检查导入数据总行数Monthly_Indicator
Select count(*) from Monthly_Indicator;

-- 检查表结构
Desc Monthly_Indicator;

-- 更改表名
alter table emp rename empdep;

-- 更改字段数据类型
alter table empdep modify depname varchar(30);

-- 查看表结构
desc empdep;

-- 更改字段名称
alter table empdep change depname dep varchar(30);

-- 更改字段名称及字段数据类型
alter table empdep change dep depname varchar(20);

-- 为表添加新字段
alter table empdep add maname varchar(10) not null;

-- 将字段顺序改为第一位
alter table empdep modify maname varchar(10) first;

-- 将字段顺序改为另一个字段之后
alter table empdep modify maname varchar(10) after depid;

-- 删除字段
alter table empdep drop maname;

-- 查看表结构
desc empdep;

-- SQL语句查询
-- 查询大气质量表中的全部内容
select * from monthly_indicator;

-- 查询北京的大气质量数据
select * from monthly_indicator
where city_name = '北京';

-- 查询不同月份PM2.5的最大值
select month_key, max(pm25) from monthly_indicator
group by month_key;

-- 降序查询不同城市PM10的平均值
select city_name, avg(pm10) from monthly_indicator
group by city_name
order by avg(pm10) desc;

-- 对大气质量表进行有选择的查询
select city_name, avg(pm25), avg(pm10) from Monthly_Indicator
where pm25 > 50
group by city_name, month_key having city_name <> '北京'
order by avg(pm25) desc;

select city_name, pm25, pm10 from Monthly_Indicator
where pm25 > 50 and city_name <> '北京'
order by pm25 desc;

-- 链接练习
create table t1(
	key1 varchar(20),
    v1 int(4)
    );
    
load data local infile 'D:/liwork/CDA/MySQL - Li Qi/data/t1.csv' 
	into table t1
    fields terminated by ','
    ignore 1 lines;
    
create table t2(
	key2 varchar(20),
    v2 int(4)
    );

load data local infile 'D:/liwork/CDA/MySQL - Li Qi/data/t2.csv' 
	into table t2
    fields terminated by ','
    ignore 1 lines;
    
select t1.*, t2.* from t1 left join t2 on t1.key1 = t2.key2; -- 左链接
select t1.*, t2.* from t1 right join t2 on t1.key1 = t2.key2; -- 右链接
select t1.*, t2.* from t1 inner join t2 on t1.key1 = t2.key2; -- 内链接

-- 用union合并t1与t2表
select t1.* from t1
union
select t2.* from t2;

-- 用union all合并t1与t2表
select t1.* from t1
union all
select t2.* from t2;

-- 用and操作符查询s_id为101并且f_id为a1的水果记录
select * from fruits
where s_id = 101 and f_id = 'a1';

-- 用or操作符查询苹果或者橙子的相关记录
select * from fruits
where f_name = 'apple' or f_name = 'orange';

-- 用in操作符查询苹果和橙子的相关记录
select * from fruits
where f_name in('apple','orange');

-- 用not in操作符查询苹果和橙子之外的水果的相关记录
select * from fruits
where f_name not in('apple','orange');

-- 用between...and操作符查询f_price在10元到20元之间的水果记录
select * from fruits
where f_price between 10 and 20;

-- 用like操作符查询所有f_name由a开始的水果记录
select * from fruits
where f_name like 'a%';

-- 用like操作符查询所有f_id由b开始且字符长度为两位的水果记录
select * from fruits
where f_id like 'b_';

-- 用is null操作符查询所有f_name为空的水果记录
select * from fruits
where f_name is null;

-- 查询fruits表中所有不重复的s_id
select distinct s_id from fruits;

-- 用in操作符与子查询语句来查询所有f_id对应的f_price在10元到20元之间的水果记录
select * from fruits where f_id in
(select f_id from fruits where f_price between 10 and 20);

-- 用all操作符与子查询语句来查询所有f_price大于20元的水果记录
select * from fruits where f_price > all
(select f_price from fruits where f_price < 20);

-- 用exists操作符与子查询语句来查询是否存在f_price大于30元的水果记录
select * from fruits where exists
(select * from fruits where f_price > 30);

-- 用as将fruits表名重命名为f后使用
select f.* from fruits as f;

-- 显示f_price金额最大的前三名水果记录
select * from fruits
order by f_price desc
limit 3;

-- 使用abs函数求所有水果平均值与最大值差值的绝对值
select abs(avg(f_price)-max(f_price)) from fruits;

-- 使用length函数求每个f_name的名字与他们的字符长度
select f_name, length(f_name) from fruits group by f_name;

-- 使用now函数求当前的日期和时间
select now();

-- 使用group_concat函数查询不同s_id下对应的所有f_name信息
SELECT s_id, GROUP_CONCAT(f_name) FROM fruits
GROUP BY s_id;

--  使用concat函数在f_name字段值前添加'fruit_'信息
update fruits set f_name = concat('fruit_',f_name);
select * from fruits;

-- 删除f_id为'b5'的数据记录
delete from fruits where f_id = 'b5';
select * from fruits;

-- 单表查询练习，彩票数据规则
-- 奖票分析 --------------------------------------------------------------
-- 导入测试用完整数据
create table Final(
	FNo varchar(10) not null,
    TNo varchar(10) not null,
    Mark varchar(20) not null,
    reward varchar(20) not null,
	bingovalue int not null
);

load data local infile 'E:/LiWork/CDA/data/final.csv' 
	into table Final
    fields terminated by '\,';
    
alter table Final add RowNumber int primary key auto_increment; -- 自增字段，用来记录彩票张数

select * from Final;
select count(*) from Final;


#1求总中奖张数及金额
select count(bingovalue) as 中奖总张数, sum(bingovalue) as 中奖总金额
from Final
where bingovalue <> 0;

#2求各不同奖幅的张数及金额
select bingovalue as 奖幅, count(bingovalue) as 张数, sum(bingovalue) as 金额
  from Final 
  group by bingovalue
  having bingovalue <> 0;

#3求中奖张数与总张数占比，中奖金额与总金额的占比
set @allcount = (select count(bingovalue) from Final);
set @allsum = (select count(bingovalue) * 5 from Final);
select count(bingovalue)/@allcount as 中奖张数占比, 
sum(bingovalue)/@allsum as 中奖金额占比 from Final
where bingovalue <> 0;

#4检查每个本号下有100张彩票
select FNo, count(FNo) from Final
group by FNo
having count(FNo) <> 100;

#5检查每个本号下最多有一张中奖票金额超过50元
select FNo, count(FNo) from Final
where bingovalue > 50
group by FNo
having count(FNo)>1;

#6检查每本彩票中最多连续7张无奖票
#创建bingonumber1
create table bingonumber1 as (
select Rownumber, bingovalue, FNo from Final
where bingovalue > 0
order by rownumber);

select * from bingonumber1;

-- drop table bingonumber1; -- 删除表

#删除第一条记录
delete from bingonumber1 limit 1;

alter table bingonumber1 add numberkey int primary key auto_increment; -- 自增

#重新排序
alter table bingonumber1 modify numberkey int first;

#创建bingonumber2
create table bingonumber2 as ( 
select Rownumber, bingovalue, FNo from Final
where bingovalue > 0
order by rownumber);

-- drop table bingonumber2; -- 删除表

alter table bingonumber2 add numberkey int primary key auto_increment; -- 自增

#重新排序
alter table bingonumber2 modify numberkey int first;

#检查数据内容及记录行数
select * from bingonumber1;
select * from bingonumber2;
select count(*) from bingonumber1;
select count(*) from bingonumber2;

#检查测试结果
select b1.*, b2.*, (b1.rownumber - b2.rownumber) as gap from bingonumber1 as b1, bingonumber2 as b2
where b1.numberkey = b2.numberkey
and b1.FNo = b2.FNo
and (b1.rownumber - b2.rownumber) > 7;

-- 多表查询，电商数据查询练习
use test;
-- ----GoodsColor----
create table goodscolor(
	ColorID varchar(4) not null default '-',
	ColorNote varchar(20) not null default '-',
	ColorSort int not null default 0,    
	pt varchar(9) not null default '-'
);

#导入数据
load data local infile 'D:/liwork/CDA/MySQL - Li Qi/data/goodscolor.csv' 
	into table goodscolor
    fields terminated by ','
	ignore 1 lines;
    
-- ----GoodsSize----
create table goodssize(
	SizeID varchar(4) not null default '-',
	SizeNote varchar(100) not null default '-',
	SizeSort int not null default 0,    
	pt varchar(9) not null default '-'
);

#导入数据
load data local infile 'D:/liwork/CDA/MySQL - Li Qi/data/goodssize.csv' 
	into table goodssize
    fields terminated by ','
	ignore 1 lines;

-- ----OrderDetail----
create table OrderDetail(
	OrderID varchar(6) not null default '-',
	GoodsID varchar(6) not null default '-',
    GoodsPrice double not null default 0,
    ColorID varchar(4) not null default '-',
    SizeID varchar(4) not null default '-',
    Amount int not null default 0
);

#导入数据
load data local infile 'D:/liwork/CDA/MySQL - Li Qi/data/OrderDetail.txt' 
	into table OrderDetail
    fields terminated by '\t'
	ignore 1 lines;
    
select * from orderdetail;
select * from goodscolor;
select * from goodssize;

-- 1.倒序查询卖的金额最多的产品
select GoodsID, sum(GoodsPrice*amount) from orderdetail
group by goodsid
order by sum(GoodsPrice*amount) desc;

-- 2.查询不同尺码下的产品销售数量
select SizeNote, sum(amount) from orderdetail
left join goodssize on orderdetail.sizeid = goodssize.sizeid
group by orderdetail.sizeid
order by sum(amount) desc;

-- 3. 查询不同颜色下的产品销售金额
select colornote as 颜色, sum(goodsprice * amount) as 销售额 from orderdetail as od
left join goodscolor as gc on od.colorid=gc.colorid
group by od.colorid
order by sum(goodsprice * amount) desc;

-- 4. 查询不同尺码下的不同颜色的产品销售金额
select sizenote,colornote,sum(goodsprice * amount) from orderdetail as od
left join goodssize as gs on od.sizeid = gs.sizeid
left join goodscolor as gc on od.colorid = gc.colorid
group by od.sizeid, od.colorid
order by sum(goodsprice * amount) desc;