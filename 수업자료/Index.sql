-- Index의 생성
-- CREATE INDEX 인덱스명
-- ON 테이블명 (칼럼 [, 칼럼] ... );
CREATE INDEX IDX_EMP_ENAME ON EMP(ENAME);

DROP INDEX IDX_EMP_ENAME ON EMP;
CREATE INDEX IDX_EMP_ENAME ON EMP(SAL);

-- SELECT(조회)  *(모든 컬럼 데이터) FROM EMP(테이블명)
SELECT * FROM EMP;

SELECT * FROM EMP where ename = 'SMITH';

SELECT *
FROM EMP
WHERE SAL = 800		-- WHERE NOT SAL = 800;   NOT을 붙이는 순간 index는 날아감.
AND DEPTNO = 20;	-- OR 거는 순간, index는 다 날아간다.고 보면 됨.



-- index 이용 안 한다. (Full Table Scan)
SELECT *
FROM EMP
WHERE 1		
AND lower(ENAME) = 'SMITH';

-- index 이용 한다. (Non-Unique Key Lookup)
SELECT *
FROM EMP
WHERE 1		
AND ENAME = LOWER('SMITH');

-- 복합 컬럼 인덱스를 사용할 때는, 조건절에서 많이 쓰는 컬럼을 앞에다가 써야함.
SELECT *
FROM EMP
WHERE 1		
-- AND ENAME = 'SMITH'
AND SAL = 800;


CREATE VIEW VEMP
AS
SELECT ENAME, SAL, DEPTNO, JOB
FROM EMP
WHERE SAL >= 1000
and job is not null;

select * from VEMP;


SELECT ENAME, SAL
FROM VEMP
WHERE DEPTNO = 20
ORDER BY SAL DESC;

-- index single 보다 강력한 Single Row (EMP PRIMARY KEY)
SELECT *
FROM EMP
WHERE EMPNO = 7521;

insert into emp (empno, ename, sal) values(7200, 'MINI', 7777);

-- B*Tree index : 포인터 개념 // Claster index : 배열의 개념
-- 인덱스를 만들때, 본인이 B*Tree or Claster 를 정할 수 있다. 근데 MySQL에서는 CREATE하면 B*tree
-- CREATE index 를 만드는 것은 전부 B*Tree index다.

insert into emp (empno, ename, sal) values(7697, '홍길동', 1010);