select * from tab;
--한줄 주석;
/*
sql 5가지 명령어 세트로 구성되어 있다.
1. DQL(Data Query Language): 데이터 조회어 
   Select문
   데이터 베이스에서 데이터를 검색해서 사용자가 원하는 데이터를 확인 및 사용할 수 있다.
2. DML(Data Manpulation Language): 데이터 조작어
   INSERT, ALTER, DROP, TRUNCATE
   데이터베이스의 테이블에 새로운 행의 삽입, 수정, 삭제
3. DDL(Data Definition Language): 데이터 정의어
   CREATE, VIEW, DROP, TRUNCATE
   데이터베이스에 태이블의 생성, 변경, 삭제 등을 하는 명령어
   테이블 뷰, 유저, 시퀀스 동의어
4. DCL(Data Control Language): 데이터 컨트롤
   GRANT(부여), REVOKE(제거)
   데이터베이스에 접속하는 사용자에게 데이터베이스와 그 안에 구조에 대한 액세스 권한을 부여 또는 제거
5. TCL(Transaction Control Language): 데이터 수행 처리단위
   COMMIT, SAVEPOINT, ROLLBACK
   어느 시점의 데이터 저장, 되돌리기 등...
 
*/

/*
1. DQL: SELECT 문의 사용목적: 데이터베이스에 저장된 데이터를 사용자 프로그램에서 사용하기
   위해서 SELECT문을 이용하여 질의할 수 있다. 즉, 프로그램에서 처리할 데이터를 사용자 
   프로그램으로 가져오기 위해 사용한다. DB에서 읽어오기만 하니까 DB 내용은 변하지 않는다.
   오라클 대소문자 구분 안 한다. 컬럼 이름은 구분한다.(예. SMITH, Smith)
   기본 문법 : SELECT 컬럼1, 컬럼2, ..., 컬럼n(와일드 문자 *는 전부 선택) FROM 테이블명,
   소유자명 - FROM절
   WHERE 조건 -WHERE절

   단순 SELECT문은 하나의 테이블 대해 질의할 때 사용, FROM절에 테이블 명만 명시한다.
   SQL문의 종료 시 ;으로 마무리.
*/

-- EMP 테이블에서 모든 정보를 조회하시오.
SELECT *
FROM EMP;

-- EMP 테이블에서 사번, 이름, 급여, 부서번호를 조회

select EMPNO, ENAME, SAL, DEPTNO
FROM EMP;

-- 테이블의 구조를 알 수 있는 명령어, 오라클에만 있음. 
DESCRIBE EMP;
DESC EMP; -- 오라클 명령엉 일 경우는 ; 생략 가능함.

--유저가 가지고 있는 모든 테이블을 검색
SELECT * 
FROM TAB;

--DEPT테이블: 부서 정보를 가지고 있는 테이블
--DEPT테이블의 구조를 파악하고 모든 정보를 표시해보자

DESC DEPT;
SELECT * 
FROM DEPT;

--컬럼에서 NUMBER, DATE 유형은 산술 연산이 가능하다.
--NUMBER(+, -, *, /) DATE(+, -) 연산 가능
--EMP테이블에서 부서번호 20번인 사원의
-- 사번, 이름, 급여, 급여에 100을 더해
--출력해보자.

SELECT empno, ename, SAL, SAL + 100, DEPTNO
FROM EMP
WHERE DEPTNO=20;

-- 부서번호 30인 사원의 사번, 이름, 급여, 입사일, 부서번호

SELECT EMPNO, ENAME, SAL, HIREDATE, DEPTNO
FROM EMP
WHERE DEPTNO = 30;

-- 모든 사원의 사번, 이름, 급여, 연봉, 입사일, 부서번호
-- 연봉: (급여*12) + 커미션
--컬럼을 계산할 때 컬럼의 값이 NULL이면 계산 값은 무조건 NULL이 된다.

SELECT EMPNO, ENAME, SAL, (SAL * 12) + COMM, HIREDATE, DEPTNO
FROM EMP;

--계산 시 NULL값을 해결하는 방법: 단일행 함수 NVL()
--NVL(COMM, 0) COMM이 NULL이면 0으로 치환해라.
SELECT EMPNO, ENAME, SAL, (SAL * 12) + NVL(COMM, 0), HIREDATE, DEPTNO
FROM EMP;

--부서번호 20번인 사원의 사번, 이름, 연봉, 부서번호를 출력해보자.
-- 연봉: (급여*12) + 커미션

SELECT EMPNO, ENAME, (SAL * 12) + NVL(COMM, 0), DEPTNO
FROM EMP
WHERE DEPTNO=20;

