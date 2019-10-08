create database wsdb;

use wsdb;

drop table dept;
drop table emp;

-- 1. 부서 정보를 저장하기 위한 DEPT 테이블을 생성해보자.
create table `dept` (
	`DEPT_NO` char(8),
    `DEPT_NAME` varchar(100) NOT NULL,
    `DEPT_LOC` varchar(100) NOT NULL,
    `DEPT_TEL_NO` varchar(100) NOT NULL 
     );
     
-- 2.DEPT 테이블의 PK를 설정하는 구문을 추가해보자. (단, PK명은 DEPT_PK로 한다.)     
alter table dept add constraint `DEPT_PK` primary key (dept_no);

-- 3.아래의 데이터를 DEPT 테이블에 추가해보자.
INSERT INTO dept VALUES
('10', 'SALES', 'SEOUL', '02-671-1111'),
('20', 'FINANCE', 'SEOUL', '02-862-2222'),
('30', 'HR', 'BUSAN', '051-111-1111'),
('40', 'PURCHASE', 'BUSAN', '051-222-2222'),
('50', 'MANAGEMENT', 'SEOUL', '02-383-3333');


SELECT * FROM DEPT;
select * from emp;

-- 4. 아래와 같은 EMP 테이블을 생성해보자.
create table `emp` (
	`EMP_NO` int(10),
    `EMP_NAME` VARCHAR(10) NOT NULL,
    `EMP_MGE` VARCHAR(10) NOT NULL,
    `HIREDATE` datetime DEFAULT NULL,
    `SAL`  INTEGER default NULL,
    `DEPT_NO` int(10) NOT NULL
    );
    

-- 5.EMP 테이블의 Constaint PK, FK를 추가해보자. (단, PK는 EMP_PK, FK는 EMP_FK로 한다.)
ALTER TABLE `EMP` ADD CONSTRAINT `EMP_PK`  primary key(`EMP_NO`);  
ALTER TABLE `EMP` ADD CONSTRAINT `EMP_FK` FOREIGN KEY (`DEPT_NO`) references DEPT(`DEPT_NO`) ON UPDATE CASCADE;
-- ALTER table emp add constraint emp_fk foreign key(dept_no) references dept (DEPT_NO) on update cascade;

-- 6. 4번 테이블과 같이 데이터를 추가해보자.
INSERT INTO EMP VALUES
(1001, 'KIM', '1003', '2005-01-15', 4750, 20),
(1002, 'LEE', '1003', '2008-06-05', 3000, 30),
(1003, 'PARK', '1001', '2007-11-28', 3500, 10);

-- 7. HR 부서가 MANAGEMENT부서로 통합되었다. HR 부서 직원에 대한 소속 부서를 MANAGEMENT 부서로 변경해보자.
UPDATE EMP SET DEPT_NO = 50 WHERE DEPT_NO = 30;

-- 8. HR 부서를 DEPT 테이블에서 삭제해보자.
DELETE FROM DEPT WHERE DEPT_NAME = 'HR';

-- 9. 아래의 데이터를 EMP 테이블에 추가해보자. 추가 시 입사일은 시스템의 현재일자를 자동으로 가져와서 부여하도록 하며, '년-월-일'의 형태로 작성해보자.
INSERT INTO EMP VALUES (2001, 'chung', '1001', curdate(), 3000, 50);