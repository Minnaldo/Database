create database wsdb03;
use wsdb03;

drop table emp;
drop table dept;
create table EMP (
	empno int(4) primary key,
    ename varchar(10) default null,
    job varchar(10) default null,
    mgr int(4) default null,
    hiredate date default null,
    sal decimal(7,2) default null,
    comm decimal(7,2) default null,
    deptno int(2)
    );
    
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
    

create table DEPT (
	deptno int(2) primary key,
    dname varchar(14) not null,
    loc varchar(13) not null
    );
    

-- 1. 위와 테이블 구조가 되도록 DEPT 테이블을 생성하고 DEPT 테이블에 아래의 데이터를 추가하여 보자.
INSERT INTO DEPT VALUES
(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON');

select * from dept;
select * from emp;

-- 2. 위와 테이블 구조가 되도록 EMP 테이블을 수정하여 보자.
-- ALTER TABLE emp add constraint emp_pk primary key(`empno`);
ALTER TABLE emp add constraint emp_fk foreign key(`deptno`) references dept(`deptno`);

-- 3. emp와 dept Table을 JOIN하여 이름, 급여, 부서명을 검색하세요.
-- select ename, sal, dname from emp inner join dept;
select a.ename, a.sal, b.deptno from emp a JOIN dept b;

-- 4. 이름이 ‘KING’인 사원의 부서명을 검색하세요.
SELECT * 
from dept inner join emp using (deptno) 
where ename = 'king';

-- 5. dept Table에 있는 모든 부서를 출력하고, emp Table에 있는 DATA와 JOIN하여 모든 사원의 이름, 부서번호, 부서명, 급여를 출력 하라.
select a.*, ename, b.deptno, dname, sal 
from DEPT a left outer join emp b using(deptno);

-- 6. emp Table에 있는 empno와 mgr을 이용하여 서로의 관계를 다음과 같이 출력되도록 쿼리를 작성하세요. ‘SCOTT의 매니저는 JONES이다’
select concat(a.ename, '의 매니저는 ', b.ename, '이다') 매니저관계 from emp a join emp b on a.mgr = b.empno;

-- 7. 'SCOTT'의 직무와 같은 사람의 이름, 부서명, 급여, 직무를 검색하세요.
select ename, dname, sal, job
from emp inner join dept using(deptno)
where job = (select job from emp where ename = 'scott');


-- 8. 'SCOTT’가 속해 있는 부서의 모든 사람의 사원번호, 이름, 입사일, 급여를 검색하세요.
select * from emp where ename = 'SCOTT';
select * from emp where deptno = 20;
select empno, ename, hiredate, sal from emp where deptno = 20;

select empno, ename, hiredate, sal 
from emp 
where deptno = (select deptno from emp where ename = 'scott');

-- 9. 전체 사원의 평균급여보다 급여가 많은 사원의 사원번호, 이름,부서명, 입사일, 지역, 급여를 검색하세요.
select avg(sal) from emp;

select empno, ename, dname, hiredate, loc, sal
from emp inner join dept using(deptno)
where sal > (select avg(sal) from emp);

-- 10. 30번 부서와 같은 일을 하는 사원의 사원번호, 이름, 부서명,지역, 급여를 급여가 많은 순으로 검색하세요.
select * from emp where deptno = 30;

select empno, ename, dname, loc, sal
from emp inner join dept using(deptno)
where job in (select job from emp where deptno = 30) order by sal desc;

-- 11. 10번 부서 중에서 30번 부서에는 없는 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일, 지역을 검색하세요.
select job from emp where deptno = 30 and deptno is not null;
select * from emp;
select * from dept;

select empno, ename, dname, hiredate, loc
from emp inner join dept using(deptno)
where job not in (select job from emp where deptno = 30 and deptno is not null)
AND	deptno = 10;

-- 12. ‘KING’이나 ‘JAMES'의 급여와 같은 사원의 사원번호, 이름,급여를 검색하세요.
select sal from emp where ename = 'KING' or ename = 'JAMES';

select empno, ename, sal
from emp
where sal in (select sal from emp where ename = 'KING' or ename = 'JAMES');

-- 13. 급여가 30번 부서의 최고 급여보다 높은 사원의 사원번호,이름, 급여를 검색하세요.
select empno, ename, sal
from emp
where sal >all (select sal from emp where deptno = 30);

-- 14. 이름 검색을 보다 빠르게 수행하기 위해 emp 테이블 ename에 인덱스를 생성하시오.
create index idx_emp_eanme on emp(ename);

-- 15. 이름이 'ALLEN'인 사원의 입사연도가 같은 사원들의 이름과 급여를 출력하세요.
select year(hiredate) from emp where ename = 'ALLEN';

select ename, sal
from emp
where year(hiredate) = (select year(hiredate) from emp where ename = 'ALLEN');

-- 16. 부서별 급여의 합계를 출력하는 View를 작성하세요.
create view emp_sal_sum
as select ifnull(sum(sal), 0) sum, dname 
from dept left outer join emp using(deptno) group by deptno;

-- 17. 14번에서 작성된 View를 이용하여 부서별 급여의 합계가 큰 1~3순위를 출력하세요.
select * from emp_sal_sum order by sum desc;