--컬럼의 별칭(ALIAS), 별명을 사용해서 HEADING글 변경하기
--부서번호 30번의 사원의 사번, 이름, 연봉, 부서번호를 출력

SELECT EMPNO AS 사번, ENAME AS 사원명, (SAL * 12) + NVL(COMM, 0) AS 연봉, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO=30;

--부서번호 10번인 사원의 사번, 이름, 연봉, 입사일, 부서번호 출력
--AS 생략 가능하지만, 왠만하면 명기 요망

SELECT EMPNO AS 사번, ENAME AS 이름, (SAL * 12) + NVL(COMM, 0) AS 연봉, HIREDATE AS 입사일, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO = 10;

--컬럼명을 붙여서 사용하기 연산자 ||(여산자)
SELECT EMPNO||ENAME AS 사원정보
FROM EMP
WHERE DEPTNO=20;

--EMP테이블에서 부서번호를 출력
--중복값 제거
SELECT DISTINCT DEPTNO
FROM EMP;
/* SELECT문에서 조건 검색
WHERE절 산술연산자, BETWEEN, IN(), LIKE 연산자
논리 연산자 AND, OR, NOT
*/
--EMP테이블에서 이름이 KING이고 부서번호 10인 사원의 
--사번, 이름, 급여, 입사일, 직책, 부서번호를 출력해보자

SELECT EMPNO, ENAME, (SAL * 12) + NVL(COMM, 0), HIREDATE, JOB, DEPTNO
FROM EMP
WHERE ENAME='KING' AND DEPTNO=10;

--EMP테이블에서 입사일이 80년 12월 1일보다 늦게 입사한
--사원의 사번, 이름, 입사일 출력
--날짜는 어느 시점에서 0초부터 60*60*24*365

SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE HIREDATE>'81/12/01';

--부서번호가 20번이고 입사일이 81/05/31보다 늦은 사람의
-- 사번, 이름, 이사일, 부서번호를 출력

SELECT EMPNO AS 사번, ENAME AS 이름, HIREDATE AS 입사일, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO=20 AND HIREDATE>'81/05/31';

-- 단순 비교 연산자(=, <, >, <= >=, !=, ^=)
-- 급여가 1500보다 작거나 같은 사원의 정보를 출력
-- 사번, 이름, 급여, 부서번호 출력

SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL<=1500;

--급여가 2000보다 많은 사원의 사번, 이름, 급여, 부서번호, 출력

SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL>2000;

--EMP테이블에서 SAL가 1000보다 작거나 3000보다 큰 사원의 사번, 이름, 급여, 부서번호 출력
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL < 1000 OR SAL > 3000;

--EMP테이블에서 SAL 1500과 3000 사이의 사원의 사번, 이름, 급여, 부서번호 출력
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL >= 1500 AND SAL <= 3000;

SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL BETWEEN 1500 AND 3000;

--입사일이 81/03/03 ~ 82/01/01
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호, HIREDATE AS 입사일
FROM EMP
WHERE HIREDATE BETWEEN '81/03/03' AND '82/01/01';

--EMP테이블에서 부서번호 10이거나 20번인 사원의 사번, 이름, 급여, 입사일, 부서번호 출력
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO = 10 OR DEPTNO =20;

--IN() 연산자
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO IN(10, 20);
-- SAL가 800, 1200, 3000인 사원의 정보를 출력
-- 사번, 사원명, 급여, 부서번호
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL IN(800, 1200, 3000);
-- LIKE 연산자: 문자 데이터형 전용, 값이 명시된 패턴과 동일한지 비교
-- 와일드 문자 %(모든 수), _(한글자 대치)
-- EMP테이블에서 이름이 'A'로 시작하는 사원을 검색
SELECT *
FROM EMP
WHERE ENAME LIKE 'A%';
-- EMP테이블에서 이름이 'K'로 시작하는 사원을 검색
SELECT *
FROM EMP
WHERE ENAME LIKE 'K%';
--이름에 두 번째 글자가 M인 사원의 정보 출력
SELECT *
FROM EMP
WHERE ENAME LIKE '_M%';

--마지막 바로전 글자가 N인 사원의 정보를 출력해보자
SELECT *
FROM EMP
WHERE ENAME LIKE '%N_';

--이름의 세 번째 글자가 'A'인 사원의 정보를 출력
SELECT *
FROM EMP
WHERE ENAME LIKE '__A%';

-- %, _ 와일드 문자를 검색해야 될 필요성이 있을 때

