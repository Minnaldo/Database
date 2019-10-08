CREATE database SCOTT;

USE SCOTT;

-- 만약에 bonus가 존재한다면 지워라. 존재하지 않는다면 에러내지말고 넘어가라.
drop table if exists BONUS;

drop table dept;
drop table emp;

CREATE TABLE IF NOT EXISTS `BONUS` (
  `ENAME` varchar(10) DEFAULT NULL,
  `JOB` varchar(9) DEFAULT NULL,
  `SAL` double DEFAULT NULL,
  `COMM` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `DEPT` (
  `DEPTNO` int(11) NOT NULL,
  `DNAME` varchar(14) DEFAULT NULL,
  `LOC` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`DEPTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



INSERT INTO `DEPT` (`DEPTNO`, `DNAME`, `LOC`) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

select * from emp;

select deptno from dept;

select distinct deptno from emp;

delete from emp where ename='홍길동';
commit;

insert into emp(empno, ename, deptno) values(9001, '홍길동',  10);
commit;
insert into emp(empno, ename, deptno) values(9002, '홍길동',  70);
insert into emp(empno, ename, deptno) values(9003, '홍길동',  80);



CREATE TABLE IF NOT EXISTS `EMP` (
  `EMPNO` int(11) NOT NULL,
  `ENAME` varchar(10) DEFAULT NULL,
  `JOB` varchar(9) DEFAULT NULL,
  `MGR` int(11) DEFAULT NULL,
  `HIREDATE` datetime DEFAULT NULL,
  `SAL` double DEFAULT NULL,
  `COMM` double DEFAULT NULL,
  `DEPTNO` int(11) DEFAULT NULL,
  PRIMARY KEY (`EMPNO`),
  KEY `PK_EMP` (`DEPTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table emp;
INSERT INTO `EMP` (`EMPNO`, `ENAME`, `JOB`, `MGR`, `HIREDATE`, `SAL`, `COMM`, `DEPTNO`) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17 00:00:00', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20 00:00:00', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22 00:00:00', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02 00:00:00', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28 00:00:00', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01 00:00:00', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09 00:00:00', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19 00:00:00', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17 00:00:00', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08 00:00:00', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23 00:00:00', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03 00:00:00', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03 00:00:00', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23 00:00:00', 1300, NULL, 10);


select * from emp;
insert into emp(empno, ename, hiredate) values
(0000, '홍길동', '20191007'),
(0001, '홍길동', '20191007'),
(0002, '홍길동', '20191007'),
(0003, '홍길동', '20191007'),
(0004, '홍길동', '20191007'),
(0005, '홍길동', '20191007'),
(0006, '홍길동', '20191007');
-- (9999, '홍길동', '20191007');  --원 트랜잭션으로 도는거라 겹치면 안됨.


CREATE TABLE IF NOT EXISTS `SALGRADE` (
  `GRADE` double DEFAULT NULL,
  `LOSAL` double DEFAULT NULL,
  `HISAL` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `SALGRADE` (`GRADE`, `LOSAL`, `HISAL`) VALUES
(1, 700, 1200),
(2, 1201, 1400),
(3, 1401, 2000),
(4, 2001, 3000),
(5, 3001, 9999);


-- ON DELETE CASCADE
-- 외래 키에서 참조하는 키가 포함된 행을 삭제하려고 하면 해당 외래 키가 포함되어 있는 모든 행도 삭제
-- delete에 경우에는 NULL 로 바꾸고  update에 대해서는 CASCADE 한다. (삭제한다.)
ALTER TABLE `EMP`
  ADD CONSTRAINT `PK_EMP` FOREIGN KEY (`DEPTNO`) REFERENCES `DEPT` (`DEPTNO`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `empcp`
  ADD CONSTRAINT `PK_EMP` primary key(empno);
  
delete from dept where deptno = 70;

insert into dept(deptno, dname, loc) values(70, 'ssafy', '광주');

insert into emp(empno, ename, deptno) values(9001, '홍길동', 70);

select * from emp;
select * from dept;

update dept set deptno = 90 where deptno = 30;
  

insert into emp(empno, ename, hiredate) values(9999, '홍길동', '20191007');
select * from emp;
select * from dept;

drop database scott;

drop table emp;


-- 명시적 입력
insert into dept(deptno, dname) values(50, 'MIS');
-- 암묵적 입력
insert into dept values(60, 'MIG', null);

-- table 복사
create table emp_copy
as
select * from emp;

select * from emp_copy;

use scott;

-- emp table에 '홍길동' 이름을 가진 데이터를 다 지움.
delete from emp where ename = '홍길동';

delete from emp_copy;

-- emp table을 emp_copy 테이블을 복사해서 생성
insert into emp_copy
select * from emp;

select * from emp_copy;

alter table emp_copy add(tel varchar(13) not null);
alter table emp_copy drop tel;
alter table empcp drop tel;

-- tel 에 not null 조건 추가해서 안됨.
-- insert into emp_copy (empno, ename, tel) values ('8000', '홍길동', null);

insert into emp_copy (empno, ename, tel) values ('8000', '홍길동', '010-1234-5678');

rename table emp_copy to empcp;

select * from empcp;
savepoint aaa;
commit;

update empcp set sal = sal+1000;
update empcp set sal = sal-1000;

insert into empcp(empno, ename) values
(8011, '홍길동'),
(8012, '홍길동'),
(8013, '홍길동'),
(8014, '홍길동'),
(8015, '홍길동'),
(8016, '홍길동'),
(8017, '홍길동'),
(8018, '홍길동');


-- 여기부터는 Query 탭에 auto commit Transaction 체크를 뺐다.
delete from empcp where ename = '홍길동';
-- 다른 SQL File 탭을 켜서, 테이블을 확인해보면 '홍길동'의 데이터가 남아있다.

-- commit 을 하면, 실제로 사라진다.


insert into empcp(empno, ename) values
(8011, '홍길동'),
(8012, '홍길동'),
(8013, '홍길동');
-- aaa 라고 하는 savepoint를 하나 줌.
savepoint aaa;

insert into empcp(empno, ename) values
(8014, '홍길동'),
(8015, '홍길동'),
(8016, '홍길동');


-- 원래대로 돌리고 싶다.
rollback;

rollback;

select * from empcp;

delete from empcp where ename = '홍길동';

insert into empcp(empno, ename) values
(9001, '고길동'),
(9002, '둘리'),
(9003, '도우너');

select * from empcp;

update empcp set sal = 10000 where empno in (9001, 9002, 9003);

delete from empcp where empno in (9001, 9002, 9003);

-- 이전 commit 한 부분으로 돌아간다.
rollback;

desc empcp;

-- 트랜잭션 캐시에 들어있다.  commit 하기 전.
insert into empcp(empno, ename)
values(9001, '홍길동');

select * from empcp;





delete from empcp where ename = '홍길동';

commit;