-- 분석함수
use scott;

update emp set deptno = 10 where ename='king';

-- 부서별 급여합
select ename, sal
		, (select sum(sal) from emp b where a.deptno=b.deptno ) AS 부서별급여합
        , (select max(sal) from emp b where a.deptno=b.deptno ) AS 부서별최고급여
        , (select min(sal) from emp b where a.deptno=b.deptno ) AS 부서별최저급여
        , (select round(avg(sal)) from emp b where a.deptno=b.deptno ) AS 부서별평균급여
        , (select sum(sal) from emp b ) AS 부서별전체급여합 
from emp a;


-- 분석함수명 over(|partition by| |order by|)
-- 함수이름이 오버로드 됐다.   
-- 기본쿼리(select ~ from emp)가 도는데,   거기서   분석함수 : sum(sal) over() 가 돈다. 그리고 갖다 붙인다.
select ename, sal, sum(sal) over()
from emp;


-- 분석함수명 over(|partition by| |order by|)
-- 기존집계함수 overrode
-- sum, avg, max, min
select ename, sal
	, sum(sal) over(partition by deptno)
    , avg(sal) over(partition by deptno)
    , max(sal) over(partition by job)
    , min(sal) over(partition by job)
from emp;


-- 분석함수 전용함수
select ename, sal
		, rank() over(order by sal desc) r1
        , dense_rank() over(order by sal desc) r2
from emp;
-- order by sal desc;    -- 이 부분이 위 over 뒤로 붙음.

-- 랭크가 4등인 애만 뽑고 싶으면..
select *
from(
	select ename, sal
		, rank() over(order by sal desc) r1
        , dense_rank() over(order by sal desc) r2
	from emp
) a
where 1 = 1
and a.r2 = 4
;


-- 분석함수 전용함수
select ename, sal
		, rank() over(order by sal desc) r1
        , dense_rank() over(order by sal desc) r2
        , cume_dist() over(order by sal desc)*100 r3  -- cume_dist()는 내 급여가 몇 %냐?? --가장 못 받는 사람이 1,,  *100을 해서 100으로 만들어 줄 수 있음.
from emp;


-- 분석함수 전용함수
select ename, sal
		, rank() over(order by sal desc) r1
        , dense_rank() over(order by sal desc) r2
        , cume_dist() over(order by sal desc)*100 r3  -- cume_dist()는 내 급여가 몇 %냐?? --가장 못 받는 사람이 1,,  *100을 해서 100으로 만들어 줄 수 있음.
        , ntile(3) over(order by sal desc) r4		-- ntile 그룹을 나눔!!!  ntile(3) -> 그룹을 3개로 나눠준다!
from emp;


-- 분석함수 전용함수
select ename, sal, deptno
		, rank() over(partition by deptno order by sal desc) r1	-- 부서별로 나눈다! partition by
        , dense_rank() over(order by sal desc) r2
        , cume_dist() over(order by sal desc)*100 r3  -- cume_dist()는 내 급여가 몇 %냐?? --가장 못 받는 사람이 1,,  *100을 해서 100으로 만들어 줄 수 있음.
        , ntile(3) over(order by sal desc) r4		-- ntile 그룹을 나눔!!!  ntile(3) -> 그룹을 3개로 나눠준다!
        , row_number() over(order by sal desc, hiredate asc) r5		-- 자동으로 넘버링!!! 1,2,3,4,~~~,끝번호 
        -- row_number() 면, 에러가 발생한다. (급여가 같은 애들 순위를?!?!) ==> 조건을 하나 더 넣어준다(입사일 기준으로 hiredate asc)
from emp
order by sal desc;	-- 원래는 여기 밖에서 order by 를 해야 한다.   // 저기 조건절 안에서는 무엇을 기준으로 order by 하는지 명확하지가 않다.

-- select(1) from(2) where(3) group by(4) column절(5) order by(6) limit(7) 분석함수(8) 순으로 쿼리문이 실행된다!!!