CREATE TABLE TEST01(J_CODE VARCHAR2(30));
INSERT INTO TEST01 VALUES('ADPRES');
INSERT INTO TEST01 VALUES('AD_PRES');
INSERT INTO TEST01 VALUES('AD_%PRES');
COMMIT;

SELECT *
FROM TEST01;

SELECT * 
FROM TEST01
WHERE J_CODE LIKE 'AD_%'; -- 와일드문자 _

--AD_ESCAPE문은 다음에 나오는 글자를 오일드문자가 아닌 일반 문자로 인식하게 한다.
SELECT * 
FROM TEST01
WHERE J_CODE LIKE 'AD\_%' ESCAPE '\';

--AD_% 와일드 문자가 아닌 일반문자로 검색 출력해보자
SELECT * 
FROM TEST01
WHERE J_CODE LIKE 'AD%\_\%%' ESCAPE '\';

DROP TABLE TEST01;

SELECT * FROM TAB;

PURGE RECYCLEBIN;
SELECT * FROM TAB;

-- NULL인 컬럼값 조회, IS NULL, IS NOT NULL
SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NULL;

SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NOT NULL;

-- AND, OR, NOT
-- MANAGER IS NULL이고 SAL 3000보다 큰 모든 직원을 출력

SELECT *
FROM EMP
WHERE MGR IS NULL AND SAL > 3000;

--MGR IS NOT NULL이거나 SAL 4500보다 작은 직원
SELECT *
FROM EMP
WHERE MGR IS NOT NULL OR SAL < 4500;

--NOT 연산: 조건이 거짓이어야 연산외 됨.
--WHERE 절에서 연산자에 대한 NOT 연산자의 사용 예
--WHERE JOB NOT IN('CLERK', 'PRESIDENT');
--WHERE SAL NOT BETWEEN 800 AND 1500;
--WHEER ENAME NOT LIKE '%A%';
--WHERE COMM IS NOT NULL;
/*
ORDER BY절: 결과 레코드를 정렬해서 표시하고자 할 때 사용
SELECT 컬럼1,..., 컬럼n
FROM 테이블명
[WHERE 조건]: 생략 가능
[ORDER BY]: 생략 가능
ORDER BY 컬럼명, ALIAS;
OPTION: ASC: 오름차순 작은 거->큰 거, DESC: 내림차순 큰 거 -> 작은 순
DEFAULT: ASC, 그래서 생략 가능.
*/
-- EMP 테이블에서 부서번호로 정렬해보자.
SELECT *
FROM EMP
ORDER BY DEPTNO ASC;

--EMP 테이블에서 부서번호 30번인 사원을 급여 순으로 정렬해보자.
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO=30
ORDER BY SAL;

SELECT EMPNO AS 사원번호, ENAME AS 사원명, (SAL*12) + NVL(COMM, 0) AS 연봉, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO=30
ORDER BY 연봉; --ALIAS로 ORDER BY된다.

SELECT EMPNO, DEPTNO
FROM EMP
ORDER BY 2; -- 2번째 컬럼으로 정렬해라

--NULL값이 있는 컬럼의 정렬
SELECT EMPNO, ENAME, COMM, DEPTNO
FROM EMP
WHERE DEPTNO=30
ORDER BY 3 ASC NULLS FIRST; --NULL값을 먼저 출력

SELECT EMPNO, ENAME, COMM, DEPTNO
FROM EMP
WHERE DEPTNO=30
ORDER BY 3 ASC NULLS LAST; --NULL값을 마지막에 출력

--1일차 문제
--1.
SELECT ENAME, SAL, HIREDATE
FROM EMP
DESC EMP;

--2.
SELECT ENAME, SAL, HIREDATE
FROM EMP
WHERE DEPTNO = 20;

--3.
SELECT ENAME, (SAL * 12) +NVL(COMM, 0) AS 연봉, HIREDATE
FROM EMP;

--4.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL BETWEEN 1000 AND 4000;

--5.
SELECT ENAME, SAL, HIREDATE
FROM EMP
WHERE ENAME LIKE 'S%';

--6.
SELECT ENAME AS 이름, (SAL * 12) +NVL(COMM, 0) AS 연봉, EMPNO AS 사번, SAL AS 급여, HIREDATE AS 입사일, 
FROM EMP
WHERE COMM IS NULL;

--7.
SELECT ENAME AS 이름, SAL AS 급여, (SAL * 12) + NVL(COMM, 0) AS 연봉
FROM EMP
WHERE DEPTNO = 30
ORDER BY 연봉 DESC;

--8.
SELECT *
FROM DEPT
ORDER BY DEPTNO;