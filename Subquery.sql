-- subQuery
-- 이름이 smith인 사람과 같은 부서의 직원정보를 조회하세요.
select deptno
from emp
where ename = 'smith';

select *
from emp
where deptno = 20;

-- 원래 2번의 쿼리문이 필요한데, 쿼리안의 쿼리로 한 번에 값을 뽑아냄.
-- 밖에 있는 기본 쿼리를 main쿼리라고 한다.
-- 내부(괄호 안)에 있는 Subquery가 먼저 돌아야, 다음이 가능하다.
-- 단일로우, 단일컬럼
select *
from emp
where deptno = (select deptno
				from emp
				where ename = 'smith');
				-- 조건절 Subquery
			-- from절에 들어가는 Subquery를 (Inline View)라고 한다.
		-- select문절에 들어가는 Subquery를 (Scala Subquery)라고 한다.
-- 상호연관 Subquery가 나오기전까지 돈다.?!?! (어려운거라 시험에 안나온다는데?!)


-- EXISTS  (TRIGGER 처럼 쓰는거 : 결과데이터가 있으면 돌리고 없으면 안 돌림.)
SELECT *
FROM EMP A
WHERE EXISTS (SELECT 1 FROM DEPT B WHERE A.DEPTNO = B.DEPTNO);
-- 연결된 애들은 보여주고 / 연결 안 됐으면 안 보여준다.


SELECT *
FROM EMP
WHERE EMPNO IN (SELECT DISTINCT MGR FROM EMP WHERE MGR IS NOT NULL);

SELECT *
FROM EMP B
WHERE EXISTS (SELECT 1 FROM EMP A WHERE A.EMPNO = B.MGR AND A.MGR IS NOT NULL LIMIT 1);


-- 이름이 smith 사람보다 급여를 많이 받는 직원의 정보
select *
from emp
where sal > (select sal
			from emp
			where ename = 'MARTIN');

-- 단일컬럼, 다중로우
-- 관리자인 직원 조회
select * from emp;
select distinct mgr from emp;

select *
from emp 
where empno in (select distinct mgr from emp);	-- empno은 하나인데, (select~)문은 여러개. 단일컬럼,다중로우는 '='이 안된다.
											-- 따라서, in 을 써줘야 함. 

select *
from emp 
where empno not in (select distinct mgr from emp where mgr is not null);
					-- // 관리자가 아닌 애들은 not in과 where ~ is not null을 써주면 됨.
                    

-- 단일컬럼, 다중로우
-- 업무가 salesman의 최저급여보다 많은 급여를 받는 직원조회
-- >any  <any  >all  <all  를 사용가능.
-- 1600, 1500, 1250, 1250
select *
from emp
where sal <all (select sal from emp where job = 'salesman')		-- 급여가 여러개라 > 이렇게 안됨.
order by sal;	
-- 같다는 in 으로 가능한데, 크다 작다는 >any  <any  >all  <all 
-- >any   :  내가 가지고 있는 값 1600, 1500, 1250, 1250 중 가장 작은값보다 큰 애들이 나온다.	1250 초과
-- >all   :  내가 가지고 있는 값 1600, 1500, 1250, 1250 중 가장 큰 값보다 큰 애들이 나온다.	1600 초과
-- <any   :  내가 가지고 있는 값 1600, 1500, 1250, 1250 중 가장 큰 값보다 작은 애들이 나온다.  1600 이하
-- <all   :  내가 가지고 있는 값 1600, 1500, 1250, 1250 중 가장 작은 값보다 작은 애들이 나온다. 1250 이하
select sal from emp where job = 'salesman';

select * from emp;


-- 다중컬럼 다중로우 Subquery
-- 부서별(group by) 최저급여를 받는 직원정보를 구하세요
select *
from emp
where (deptno, sal) in (select deptno, min(sal)
					from emp
					group by deptno);
-- 이러면 다른 부서에 최저급여를 받는 직원정보가 나온다.

select deptno, min(sal)
from emp
group by deptno;


-- inline view
-- 평균급여보다 많이 받고 최고급여보다 적게 받는 직원정보를 구하세요.
SELECT EMP.*, MAX, AVG
FROM (select DEPTNO, max(sal) MAX, avg(sal) AVG from emp GROUP BY DEPTNO) A, EMP	-- ','라 cross join 이 자동으로 되는데, 원래는 N*N인데, 1*N과 같으므로 상관이 없다.
WHERE A.DEPTNO = EMP.DEPTNO
AND EMP.SAL > A.AVG
AND EMP.SAL <= A.MAX;


select max(sal) MAX, avg(sal) AVG from emp;


-- COLUM 절의 Subquery
-- 사번 이름 급여 전체급여합
SELECT EMPNO, ENAME, SAL, (SELECT SUM(SAL) FROM EMP) '전체급여합'
FROM EMP;


-- 상호연관 Subquery
SELECT EMPNO, ENAME, SAL, DEPTNO
			,(SELECT SUM(SAL) FROM EMP A WHERE A.DEPTNO = B.DEPTNO) SUM
            ,(SELECT AVG(SAL) FROM EMP A WHERE A.DEPTNO = B.DEPTNO) AVG
            ,(SELECT MAX(SAL) FROM EMP A WHERE A.DEPTNO = B.DEPTNO) MAX
            ,(SELECT MIN(SAL) FROM EMP A WHERE A.DEPTNO = B.DEPTNO) MIN
FROM EMP B;

