create database wsdb03;
use wsdb03;

select * from emp;
select * from dept;
-- 1. 부서위치가 CHICAGO인 모든 사원에 대해 이름,업무,급여 출력하는 SQL을 작성하세요.
select ename, job, sal from dept where loc = 'CHICAGO';

select a.ename, a.job, a.sal 
from emp a inner join dept b on a.deptno=b.deptno
where b.loc='chicago';

select * from dept;
select * from emp;

-- 2) 부하직원이 없는 사원의 사원번호, 이름, 업무, 부서번호 출력하는 sql
select empno, ename, job, deptno 
from emp 
where empno not in (select distinct mgr from emp where mgr is not null);

-- exists 사용  (이중 루프라고!!! emp a 에서 한 건 가져와서 emp 건 수 만큼 있나없나 찾아본다!)
select *
from emp
where exists(select 1 from emp where ename = 'smith');


-- exists 위와 같은건데, exists 말고 다른 방법 보여주려고.. (근데, exists 사용하는게 훨 빠름.)  //백트래킹
select *
from emp a
where a.mgr in (select empno from emp where a.mgr = empno );

select *
from emp a
where a.empno not in (select distinct mgr from emp b where mgr is not null);





-- 3) Blake와 같은 상사를 가진 사원의 이름,업무, 상사번호 출력하는 sql
select ename, job, mgr 
from emp 
where mgr in (select mgr from emp where mgr = 
			 (select empno from emp where ename='blake') );

-- 4) 입사일이 가장 오래된 사람 5명 검색
select * from emp order by HIREDATE asc limit 5;

-- 5) jones의 부하직원의 이름, 업무, 부서명을 검색
select e.ename, e.job, d.dname 
	from emp e join dept d on e.deptno=d.deptno 
where e.mgr in (select mgr from emp where mgr = 
			   (select empno from emp where ename='jones'));


-- 5) 유진.
select a.ename, a job, c.dname
	from emp a, emp b, dept c
where a.mgr = b.empno
	and b.empno in
					(select empno from emp where ename = 'JONES')
	and a.deptno = c.deptno;

-- ansi 형식
select a.ename, a job, c.dname
	from emp a inner join emp b	on a.mgr = b.empno
			   inner join dept c on a.deptno = c.deptno
where b.empno in (select empno
					from emp
				 where ename = 'JONES')
                 