-- 범위누적 집계
select empno, ename, sal, sum(sal) over(order by sal desc)		-- 값이 누적이 돼서 나온다.
from emp;


-- 범위누적 집계
select empno, ename
	, sal
    , sum(sal) over()	r1				-- 전체 집계 합
	, sum(sal) over(order by sal		-- 누적 집계 합
					rows 
                    2 preceding) r2		-- preceding 앞에 숫자는 1이면  내 앞에 1개,,  2이면 내 앞에 2개,,  따라서, 2이면 나 포함 3개
from emp;


-- 범위누적 집계
select empno, ename
	, sal
    , sum(sal) over()	r1				-- 전체 집계 합
	, sum(sal) over(order by sal		-- 누적 집계 합
					rows 
                   unbounded preceding) r2		-- 앞에 몇 개가 아니라, 앞에 전체를 다 누적시켜라.
from emp;



-- 범위누적 집계
select empno, ename
	, sal
    , sum(sal) over()	r1				-- 전체 집계 합
	, sum(sal) over(order by sal		-- 누적 집계 합
					rows 
                   unbounded preceding) r2		-- 앞에 몇 개가 아니라, 앞에 전체를 다 누적시켜라.
    , sum(sal) over(order by sal		-- 누적 집계 합
					rows 
                   between current row and 1 following) r3    	-- following 은 언제부터 언제까지 하라고 주어줘야 한다.  현재부터 뒤 1개까지           
-- 	, sum(sal) over(order by sal		-- 누적 집계 합
-- 					rows 
--                    1 following) r2          -- 이 문법은 안된다..  (내 자식 이름은 아냐? 모른다... 왜냐 없으니까..  부모님 성함은 알 거 아니냐.  그 논리다.
from emp;               



-- 범위누적 집계
select empno, ename
	, sal
    , sum(sal) over()	r1				-- 전체 집계 합
	, sum(sal) over(order by sal		-- 누적 집계 합
					rows 
                   unbounded preceding) r2		-- 앞에 몇 개가 아니라, 앞에 전체를 다 누적시켜라.
    , sum(sal) over(order by sal		-- 누적 집계 합
					rows 
                    between current row and 1 following) r3    	-- following 은 언제부터 언제까지 하라고 주어줘야 한다.  현재부터 뒤 1개까지           
	, sum(sal) over(order by sal
					rows
                    between unbounded preceding and unbounded following) r4		-- 전체합
from emp;            
                   
                   
-- 상 하위 데이터 추출
-- lag : 현재 ROW 기준으로 이전 값을 가져온다.
select ename, sal	
		, lag(sal, 1) over(order by sal) AS lag_AA		-- 하나 앞에 있는거
from emp
;

-- 상 하위 데이터 추출
select ename, sal
		, lag(sal, 1) over(order by sal) AS lag_AA
        , lag(sal, 2) over(order by sal) AS lag_AA2		-- 2개 앞에 있는거
from emp
;


-- 상 하위 데이터 추출
select ename, sal
		, lag(sal, 1) over(order by sal) AS lag_AA
        , lag(sal, 2) over(order by sal) AS lag_AA2		-- 2개 앞에 있는거
        , lag(sal, 2, sal) over(order by sal) AS lag_AA3		-- 나는 NULL이 싫어!!! default값을 뽑아서 넣어준다.
from emp
;


-- 상 하위 데이터 추출
-- lead함수 : 현재 ROW 기준으로 다음 행의 값을 가져온다.
select ename, sal
		, lead(sal, 1) over(order by sal) AS lag_AA
        , lead(sal, 2) over(order by sal) AS lag_AA2		-- 2개 앞에 있는거
        , lead(sal, 2, sal) over(order by sal) AS lag_AA3		-- 현재 ROW 기준으로 다음 행의 값을 가져오는데, 현재 ROW가 NULL이면, sal에 원래에 들어있는 값을 그대로 가져온다.
from emp
;