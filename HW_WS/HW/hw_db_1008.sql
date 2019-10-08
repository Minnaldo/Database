create database wsdb03;
use wsdb03;

-- 1. 부서위치가 CHICAGO인 모든 사원에 대해 이름,업무,급여 출력하는 SQL을 작성하세요.
select * from dept where loc = 'CHICAGO';

select ename, job, sal
from dept inner join emp
where loc = 'CHICAGO';

select * from dept;
select * from emp;

-- 2. 부하직원이 없는 사원의 사원번호,이름,업무,부서번호 출력하는 SQL을 작성하세요.



-- 3. BLAKE와 같은 상사를 가진 사원의 이름,업무,상사번호 출력하는 SQL을 작성하세요.


-- 4. 입사일이 가장 오래된 사람 5명을 검색하세요.
select *
from emp
where hiredate 

-- 5. JONES 의 부하 직원의 이름, 업무, 부서명을 검색하세요.
