-- 조인
-- 두 개 이상의 테이블을 연결하여 조회하는 방식
-- 조인의 종류
-- 1.inner join(내부조인) 
-- 2.outer join(외부조인)  /  (left outer, right outer, full outer)
-- 3.self join
-- 4.natural join
-- 5.cross join(교차조인)
-- 6.equi join(동등조인), non-equi join

-- 원래는 scott.emp.ename / scott.emp.sal 이런식으로  (데이터베이스명.테이블명.~~~) 로 적어야함.
-- 이름 급여 부서번호
select emp.ename as 이름, emp.sal as 급여, emp.deptno as 부서번호, dept.dname as 부서이름
from emp, dept;

-- **foreign key 는 조인 할 때 중요함. 인덱스에서 foreign key 에 무조건!!! **

-- foreign key 를 이용해서 두 개를 join 함.
select emp.ename as 이름, emp.sal as 급여, emp.deptno as 부서번호, dept.dname as 부서이름
from emp, dept
where emp.deptno = dept.deptno;	--  '=' 으로 비교 했으니 equi join(동등조인) 이며 // 같은애들만 검사하니 inner join(내부조인) 이다.


-- alias를 테이블에도 걸어줄 수 있다.
select a.ename as 이름, a.sal as 급여, a.deptno as 부서번호, b.dname as 부서이름
from emp a, dept b
where a.deptno = b.deptno;	--  '=' 으로 비교 했으니 equi join(동등조인) 이며 // 같은애들만 검사하니 inner join(내부조인) 이다.


-- 전통적 방식 
select a.ename as 이름, a.sal as 급여, a.deptno as 부서번호, b.dname as 부서이름
from emp a, dept b
where a.deptno = b.deptno;	-- 데이터 필터링 할 때 쓰는거지 '=' 은

-- ansi 형식 (너가 뭘 할 건지 직접 적어라 ',' 가 아닌 inner join)  **더 명확히 표시
select a.ename as 이름, a.sal as 급여, a.deptno as 부서번호, b.dname as 부서이름
from emp a inner join dept b on (a.deptno = b.deptno);	-- on ( ) 명확히 표시.

-- ansi 형식 (너가 뭘 할 건지 직접 적어라 ',' 가 아닌 inner join)  **더 명확히 표시
select a.ename as 이름, a.sal as 급여, a.deptno as 부서번호, b.dname as 부서이름
from emp a inner join dept b using(deptno);	-- 두 개의 컬럼명이 같을 때 비교를 on 대신 using으로 사용 할 수 있다.


-- 이름 급여 등급
-- non-equi join	(부등호로 비교)
select ename, sal, grade
from emp, salgrade
where emp.sal >= losal
and emp.sal <= hisal;

-- 이름 급여 등급
-- non-equi join	(부등호로 비교)
select ename, sal, grade
from emp, salgrade
where emp.sal between losal and hisal; -- 부등호로 비교한 것과 between으로 비교한 것은 같은 방법!

select * from salgrade;
select * from emp where ename = 'king';
update emp set deptno = null where ename = 'king';
select count(*) from dept;

-- 모든 사원의 이름 부서명 급여를 구하세요.
select ename, dname, sal 
from emp inner join dept on emp.deptno = dept.deptno;

-- 두 개의 테이블 중 주 테이블(앞) 부 테이블(뒤) 연결.
-- 주가 되는 테이블의 데이터는 부가 되는 테이블과 연결되지 않아도 다 나와야 한다.
select ename, dname, sal 
from emp left outer join dept on emp.deptno = dept.deptno;
-- left join 은 왼쪽 테이블이 주 / 오른쪽 테이블이 부

select ename, dname, sal 
from emp right outer join dept on emp.deptno = dept.deptno;
-- right join 은 오른쪽 테이블이 주 / 왼쪽 테이블이 부
-- outer join 은 inner 조인을 기반으로 하고, inner join 으로 해야 할 데이터가 다 나오고,
-- 주가 되는 테이블에서 부랑 연결되지 않은 데이터도 나온다.
--  따라서, 13개가 원래 나와야하지만, 거기에 추가해서 주가 되는 테이블에 남아있는 데이터까지 14개가 나온다.

-- full outer join : 양쪽 테이블을 주가 되는 테이블로 만든다.  그런데 MySQL은 지원하지 못한다.
-- inner join으로 : 13개,,  outer join으로 : 14개,, 거기에 빠져있는 king 아저씨까지(+1) 총 15개


-- 사원번호, 사원명, 급여, 관리자번호, 관리자명
select b.empno, b.ename, b.sal, b.mgr, a.ename, a.sal -- mgr(관리자번호) 가 사번이 된다.
from emp a, emp b		-- self join 이 나옴.
where a.empno = b.mgr;
-- a:관리자테이블, b:사원테이블 이 된다.

-- ansi 방식
select b.empno, b.ename, b.sal, b.mgr, a.ename, a.sal -- mgr(관리자번호) 가 사번이 된다.
from emp a join emp b on a.empno = b.mgr;	-- 이 때는 using을 쓸 수 없다. (연결하는 컬럼명이 다르기 때문에.)


-- 사원의 이름, 급여, 관리자명, 관리자급여등급
select a.ename, a.sal, b.ename, c.grade
from emp a, emp b, salgrade c
where a.mgr = b.empno
and b.sal between c.losal and c.hisal;
-- a:사원 테이블 / b:관리자

-- ansi 방식
-- 사원의 이름, 급여, 관리자명, 관리자급여등급
select a.ename, a.sal, b.ename, c.grade
from emp a join emp b on a.mgr = b.empno
		   join salgrade c on b.sal between c.losal and c.hisal;


-- natural join
-- 사번 이름 급여 부서명
select empno, ename, sal, dname
from emp natural join dept;		-- king아저씨랑 부서번호 없어서 13개가 나온다.
							-- 이름이 같은 칼럼이 있으면, 자동으로 on이 사용되어진다.

-- cross join
-- 사번 이름 급여 부서명
select empno, ename, sal, dname
from emp join dept;
-- 조건없이 그냥 join만 쓰는것. (N*N 방식)

           
-- 사번 이름 급여 부서명 관리자이름 관리자급여등급
-- (단, 관리자가 없는 사원도 같이 나오게 하세요.)
-- (관리자가 없을때는 '관리자없음' 으로 표시해주세요.
select a.empno, a.ename, a.sal, ifnull(c.ename, "관리자없음") manname, ifnull(d.grade, "관리자없음") mangrade
from emp a left outer join dept b on a.deptno = b.deptno
		left outer join emp c on a.mgr=c.empno
        left outer join salgrade d on c.sal between d.losal and d.hisal;



select * from emp;
select * from salgrade;


-- 두 테이블을 붙여서 보여줌.	==> cross join 이다. (다 곱해서 보여준다.)
select * from emp,dept;

-- DEPTNO이 같은 애들로 join 되어 보여진다.
select * from emp,dept
where emp.deptno = dept.deptno;

select * from emp;
select count(*) from emp;
select * from dept;
select count(*) from dept;
select * from salgrade;

-- emp 의 deptno 다 검색
select deptno from emp;
-- emp 의 deptno 중 중복된 애 제거하고 검색
select distinct deptno from emp;


-- 부서번호로 dept에 있는 dname(부서이름)을 알아내자.