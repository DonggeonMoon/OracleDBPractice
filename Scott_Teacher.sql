--한줄주석
/*
SQL은 대소문자 구분 안한다. 컬럼의 내용은 구분한다.
컬럼 NAME = 'Smith' , 'SMITH'
5가지 명령어 SET를 배우게 된다.
1. DQL (DATA QUERY LANGUAGE) : 
    SELECT
2. DML (DATA MANIPULATION LANGUAGE) : 
    INSERT, UPDATE, DELETE
3. DDL (DATA DEFINITION LANGUAGE) :
    CREATE, DROP, ALTER, TRUNCATE, RENAME
4. DCL (DATA CONTROL LANGUAGE) :
    GRANT, REVOKE
5. TCL (TRANSACTION CONTLOL LANGUAGE) :
    COMMIT, ROLLBACK, SAVEPOINT
*/
/*DQL : SELECT문 사용목적 : 데이터베이스에 저장된 데이터를
사용자 프로그램에서 사용하기위해서 SELECT문을 이용해서 
질의 할 수 있다. 즉, 프로그램에서 처리할 데이터를 사용자 
프로그램으로 가져오기 위해 사용한다. DB에서 읽어오기만 하니까
DB내용은 변하지 않는다.

기본문법
SELECT 컬럼1, 컬럼2, .... ,컬럼n (전부 *) SELECT 절
FROM 테이블명 , 소유자명  FROM 절
WHERE 조건 - WHERE 절
끝낼때는 ;으로 마무리 */

SELECT * FROM TAB; //SCOTT이 가지고 있는 테이블 목록표시
SELECT * FROM EMP; //EMP테이블의 내용 출력
DESCRIBE EMP;//EMP테이블의 구조 파악
DESC EMP; //DESCRIBE 약자..

--DEPT 테이블의 구조를 파악?
DESC DEPT;
SELECT * FROM DEPT;
--SALGRADE 테이블의 구조를 파악하고, 모든 정보를 출력
DESC SALGRADE;
SELECT * FROM SALGRADE;
--EMP 구조를 알아야 컬럼값을 선택해서 출력할 수 있다.
--EMP테이블 사번, 이름, 급여, 부서번호를 선택해서 출력
DESC EMP;
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP;
--SELECT절에서 단순 연산을 지원한다.
--EMP테이블에서 사번, 이름, 급여, 급여*12 , 부서번호출력
SELECT EMPNO, ENAME, SAL, SAL*12 , DEPTNO
FROM EMP;

--ALIAS (별칭, 별명) , 헤딩을 바꿀 수 있다.
--EMP테이블에서 사번, 이름, 급여, 급여*12 를 연봉으로, 부서번호
SELECT EMPNO, ENAME, SAL, SAL*12 연봉, DEPTNO
FROM EMP;

--진정한 연봉 급여*12 + COMM이 진정한 연봉..
SELECT EMPNO, ENAME, SAL, SAL*12 + COMM 연봉, DEPTNO
FROM EMP;
--NVL단일행 함수..사용해서 NULL 처리 , NVL(COMM,0)
--ORACLE은 컬럼이 NULL일경우 연산시 모두 NULL로 처리됨.
SELECT EMPNO, ENAME, SAL, SAL*12 + NVL(COMM,0) 연봉, DEPTNO
FROM EMP;

--조건 검색 WHERE 절
--EMP테이블에서 부서번호 20인 사원 정보를 검색..
SELECT *
FROM EMP
WHERE DEPTNO=20;

--EMP테이블에서 부서번호 30번인 사원의 사번, 이름, 급여
--연봉, 부서번호를 출력해라..
SELECT EMPNO, ENAME, SAL, SAL*12 + NVL(COMM,0) AS 연봉, DEPTNO
FROM EMP
WHERE DEPTNO=30;

--컬럼을 붙여서 출력하기 || (연산자) 
--EMP테이블에서 부서번호 20번은 사원들의 사번, 이름을 
--붙여서 출력하되 별칭을 사원정보로 하시오.
SELECT EMPNO||ENAME AS 사원정보
FROM EMP
WHERE DEPTNO = 20;
--중복제거 DISTINCT연산자
--중복허용 ALL연산자 DEFAULT 생략가능.
SELECT DISTINCT DEPTNO
FROM EMP;

/*SELECT문에서 조건 검색
WHERE절 : 산술연산자, BETWEEN, IN(), LIKE 연산자,
          논리연산자(AND, OR, NOT)...
*/
--EMP에서 이름이 KING이고 부서번호 10번인 사원의 사번
--이름, 급여, 입사일, 부서번호를 출력해보자.
SELECT EMPNO 사번,ENAME 이름,SAL 급여,HIREDATE 입사일,DEPTNO 부서번호
FROM EMP
WHERE ENAME='KING' AND DEPTNO=10;
--날짜 연산이 가능하다. EMP에서 81년 12월 1일보다 늦게
--입사한 사원의 사번, 이름, 입사일, 부서번호 출력
SELECT EMPNO 사번,ENAME 이름,HIREDATE 입사일,DEPTNO 부서번호
FROM EMP
WHERE HIREDATE > '81/12/01';

--부서번호가 20이고 입사일이 81/05/31일보다 늦은사람의
--사번, 이름, 입사일, 부서번호를 출력해보자.
SELECT EMPNO,ENAME ,HIREDATE, DEPTNO
FROM EMP
WHERE DEPTNO=20 AND HIREDATE > '81/05/31';

--단순 비교 연산자 (= , <, >, <=, >=, !=, ^=) =<에러
--급여가 1500보다 작거나 같은 사원의 정보를 출력
--사번, 이름, 급여, 부서번호.
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL <= 1500;
--급여가 1000보다 크고 3000보다 작은 사원의 정보를 출력
--사번, 이름, 급여, 부서번호.
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL > 1000 AND SAL < 3000;

--급여가 1500에서 3000사이의 사원의 정보 출력
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL >=1500 AND SAL <=3000;

--BETWEEN A AND B , 가독성을 위해서 사용한다.
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL BETWEEN 1500 AND 3000;

--부서번호가 10번 이거나 20번인 사원의 정보를 출력
--EMPNO, ENAME, SAL, DEPTNO
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO=10 OR DEPTNO=20;
--IN()연산자. 가독성을 높임
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN(10,20);
--문자열 비교 연산자 LIKE연산자
--와일드 문자 %(모든수), _(한글자대치)
--EMP테이블에서 이름이'A'로 시작하는 사원을 검색
SELECT *
FROM EMP
WHERE  ENAME LIKE 'A%';
--EMP에서 이름이 'H'로 끝나는 사원을 검색
SELECT *
FROM EMP
WHERE  ENAME LIKE '%H';
--이름에서 두번째 글자가 'I'인 사원을 검색
SELECT *
FROM EMP
WHERE  ENAME LIKE '_I%';
--이름에 마지막전 문자가 N인 사원을 출력
SELECT *
FROM EMP
WHERE ENAME LIKE '%N_';
--이름에 3번째 글짜가 'A'인 사원을 검색
SELECT *
FROM EMP
WHERE ENAME LIKE '__A%';
-- %, _ 와일드 문자를 검색해야 될 필요성이 있을때
CREATE TABLE TEST01(J_CODE VARCHAR2(30));
INSERT INTO TEST01 VALUES('ADPRES');
INSERT INTO TEST01 VALUES('AD_PRES');
INSERT INTO TEST01 VALUES('AD_%PRES');
COMMIT;

SELECT * 
FROM TEST01
WHERE J_CODE LIKE 'AD_%';
--ESCAPE 다음에 나오는 글자는 와일드 문자가 아니고 
--일반문자로 인식해라.
SELECT *
FROM TEST01
WHERE J_CODE LIKE 'AD\_%' ESCAPE '\'; --AD_ 일반문자

SELECT *
FROM TEST01
WHERE J_CODE LIKE 'AD\_\%%' ESCAPE '\';--AD_% 일반문자

DROP TABLE TEST01; //테이블을 삭제와 동시에 휴지통도 비움
PURGE RECYCLEBIN;

--NULL인 컬럼값 조회 , IS NULL, IS NOT NULL
SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NOT NULL;

--AND , OR, NOT
--MGR IS NULL이고 SAL 3000보다 큰 직원을 출력해보자.
SELECT *
FROM EMP
WHERE MGR IS NULL AND SAL >3000;
--MGR IS NOT NULL이거나  SAL <4500 작은 직원
SELECT *
FROM EMP
WHERE MGR IS NOT NULL OR  SAL <4500;
--NOT연산 : 조건이 거짓이어야 연산이 됨.
--WHERE절에서 연산자에 대한 NOT 사용 예
--WHERE JOB NOT IN ('CLERK', 'PRESIDENT');
--WHERE SAL NOT BETWEEN 800 AND 1500;
--WHERE ENAME NOT LIKE '%A%';
--WHERE COMM IS NOT NULL;
/*정렬 ORDER BY절
SELECT 컬럼
FROM 테이블
[WHERE 조건] [] : 생략가능
[ORDER BY 컬럼];
ORDER BY절은 맨마지막에 기술한다.
ORDER BY 컬럼, ALIAS, 숫자;
옵션 : ASC (오름차순), DESC (내림차순), DEFAULT : ASC 생략가능.
*/
--EMP테이블에서 부서번호로 정렬해보자..
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
ORDER BY DEPTNO;

--EMP에서 부서번호 30번인 사원들의 정보를
--급여순으로 정렬해보자.. 내림차순으로
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 30
ORDER BY SAL DESC;

--EMP에서 부서번호 30번인 사원을 연봉순으로 정렬해보자
SELECT EMPNO, ENAME ,SAL ,SAL*12 + NVL(COMM,0) AS 연봉, DEPTNO
FROM EMP
WHERE DEPTNO = 30
ORDER BY 연봉 DESC;

--숫자로 정렬, 3 SELECT 두번째 컬럼으로 정렬해라.
SELECT EMPNO, ENAME ,SAL , DEPTNO
FROM EMP
WHERE DEPTNO = 30
ORDER BY 3 DESC;

--NULL값이 있는 컬럼의 정렬
SELECT EMPNO, ENAME, COMM, DEPTNO
FROM EMP
ORDER BY 3 ASC NULLS FIRST; --NULL먼저 출력후 정렬

SELECT EMPNO, ENAME, COMM, DEPTNO
FROM EMP
ORDER BY 3 ASC NULLS LAST; --정렬후 NULL값 출력

/*단일 행 함수 : 오라클과 다른 DB하고 이름, 사용법 차이가 
날수 있다.
1.문자 함수 : 처리되는 데이터가 문자 유형 데이터
2.숫자 함수 : 처리되는 데이터가 숫자 유형 데이터
3.날짜 함수 : 처리되는 데이터가 날짜 유형 데이터
4.일반 함수 : 처리되는 데이터가 데이터 유형 데이터
5.형변환함수 : 처리되는 데이터가 SQL문 처리 중에 다른 
        데이터 유형으로 변경할 필요가 있을때 사용.
        *숫자, 날짜 데이터를 문자 데이터로 변환
        *문자 데이터를 날짜, 숫자 데이터로 변환
*/
--DUAL 테이블 : 오라클 서버에 접속하는 모든 계정이 함수의
--테스트 등을 사용할 수 있도록 제공되는 가상 테이블..
DESC DUAL
--문자 단일행 함수 UPPER('문자열')함수 , LOWER('문자열')함수
--INITCAP('문자열')함수 
--대문자/소문자/첫글자대문자 나머지소문자
SELECT UPPER('abcd efg hijk') AS "UPPER",
        LOWER('ABCD EFG HIJK') AS "lower",
        INITCAP('aBCD eFG hIJK') AS  "InitCap"
FROM DUAL;

--EMP 부서번호 20번인 사원의 이름을 모두 소문자로 표시
--JOB컬럼을 첫글자 대문자 나머지 소문자로 표시해보자.
SELECT LOWER(ENAME) ,INITCAP(JOB), UPPER(ENAME)
FROM EMP
WHERE DEPTNO = 20;
--예를 들어서 이름 : KIM, KiM, kIm, KIm, klm
--SELECT ENAME
--FROM EMP
--WHERE UPPER(ENAME) = 'Kim';
--CONCAT('문자열','문자열')함수 : 두 문자열을 붙인다.
SELECT CONCAT('HELLO','WORLD')
FROM DUAL;
--SUBSTR('문자열',시작위치,[추출할 문자 수])함수
--데이터로부터 원하는 문자열을 추출
SELECT SUBSTR('20080815',1,4),--1번째 부터 4글자
        SUBSTR('20080815',5,2),--5번째 부터 2글자
        SUBSTR('20080815',6),--7번째 마지막 글짜까지
        SUBSTR('20080815',-3)-- 뒤에서부터 2자리
FROM DUAL;

--LENGTH('문자열')함수 : 문자열의 길이를 글자수로 반환
--LENGTHB('문자열')함수 : 문자열의 길이를 바이트 수로 반환
SELECT LENGTH('홍길동'),LENGTHB('홍길동')
FROM DUAL;

--REPLACE('문자열','찾을문자','대체문자')함수
--문자열에서 문자(열)을 찾아서 문자(열)로 교체
SELECT REPLACE('JACK AND JUE','J','BL'),
        REPLACE('JAVA ORACLE', 'JA', 'ORA')
FROM DUAL;

--TRIM('문자'FROM'문자열')함수: 문자열의 양 끝에 
--연속된 문자를 삭제, 중간 에 있는 문자는 삭제 불가
--1,2번은 양끝 S삭제, LEADING 앞쪽, TRAILING 뒤쪽
SELECT TRIM(BOTH 'S' FROM 'SSMISTHSS') AS "R1",
       TRIM('S' FROM 'SSMISTHSS') AS "R2",
       TRIM(LEADING 'S' FROM 'SSMISTHSS') AS "R3",
       TRIM(TRAILING 'S' FROM 'SSMISTHSS') AS "R4"
FROM DUAL;

SELECT LTRIM('SSMISTHSS', 'S') AS "R1",--왼쪽잘라내기
       RTRIM('SSMISTHSS', 'S') AS "R2",--오른쪽
       LTRIM(RTRIM('SSMISTHSS', 'S'),'S') AS "R3"--양쪽
FROM DUAL;

--LPAD('문자열',출력시 사용되는 BYTE길이,'남은 빈칸을채울 문자')함수
--RPAD('문자열',출력시 사용되는 BYTE길이,'남은 빈칸을채울 문자')함수
SELECT LPAD('SMITH',10,'*') AS "RESULT"
FROM DUAL;

SELECT RPAD('SMITH',10,'*') AS "RESULT"
FROM DUAL;

--INSTR('문자열','찾을문자(열)'[,검색 시작 자리수 , 존재회수])함수
--찾을 문자나 문자열이 있으면 그 문자나 문자열이 시작된 자리수 반환,
--값이 없으면 0값을 반환
SELECT INSTR('HELLO ORACLE','L',1,1) AS "R1",
    INSTR('HELLO ORACLE','L') AS "R2",
    INSTR('HELLO ORACLE','L',4,2) AS "R3",
    INSTR('HELLO ORACLE','L',4,3) AS "R4",
    INSTR('HELLO ORACLE','L',-8,2) AS "R5",
    INSTR('HELLO ORACLE','ORACLE') AS "R6"
FROM DUAL;

SELECT EMPNO, CONCAT(ENAME, JOB) AS "NAMEJOB",
  LENGTH(ENAME), INSTR(ENAME,'A') AS "CONTAINS A?"
FROM EMP
WHERE SUBSTR(JOB,4) = 'RK';

--숫자 단일행 함수.
--MOD(숫자1, 숫자2)함수 : 숫자1을 숫자2로 나누고 남은 나머지반환
SELECT MOD(1600,2)
FROM DUAL;
--ROUND(숫자[,소수점 이하 유효 자리수])함수
SELECT ROUND(1745.9260,4) AS "R1",--소수점 4자리를 반올림
       ROUND(1745.9260,1) AS "R2",
       ROUND(1745.9260,0) AS "R3",--수수점 첫자리 반올림
       ROUND(1745.9260) AS "R4" --소수점 없음.
FROM DUAL;

SELECT ROUND(1745.9260,-1) AS "R1",--1의 자리 반올림
       ROUND(1745.9260,-2) AS "R2",--10의 자리
       ROUND(1745.9260,-3) AS "R3",--100의 자리
       ROUND(1745.9260,-4) AS "R4"--1000의 자리
FROM DUAL;
--TRUNC(숫자[,소수점 이하 유효 자리수])함수 : 소수점 이하 
--유효자리수 절삭
SELECT TRUNC(1745.9260, 4) AS "R1",--소수점 4자리 무조건 절삭(버림)
       TRUNC(1745.9260, 2) AS "R2",--소수점 2자리 무조건 절삭(버림)
       TRUNC(1745.9260, 0) AS "R3",--소수점 없음
       TRUNC(1745.9260) AS "R4"--소수점 없음.
FROM DUAL;

SELECT TRUNC(1745.9260, -1) AS "R1",
       TRUNC(1745.9260, -2) AS "R2",
       TRUNC(1745.9260, -3) AS "R3",
       TRUNC(1745.9260, -4) AS "R4"
FROM DUAL;

SELECT ENAME, SAL, TRUNC(SAL/500,0), MOD(SAL,500)
FROM EMP
WHERE DEPTNO = 30;

--CEIL(N) : N보다 큰 가장 작은 정수, 음수는 절대값이 작을수록 작은수
SELECT CEIL(23.223), CEIL(-45.923)
FROM DUAL;
--FLOOR(N) : N보다 작은 가장 큰 정수
SELECT FLOOR(23.223), FLOOR(-45.923)
FROM DUAL;
--POWER(M,N) : M의 N제곱
SELECT POWER(3,3), POWER(9,3)
FROM DUAL;
--ABS(N) : N의 절대값을 계산
SELECT ABS(3), ABS(-3)
FROM DUAL;
--SQRT(N) :  N의 제곱근, 루트
SELECT SQRT(9), SQRT(18)
FROM DUAL;
--SIGN(N) : N이 음수이면 -1, 양수이면 1, 0이면 0리턴
SELECT SIGN(-1), SIGN(1), SIGN(0)
FROM DUAL;

--날짜 함수
--SYSDATE : 오라클서버가 운영되는 OS의 날짜와 시간을 
--DATE타입으로 반환
SELECT SYSDATE
FROM DUAL;
--WHERE절에서 날짜 형식을 주의해야하는데, 한글WINDOWS에
--설치된 SQL-DEVELOPER는 기본이 한글이라서 YY/MM/DD로 리턴됨.
--영문 07-JUNE-21, 로케일에따라 형식이 다르게 리턴됨.
--WHERE절에서 TO_DATE()함수를 이용 날짜를 상수 처리권장
SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE < TO_DATE('1981-01-01','YYYY-MM-DD');
--DATE 형식의 데이터에 산술 연산하기
--날짜+숫자 : TO_DATE('2009/10/04','YYYY/MM/DD')+3 = 2009/10/07
--    TO_DATE('2009/10/04','YYYY/MM/DD')+ 48/24 = 2009/10/06
--날짜-숫자 : TO_DATE('2009/10/04','YYYY/MM/DD')-3 = 2009/10/01
--날짜-날짜 : TO_DATE('2009/10/04','YYYY/MM/DD') -
--          TO_DATE('2009/10/03','YYYY/MM/DD') = 1
SELECT ENAME, TRUNC((SYSDATE-HIREDATE)/7,0) AS "WEEK"
FROM EMP
WHERE DEPTNO = 30;

--MONTHS_BETWEEN('날짜1','날짜2')함수 : 두 날짜 사이의 달 수 계산
SELECT ENAME, TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate),0) AS RESULT, DEPTNO
FROM EMP
WHERE DEPTNO = 30
ORDER BY RESULT DESC;
--NEXT_DAY('날짜','요일')함수 
--날짜기준으로 다음에오는 요일의 날짜 반환
SELECT NEXT_DAY(TO_DATE('21/06/07','YY/MM/DD'),'금요일')
FROM DUAL;
--ADD_MONTHS('날짜','숫자')함수  
--주어진 '날짜'에 '숫자'만큼 달 수를 더한 날짜를 반환
SELECT ADD_MONTHS(TO_DATE('1994/01/11','YYYY/MM/DD'),6)
FROM DUAL;
--LAST_DAY('날짜')함수 : 날짜가 포함된 달의 맨 마지막 날짜 반환
SELECT LAST_DAY(TO_DATE('2000-02-15','YYYY-MM-DD'))
FROM DUAL;
SELECT LAST_DAY(TO_DATE('2001-02-29','YYYY-MM-DD'))
FROM DUAL; --날짜를 맞춰서 입력하지 않으면 오류발생.

--날짜 ROUND()반올림, TRUNC()버림
--실습을 위해 세션의 날짜 표시 형식을 바꿈
--접속해제 하면 원래대로 돌아온다.
ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD';

--ROUND()
SELECT SYSDATE, ROUND(SYSDATE,'YEAR')
FROM DUAL;

SELECT SYSDATE, ROUND(SYSDATE, 'MONTH')
FROM DUAL;

--TRUNC()
SELECT SYSDATE, TRUNC(SYSDATE, 'YEAR')
FROM DUAL;

SELECT SYSDATE, TRUNC(SYSDATE, 'MONTH')
FROM DUAL;
/*자동 데이터 유형 변환
VACHAR2 OR CHAR -> NUMBER : 숫자로 된 문자만 숫자로 자동 변환
VACHAR2 OR CHAR -> DATE : 세션의 DATE표시 형식과 일치하면 자동 변환
NUMBER -> VARCHAR2 : 숫자는 문자로 항상 자동 변환됨
DATE -> VARCHAR2 : 날짜는 세션에서 표시하는 형식 그대로 문자로 자동 변환
*/

SELECT '1' + '1' AS "RESULT1", 1||1 AS "RESULT2"
FROM DUAL;
--TO_CHAR(), TO_DATE(), TO_NUMBER()사용해서 명시적으로 변환해라...

/*
날짜포멧
YYYY : 4자리 숫자 연도 
YY : 2자리 연도,
RR : 2자리 연도, YEAR : 영어로 표시한 연도.
RR(1950~1999사이의 데이터를 처리할때 사용)

MM : 숫자로 된 월 EX) 12, 
MONTH : 달이름, 영어 : JUNE, 한국어 : 6월
MON : 3자리 약어 , 영어 : JUN, 한국어 : 6월

DD : 숫자로 된 달의 일
DAY : 요일(영어 : MONDAY, 한국어 : 월요일)
DY : 3자리 약어 (영어 : MON, 한국어 : 월)

HH24 : 숫자로 된 시간 (24시간 표기법)
HH, HH12 : 숫자로 된 시간 (12시간 표기법)
MI : 숫자로 된 분
SS : 숫자로 된 초
AM : 오전/오후 (영어 : AM/PM, 한국어 : 오전/오후)
*/

SELECT TO_CHAR(TO_DATE('94/01/11', 'RR/MM/DD')
            ,'YYYY/MM/DD') AS "RR",
        TO_CHAR(TO_DATE('94/01/11', 'YY/MM/DD')
            ,'YYYY/MM/DD') AS "YY"
FROM DUAL;
/* 1일차 문제 답.
1. EMP 테이블의 구조를 파악해서 출력
desc emp;
2. 사번, 사원명, 급여, 입사일을 출력
SELECT EMPNO, ENAME, SAL, HIREDATE
FROM EMP;
3. 사번, 사원명, 급여, 연봉<(급여*12) AS 연봉>을
SELECT EMPNO, ENAME, SAL, SAL*12+NVL(COMM,0) AS 연봉
FROM EMP;
4. 부서번호 20번 사원의 이름, 급여, 입사일을 출력
SELECT ENAME, SAL, HIREDATE, DEPTNO
FROM EMP
WHERE DEPTNO = 20;
5. 급여 2000에서 3000사이의 사원의 이름, 급여, 부서번호를 출력
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;
--WHERE SAL >=2000 AND SAL <= 3000;
6. 이름이 K로 시작하는 사원의 이름, 급여 , 입사일을 출력
SELECT ENAME, SAL , HIREDATE
FROM EMP
WHERE ENAME LIKE 'K%';
7. 커미션이 없는 사람들의 연봉 , 사번, 이름 , 입사일을 출력
SELECT EMPNO, ENAME , COMM, SAL*12 + NVL(COMM,0) AS 연봉, HIREDATE
FROM EMP
WHERE COMM IS NULL;
8. 부서번호가 30번인 직원의 이름, 급여, 연봉을 
   출력 하되, 연봉순으로 내림차순 정렬
SELECT ENAME, SAL, SAL*12 + NVL(COMM,0) AS 연봉, DEPTNO
FROM EMP
WHERE DEPTNO=30
ORDER BY 연봉 DESC;
9. HELLO, WORLD 두 문자열을 붙여서 출력
SELECT CONCAT('HELLO','WORLD')
FROM DUAL;
10. 숫자 12345.0235를 소수점 3자리 표현하고 반올림 해서 출력
SELECT ROUND(12345.0235,3)
FROM DUAL;
*/
/*
SELECT 컬럼1, ~ , 컬럼n (* 모든컬럼)
FROM 테이블명
[WHERE 조건 (검색에 관한 여러 조건)]
[ORDER BY 정렬 컬럼, ALIAS, 숫자
    (ASC : 오름차순, DESC : 내림차순)]
    DEFAULT : ASC 생략가능..
*/
/*숫자 형식 표현
9(또는 0): 자리수 : 999,999 숫자를 최대 만 단위까지 표현가능
0  자리수 : 099,999  사용되지 않는 자리를 0으로 채워라.
$ 달러 : $99,999 숫자 앞에 $를 표시한다.
L 지역 화폐 : L99,999 해당 지역 통화단위를 앞에 표시
. 소수점 : 999.99 소수점을 의미
, 천 단위 구분자 : 99,999 숫자에 천 단위 구분자를 표시
*/

--데이터 변환 함수
--TO_DATE('날짜문자열','날짜형식모델'[,'NLS_PARAM'])함수
--날짜처럼 표시된 문자 값에 해당하는 형식모델을 명시하여,
--문자 값을 날짜데이터 유형으로 반환한다.
--'01-SEP-95'날짜와 '1994/01/11'날짜 사이의 달수를 구하시오.
--MONTHS_BETWEEN()함수 사용
--날짜-시간 상수를 명시하는 경우 TO_DATE()처리를 해야
--세션의 표시 형식에 관계없이 정상적인 결과를 얻을수 있다.
SELECT TRUNC(MONTHS_BETWEEN(
        TO_DATE('1995/09/01', 'YYYY/MM/DD'),
        TO_DATE('1994/01/11', 'YYYY/MM/DD')),0) AS RESULT
FROM DUAL;

--TO_CHAR('날짜 또는 숫자 형식','날짜또는 숫자 형식모델'[,'NLS_PARAM'])함수
--SYSDATE 함수 처리 결과를 세션의 표시형식이아닌 사용자가 원하는 형식으로 표시
SELECT SYSDATE, 
TO_CHAR(SYSDATE, 'YYYY/MON/DD HH:MI:SS AM DAY') AS 날짜
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY"년"MM"월"DD"일"
    HH"시"MI"분"SS"초" AM DAY') AS 날짜
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-mON-DD HH:MI:SS 
     AM DaY', 'NLS_DATE_LANGUAGE=AMERICAN') AS DAY
FROM DUAL;
--첫번째 글자가 소문자 : 전체가 소문자로 출력됨.
--첫번째 글자가 대문자, 두번째 글자도 대문자 : 전부 대문자출력
--첫번째 글자가 대문자, 두번째 글자는 소문자 : 
--      첫글자만 대문자, 나머지 소문자.
--숫자로 표시되는 년,월,일,시간,분,초 에서 한자리만 사용하는 경우
--남은 자리는 0[ZERO]로 채운다.(예. 2021/06/08 ...)
--fm을 명시하면 0으로 채우지 않는다.
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS')
FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'fmYYYY-MM-DD fmHH:MI:fmSS')
FROM DUAL;
--SP옵션(숫자를 영문으로 표시), TH옵션(숫자를 영어의 th형태로 표시)
SELECT TO_CHAR(SYSDATE, 'yYyySP-Mmspth-DDspth')
FROM DUAL;

--EMP에서 SAL컬럼값에 $또는 원화로 숫자 천단위에 ,표시
SELECT ENAME, SAL , TO_CHAR(SAL , '$9,999.99'),
        TO_CHAR(SAL*1200, 'L9,999,999')
FROM EMP;
--MI(음수일때 -를 뒤에 표시), PR(음수를 <>감싼다)
--MI, PR 동시 사용 불가.
SELECT TO_CHAR(0-SAL , '99,999.99MI') AS MINUS1,
       TO_CHAR(0-SAL , '99,999.99PR') AS MINUS2
FROM EMP
WHERE EMPNO=7839;
--9 , 0 형식 모델 사용시 표시 결과의 차이
--0을 넣으면 비어있는 자리수는 0으로 채워라.
SELECT TO_CHAR(SAL,'$999,999.99') AS RESULT1,
       TO_CHAR(SAL,'$099,999.99') AS RESULT2
FROM EMP
WHERE EMPNO=7839;

--9로 지정한 자리수 작으면 ########로 표시됨..
SELECT SAL, TO_CHAR(SAL, '$999.99')
FROM EMP
WHERE EMPNO=7839;

--현재 날짜에서 년,월,일,요일을 추출하여 표시.
--SYSDATE함수가 반환하는 DB의 날짜 및 시간을 TO_CHAR()
--문자 값으로 표시해보자.
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'YYYY') AS "YEAR" ,
    TO_CHAR(SYSDATE, 'MM') AS "MONTH" ,
    TO_CHAR(SYSDATE, 'DD') AS "DAY" ,
    TO_CHAR(SYSDATE, 'DAY') AS "WEEKDAY" ,
    TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "TIME"
FROM DUAL;

--TO_NUMBER('숫자문자열','숫자형식모델')함수
--명시된 숫자 문자열을 숫자 데이터형으로 변환
--'$12,000'문자열 값에 0.1을 곱한 값을 표시하시오.
SELECT TO_NUMBER('$12,000','$999,999') * 0.1 AS RESULT
FROM DUAL;

--단일 행 함수의 중첩 : 제한없이 여러 번 중첩하여 사용가능
--EMP에서 DEPTNO 30인 사원의 이름을 소문자로 변경해서
--이름 끝에 _사원을 붙여서 출력해보자.
SELECT ENAME , 
   LOWER(UPPER(INITCAP(CONCAT(SUBSTR(ENAME,1,3),'MAN')))) AS RESULT
FROM EMP
WHERE DEPTNO=30;

--일반 함수 (GENERAL FUNCTION)
--NVL(), DECODE(), CASE표현식, NVL2(), NULLIF(),
--COALESCE()등등...
--NVL(컬럼명, 대체값)함수 컬럼의 NULL값을 대체
SELECT ENAME, SAL, COMM, SAL*12 AS 연봉1 
        , SAL*12+NVL(COMM,0) AS 연봉2
FROM EMP;
--DECODE(컬럼, 값1, 표현식1,...,값N,표현식N)함수
--오라클에만 있음...
SELECT ENAME, JOB, SAL,
    DECODE(JOB,
        'CLERK', 1.20*SAL,
        'SALESMAN', 1.10*SAL,
        'MANAGER', 0.95*SAL,
        SAL) AS 연봉인상--마지막에 연산된 컬럼을 꼭 명시해야 된다.
FROM EMP
WHERE JOB IN('CLERK','SALESMAN','MANAGER')
ORDER BY JOB;--A~z A가 가장 작다. z가장 크다.

--CASE표현식 대부분의 DB에서 지원한다.
--DECODE함수와 동일한 기능 제공
--확장 CASE표현식은 오라클의 DECODE가 처리할 수 없다.
--BASIC CASE EXPRESSION
SELECT ENAME, JOB, SAL,
    (CASE JOB WHEN 'CLERK' THEN 1.20*SAL
        WHEN 'SALESMAN' THEN 1.10*SAL
        WHEN 'MANAGER' THEN 0.95*SAL
        ELSE SAL END) AS 연봉인상
FROM EMP
WHERE JOB IN('CLERK','SALESMAN','MANAGER')
ORDER BY JOB;
--EXTENDED CASE EXPRESSION
SELECT ENAME, SAL,
    (CASE WHEN SAL <1000 THEN 'Low'
          WHEN SAL <2500 THEN 'Mediun'
          WHEN SAL <4500 THEN 'Good'
          ELSE 'Execllent' END) AS 급여등급
FROM EMP
ORDER BY SAL DESC;

--NVL2(컬럼 이름, 대체값1, 대체값2)함수 (9i부터 지원)
--컬럼의 데이터가 존재 대체값1, 컬럼이 NULL이면 대체값2
--대체값1, 대체값2가 같은 데이터 유형이어야 한다.
SELECT ENAME, COMM, NVL2(COMM, 'OK', 'NO') AS 커미션유무
FROM EMP;

--NULLIF(컬럼1, 컬럼2)함수 (9i부터 지원)
--컬럼1, 컬럼2의 값이 다르면, 무조건 컬럼1을 표시하고,
--두 값이 같으면 NULL을 반환한다.2컬럼의 데이터유형은 동일
SELECT ENAME, LENGTH(ENAME) AS EXP1,
        JOB, LENGTH(JOB) AS EXP2,
        NULLIF(LENGTH(ENAME),LENGTH(JOB)) AS RESULT
FROM EMP;
--COALESCE(컬럼exp1, 컬럼exp2,....,컬럼expn)함수 (9i부터)
--함수 내에 명시된 컬럼 값을 확인해서 최초로 NULL이 아닌 
--컬럼 expr의 갓을 표시
SELECT
COALESCE('A','B','C') AS A,
COALESCE(NULL,'B','C') AS B,
COALESCE(NULL,NULL,'C') AS C,
COALESCE(NULL,NULL,NULL) AS N
FROM DUAL;

--다중행 함수(MULTIPLE-ROW FUNCTION, GROUP FUNCTION)
--그룹 함수...
--SUM(), AVG() , MAX(), MIN() , COUNT()
--VARIANCE(): 분산, STDDEV(): 표준편차
--COUNT() : 행의 수를 계산
SELECT COUNT(COMM) AS R1, COUNT(NVL(COMM, 0)) AS R2
FROM EMP;
--AVG() : 평균값을 구한다. ROUND() 반올림
SELECT AVG(SAL) AS 평균급여, ROUND(AVG(SAL)) AS 절삭처리
FROM EMP;
--SUM() : 컬럼의 합계를 구한다.
SELECT SUM(SAL) AS 급여총액
FROM EMP;
--MAX() : 최대값, MIN() : 최소값
SELECT MIN(SAL), MAX(SAL), 
MIN(HIREDATE) AS 최초입사자, MAX(HIREDATE) AS 마지막입사자
FROM EMP;
SELECT MIN(ENAME), MAX(ENAME)
FROM EMP;

--그룹함수와 같이 사용하는 SELECT문의 키워드 :
--GROUP BY절과 HAVING절
--10번, 20번 부서에 근무하는 직원의 부서별 평균 급여를 구해보자
SELECT 10 AS DEPTNO, AVG(SAL) AS 평균급여
FROM EMP
WHERE DEPTNO=10
UNION ALL --두 개의 SELECT문을 처리한 결과를 합쳐서 표현
SELECT 20, AVG(SAL)
FROM EMP
WHERE DEPTNO=20
UNION ALL
SELECT 30 , AVG(SAL)
FROM EMP
WHERE DEPTNO = 30;

--GROUP BY를 사용해서 구해보자.
SELECT DEPTNO, ROUND(AVG(SAL)) AS 평균연봉, COUNT(*) AS PERSON
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

--둘 이상의 컬럼의 GROUP BY절
--EMP의 DEPTNO 30인 행들의 부서번호, JOB, SAL
SELECT DEPTNO, JOB, SAL
FROM EMP
WHERE DEPTNO = 30
ORDER BY 1,2;

SELECT DEPTNO, JOB, AVG(SAL) AS AVGSAL,
        COUNT(*) AS PERSON
FROM EMP
WHERE DEPTNO = 30
GROUP BY DEPTNO, JOB;

/*GROUP BY절의 주의점
SELECT COL1, COL2, .... COLn, AVG(COLx)
FROM TABLENAME
GROUP BY COL1, COL2, .... COLn
* SELECT절에 명시된 모든 COL은 GROUP BY절에서도 명시되야한다.
*/

SELECT DEPTNO, JOB, AVG(SAL), COUNT(*)
FROM EMP
WHERE DEPTNO IN (10,20,30)
GROUP BY DEPTNO; --에러

SELECT DEPTNO, JOB, AVG(SAL), COUNT(*)
FROM EMP
WHERE DEPTNO IN (10,20,30)
GROUP BY DEPTNO, JOB;

SELECT DEPTNO , COUNT(ENAME)
FROM EMP;--GROUP BY절 생략불가...

SELECT DEPTNO , COUNT(ENAME)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

--GROUP BY 조건 검색 , 
--GROUP BY가 포함된 문장에 집합함수가 포함된 
--조건절이 HAVING절이다.
--HAVING이나 WHERE 기능은 거의 같다.


SELECT DEPTNO, SUM(SAL)
FROM EMP
--WHERE SUM(SAL) > 4000
GROUP BY DEPTNO
HAVING SUM(SAL) > 8000
ORDER BY DEPTNO;
--SA가 포함된 직책에 대해서 부서별 임금의 합계, 평균임금,
--근무 인원수를 구해보자.
SELECT DEPTNO, SUM(SAL), ROUND(AVG(SAL)), COUNT(*)
FROM EMP
WHERE JOB LIKE 'SA%'
GROUP BY DEPTNO;

--부서별 임금의 합계가 7000보다 큰 부서에 대해서만
--임금합계, 평균임금, 부서별 근무 인원수를 구하시오..
SELECT DEPTNO ,SUM(SAL), ROUND(AVG(SAL)), COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) >7000
ORDER BY DEPTNO;

--그룹 함수의 중첩은 2번까지만 가능..
--EMP에 부서별 임금합계 중, 가장큰 부서를 구하시오.
SELECT MAX(SUM(SAL)) AS 총급여가장높은부서
FROM EMP
GROUP BY DEPTNO;
/*
SELECT 컬럼,....
FROM 테이블
[WHERE 조건]
[GROUP BY 컬럼, ALIAS]
[HAVING 그룹함수의 조건]
[ORDER BY 정렬 ASC, DESC];
*/
/*ORACLE DATADASE : 관계형 데이터 베이스이다.
RDBMS : RELATION DATABASE MANGEMENT SYSTEM
        3세대 데이터베이스, 다수의 테이블이 연결되어
        있는 데이터베이스이기 때문이다.
각 테이블에는 UNIQUE한 KEY가 있다.
3개의 UNIQUE한 KEY
1. PRIMARY KEY : 테이블을 대표하는 키 , 기본키
    EX)EMP테이블 : EMPNO, DEPT테이블: DEPTNO
2. FOREIGN KEY : 다른테이블에 PRIMARY KEY, 외래키
    EX)EMP테이블 : DEPTNO
3. SUPER KEY : UNIQUE한 성질 가진 PRIMARY KEY 후보        
*/
SELECT * FROM TAB;
DESC EMP;
SELECT * FROM EMP;
DESC DEPT;
SELECT * FROM DEPT;
/*
JOIN : 조건을 기준으로 두 테이블의 가 행들을 합친후,
       원하는 데이터 레코드를 가져오는 방법이다.
ANSI 표준 JOIN 형식 : 4가지 조인방법이 있다.
1.INNER JOIN -> EQUI-JOIN, NON-EQUI-JOIN
2.OUTER JOIN
3.CROSS JOIN
*/
--EQUI INNER JOIN : ON절을 이용하여 조인 조건을 기술할때
--조건에 "=" 연산자를 사용한다.
--EMP, DEPT 테이블이용해서 조인을 해보자
--사원의 사번, 이름, 부서명을 조회해서 출력
--조건이 명시되지 않아서 가능한 모든 표현이 리턴됨.
SELECT EMPNO, ENAME, DNAME
FROM EMP, DEPT;

SELECT EMPNO, ENAME, DNAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT EMPNO, ENAME, DNAME, DEPTNO
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT E.EMPNO, E.ENAME, D.DNAME, E.DEPTNO
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT E.EMPNO, E.ENAME, D.DNAME, E.DEPTNO
FROM EMP E INNER JOIN DEPT D
ON (E.DEPTNO = D.DEPTNO); --FM 표현식

/*
EQUI조인 표현식
SELECT T1.COL1, T1,COL2, T2,COL3, T2,COL4....
FROM TABLE T1, TABLE T2
WEHRE T1.PRIMARYKEY = T2.FOREIGNKEY;
*/
--부서번호 30인 사원의 사번, 이름, 급여 , 
--부서번호, 부서명을 출력
SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.DEPTNO = 30;

--NON EQUI JOIN : 조인절이 일치하지 않는 조건을 명시한다.
--이름, 급여, 급여등급을 출력
DESC SALGRADE;

SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S;

SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
--WHERE E.SAL >=S.LOSAL AND E.SAL <=S.HISAL;
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

SELECT * FROM SALGRADE;
SELECT SAL FROM EMP;

--3중 조인 : 테이블 3개를 조인
--사원번호, 이름, 부서번호, 부서명, 급여 ,급여등급을 출력
--E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, E.SAL, S.GRADE
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, 
        E.SAL, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO 
        AND E.SAL BETWEEN S.LOSAL AND S.HISAL;
/*
1.EMP 테이블에서 커미션이 있으면 OK, 없으면 NO를 출력 (NVL2 사용)
SELECT EMPNO, ENAME, COMM, NVL2(COMM, 'OK', 'NO')
FROM EMP;
2.EMP 테이블에서 부서번호, 평균 급여를 출력
SELECT DEPTNO, ROUND(AVG(SAL)) AS 평균급여, COUNT(*) AS 부서원수
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
3.이름이 A로 시작하는 사원의 이름과 부서번호 , 부서이름을 출력
SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND E.ENAME LIKE 'A%';
4.평균 1500이상의 급여를 받는 직급의 총급여를 출력하되, 직급으로 정렬
SELECT JOB, SUM(SAL) AS 총급여, COUNT(*) AS 직원수
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) > 1500--GROUP BY 조건은 HAVING절에서 처리
ORDER BY JOB;
5.EMP , DEPT 테이블 이용하여 사원의 이름, 부서번호, 부서이름을 출력
SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
6.EMP, SALGRADE 테이블를 이용해서 사원의 이름, 급여, 급여등급을 출력  
SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
7.EMP , DEPT 테이블을 이용하여, 30번 부서에 근무하는 
  사원명과 근무하는 부서이름을 출력
SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.DEPTNO=30;
8. EMP, DEPT, SALGRADE 테이블을 이용하여, 30번 부서에 근무하는 
  사원명과 부서이름, 급여 등급을 출력
SELECT E.ENAME, D.DEPTNO, D.DNAME, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO 
    AND E.SAL BETWEEN S.LOSAL 
    AND S.HISAL AND E.DEPTNO=30
ORDER BY 4;--SELECT절의 4번째 컬럼으로 정렬  
9. EMP 테이블에서 JOB별 평균 SALARY가 가장 작은 JOB의 평균SAL을 출력
SELECT MIN(AVG(SAL))
FROM EMP
GROUP BY JOB;
*/
--SELF JOIN : INNER JOIN - EQUI JOIN
--SMITH의 매니저는 FORD입니다. 처럼 출력해보자.
SELECT E.ENAME ||'의 매니저는 '||MG.ENAME||'입니다.' AS RESULT
FROM EMP E, EMP MG
WHERE E.MGR = MG.EMPNO; --MGR코드는 사번, EMPNO사번
--INNER JOIN : 조건에 맞는 항목만 출력
--OUTER JOIN : 조건에 맞지 않은 항목도 출력된다.
--사원명, 사번, 부서번호, 부서명을 출력해보자.
--OUTER LEFT JOIN : 오른쪽 테이블의 컬럼이 왼쪽과
--조건이 맞지 않아도 출력해라...
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY DEPTNO;

--OUTER RIGHT JOIN : 왼쪽 테이블의 컬럼이 오른쪽 테이블에
--조건이 맞지 않아도 출력해라.
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+)
ORDER BY DEPTNO;

--1. 사원들의 이름, 부서번호, 부서이름을 출력
SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--2. 부서번호가 30인 사원들의 이름, 직급, 부서번호, 
--부서위치를 출력
SELECT E.ENAME, E.JOB, E.DEPTNO, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.DEPTNO = 30;
--3. 커미션을 받는 사원 이름, 커미션, 부서이름, 부서위치
SELECT E.ENAME, E.COMM, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.COMM IS NOT NULL;
--4. DALLAS에서 근무하는 사원들의 이름, 직급, 부서번호,
--부서명을 출력
SELECT E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND D.LOC ='DALLAS';
--5. 이름에 A가 들어가는 사원들의 이름과 부서이름을 출력하시오.
SELECT E.ENAME, D.DNAME
FROM DEPT D, EMP E
WHERE E.DEPTNO = D.DEPTNO AND E.ENAME LIKE 'A%';
--6. 사원이름과 직급, 급여, 등급을 출력하시오.
SELECT E.ENAME, E.JOB, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
--7. 사원이름, 부서번호, 해당사원과 같은 부서에서 
    근무하는 사원을 출력하시오. (SELF JOIN) 
SELECT A.ENAME, A.DEPTNO, B.ENAME, B.DEPTNO
FROM EMP A, EMP B
WHERE A.DEPTNO = B.DEPTNO AND A.ENAME != B.ENAME
ORDER BY A.ENAME;
/*
서브쿼리
1. 쿼리문 안쪽의 쿼리문이다.
2. 반드시 ( )로 감싼다.
3. 서브쿼리 뭔저 실행된다.
4. 서브쿼리만 가지고도 실행된다.
5. 서브쿼리의 결과가 바깥쿼리의 인자(매개변수)로 사용된다.
6. 서브쿼리의 대부분은 조인문으로 만들 수 있다.
7. 서브쿼와 조인문은 병행되어서 사용할 수 있다.
*/
--JONES의 부서명을 구해서 부서명과 사원의 이름을 출력하시요.
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno and d.deptno = (select deptno from emp where ename='JONES');

--10번 부서에서 근무하는 사원의 이름과 부서명을 구하시오.
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno and d.deptno = 10;

SELECT E.ENAME, D.DNAME
FROM EMP E,(SELECT DEPTNO, DNAME FROM DEPT WHERE DEPTNO=10) D
WHERE E.DEPTNO  = D.DEPTNO;

--평균보다 더 많은 급여를 받는 사원들을 검색
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);

--BLAKE가 속한 부서의 사원 이름과 고용일자 출력
SELECT ENAME, HIREDATE, DEPTNO
FROM EMP
WHERE DEPTNO = 
    (SELECT DEPTNO FROM EMP WHERE ENAME = 'BLAKE');

--급여가 3000이상인 사원이 소속된 부서의 
--사원명, 급여 ,부서번호출력 , 다중행 처리 IN 연산자 사용
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO 
    IN (SELECT DEPTNO FROM EMP WHERE SAL >= 3000) 
ORDER BY DEPTNO;

--30번 부서원들 중 제일 많은 급여를 받는 사람보다 ,
--더 많이 받는 사람들의 이름과 급여를 출력 (전체만족 ALL)
--컬럼 > ALL : 리턴되는 값중에 가장 큰값..
--컬럼 < ALL : 가장 작은 값보다 작음...
SELECT ENAME, SAL 
FROM EMP
WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO=30);

SELECT ENAME, SAL 
FROM EMP
WHERE SAL < ALL(SELECT SAL FROM EMP WHERE DEPTNO=30);

SELECT ENAME, SAL 
FROM EMP
WHERE SAL >(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30);

--20번 부서 중 가장 낮은 급여를 받는 사람보다 , 더 많은
--급여를 받는사람의 이름과 급여를 출력 (부분만족 ANY)
--컬럼 > ANY : 가장 작은 값보다 큰값
--컬럼 < ANY : 가장 큰 값보다 작은값.

SELECT ENAME, SAL
FROM EMP
WHERE SAL > ANY(SELECT SAL FROM EMP WHERE DEPTNO=20);

SELECT ENAME, SAL
FROM EMP
WHERE SAL < ANY(SELECT SAL FROM EMP WHERE DEPTNO=20);

SELECT ENAME, SAL
FROM EMP
WHERE SAL >(SELECT MIN(SAL)FROM EMP WHERE DEPTNO=20);

/*SET 연산자 : 두개의 SELECT문들의 결과를 처리하는 방법
1.UNION : SELECT1의 결과를 구하고, SELECT2를 처리해서
          두 결과를 하나로 합친다. 합친결과는 천번째 
          필드를 기준으로 정렬하고, 중복된 레코드는 제거
2.UNION ALL : UNION과 달리 중복된 레코드를 제거안함.
3.INTERSECT : SELECT1문을 처리할때 , 첫번째 필드를 기준으로
            정렬시키면서 결과-레코드 집합을 구하고,
            SELECT2문을 처리하고, 첫번째 필드를 기준으로 정렬
            시키면서 결과-레코드 집할을 구한후,
            두 SELECT문의 정렬된 결과-레코드 집합으로 부터
            공통된 결과-레코드만 추출하여 표시.
4.MINUS : SELECT1문의 내용에서 SELECT2내용 중 공통된 
        부분을 제거한 나머지 출력.
*UNION ALL을 제외하고 모두 SORD가 발생하므로, 메모리소모가 많다.
*두 SELECT문은 컬럼의 개수, 위치 유형 동일.
*ALIAS는 첫번째 SELECT에 기술하면 된다.
*3개 이상의 SELECT문도 가능 , 위에서 아래로 처리됨.
*ORDER BY는 맨 마지막에 기술..
SET연산자의 위치는 두 SELECT문 사이에 위치한다.         
*/
DROP TABLE EMP01 PURGE;
DROP TABLE EMP02 PURGE;
CREATE TABLE EMP01 AS 
    SELECT * FROM EMP WHERE DEPTNO IN (10,30);
CREATE TABLE EMP02 AS 
    SELECT * FROM EMP WHERE DEPTNO=30;
COMMIT;
SELECT * FROM EMP02;

--UNION 및 UNION ALL 실습
SELECT EMPNO, JOB, DEPTNO
FROM EMP01
UNION -- 중복값을 제거해서 출력
SELECT EMPNO, JOB, DEPTNO
FROM EMP02;

SELECT EMPNO, JOB, DEPTNO
FROM EMP01
UNION ALL --중복값 제거 안함..
SELECT EMPNO, JOB, DEPTNO
FROM EMP02;

SELECT EMPNO, JOB , DEPTNO
FROM EMP01
INTERSECT -- 교집합, 공통된 값만 출력
SELECT EMPNO, JOB , DEPTNO
FROM EMP02;

SELECT EMPNO, JOB , DEPTNO
FROM EMP01
MINUS - 차집합, 공통된 값제거 후 출력
SELECT EMPNO, JOB , DEPTNO
FROM EMP02;

1. FORD의 급여와 동일하거나 더 많이 받는 사원의 이름과
   급여를 출력 (FORD 제외)
SELECT ENAME , SAL
FROM EMP
WHERE SAL >= (SELECT SAL FROM EMP WHERE ENAME='FORD')
    AND ENAME != 'FORD';
2. 직급이 CLERK인 사람의 부서명, 부서번호, 지역을 출력
SELECT DNAME, DEPTNO, LOC
FROM DEPT
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE JOB='CLERK');
3. 이름에 T를 포함하고 있는 사원들과 같은 부서에 
   근무하는 사원의 사원번호와 이름을 출력
SELECT EMPNO, ENAME, DEPTNO
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%T%');
4. 부서 위치가 DALLAS인 사원의 이름, 부서번호 출력
SELECT ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');
5. SALES부서의 사원의 이름과 급여를 출력
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');
6. KING에게 보고하는 사원의 이름과 급여를 출력
SELECT ENAME, SAL, JOB
FROM EMP
WHERE MGR = (SELECT EMPNO FROM EMP WHERE ENAME='CLARK');
7. 급여가 평균 급여보다 많고, 이름에 S가 들어가는 사원과 
  동일한 부서에서 근무하는 사원의 사번, 이름, 급여 출력
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE SAL > 
(SELECT AVG(SAL) FROM EMP) AND ENAME LIKE '%S%');

/*
DML (DATA MANIPULATION LANGUAGE) : 데이터 조작어
INSERT : 새로운 행 또는 행들을 테이블에 삽입
UPDATE : 테이블에 입력된 행 또는 행들의 데이터를 수정
DELETE : 테이블에 저장된 행 또는 행들을 삭제
*/
--INSERT INTO 테이블명 (컬럼1, 컬럼2... , 컬럼N) 
--VALUES (값1, 값2, ....., 값N)
--INSERT INTO 테이블명 VALUES (값1,...,마지막 값)
DROP TABLE DEPT01 PURGE;
CREATE TABLE DEPT01 AS SELECT * FROM DEPT;
COMMIT;
SELECT * FROM DEPT01;

INSERT INTO DEPT01 (DEPTNO, DNAME, LOC)
    VALUES (50,'IT','LA');

INSERT INTO DEPT01 VALUES (60,'PROGRAM','MIAMI');

INSERT INTO DEPT01 (DEPTNO, LOC) 
    VALUES(70,'HAWAII');
SELECT * FROM DEPT01;

INSERT INTO DEPT01 VALUES (80,'',NULL);
INSERT INTO DEPT01 SELECT * FROM DEPT;

CREATE TABLE EMP_HIR AS 
    SELECT EMPNO, ENAME, HIREDATE 
    FROM EMP 
    WHERE 1 = 0;
CREATE TABLE EMP_MGR AS 
    SELECT EMPNO, ENAME, MGR
    FROM EMP 
    WHERE 1 = 0; -- 1 = 0 테이블 구조만 복사   
COMMIT;
SELECT * FROM EMP_HIR;
SELECT * FROM EMP_MGR;
--다중테이블에 다중로우 입력 ALL
INSERT ALL INTO EMP_HIR VALUES (EMPNO, ENAME, HIREDATE)
           INTO EMP_MGR VALUES (EMPNO, ENAME, MGR)
           SELECT EMPNO, ENAME, HIREDATE, MGR 
           FROM EMP
           WHERE DEPTNO > 10;
--1 테이블을 복제해서 테이블을 만들면 구조와 값은 복사 
--  되지만 제약조건(PRIMARY KEY, FOREIGN KEY)은 해제된다.
INSERT INTO DEPT01 VALUES (20,'EXPORT','MIAMI');
SELECT * FROM DEPT01;  
DESC DEPT01;
INSERT INTO DEPT VALUES (20,'EXPORT','MIAMI');
--DEPT테이블에서는 DEPTNO PRIMARY KEY : UNIQUE
--2 
INSERT INTO DEPT01 (DEPTNO, DNAME, LOC) 
    VALUES (20,'무역', '부산','인천');-- 들어갈 컬럼수가 맞지 않는다.
--3
INSERT INTO DEPT01(DNAME, LOC) VALUES ('무역','인천');
INSERT INTO DEPT(DNAME, LOC) VALUES ('무역','인천');
--DEPT테이블은 DEPTNO가 NOT NULL이라 꼭 값을 넣아야한다.

--4
INSERT INTO  DEPT01 (IDXNO, DNAME, LOC)
    VALUES (50,'무역','인천'); --컬럼명이 다르다.

--5
INSERT INTO DEPT01 (DEPTNO, DNAME, LOC)
    VALUES ('50','무역','인천'); --숫자는 '' 감싸도 상관없음.

--6
INSERT INTO DEPT01 (DEPTNO, DNAME, LOC)
    VALUES (60,수출,'부산'); --문자는 꼭 ''로 감싸야 한다.

--UPDATE TABLE명 SET 컬럼1 = 값, 컬럼2 = 값
--WHERE 조건;
UPDATE DEPT01 SET LOC='서울'
WHERE DEPTNO = 10;
SELECT * FROM DEPT01;
SELECT * FROM TAB;

--부서번호 40인 부서명과 위치를, 
--부서번호 20인 부서명과 위치로 수정해라..
UPDATE DEPT01 SET (DNAME, LOC) = 
    (SELECT DNAME, LOC FROM DEPT01 WHERE DEPTNO=20)
WHERE DEPTNO = 40;
    
SELECT * FROM DEPT01;    
 
--DELETE FROM 테이블명 WHERE 조건;
--부서번호 30인 데이터를 삭제 해라.
DELETE FROM DEPT01 WHERE DEPTNO=30;
--부서명이 ACCOUNTING인 부서의 데이터를 삭제
DELETE FROM DEPT01 WHERE DNAME='ACCOUNTING';
SELECT * FROM DEPT01;

/*TRANSACTION 개요
TRANSACTION CONTROL LANGUAGE
*COMMIT : DML완료 후 변경 상태의 데이터로 유지하면서 
            트랙잭션 종료, 물리디스크에 처리내용 기록
*ROLLBACK : DML완료 후 변경 전의 상태로 되돌리고 
            트랜잭션 종료
*직접 DB로 접속해서 DML 수행 후에는 트랙잭션을 명시적으로
    종료해야 한다.
*세션 사용자가 DML문을 실행하고 COMMIT, ROLLBACK을 하지 않고,
 오라클서버에서 비정상적으로 종료 될 경우, 트랜잭션은 자동으로
 ROLLBACK된다.
*오라클서버는 트랜잭션을 시작하는 별도의 명령어가 없고, 
접속한 세션에서 DML문이 하나가 처음 실행되면, 서버에서 
자동으로 해당 세션의 트랜잭션을 관리하게 된다.
*트랜잭션에 해당되는 것은 DML문, DDL문, DCL문이고,
 SELECT는 트랜잭션과 관계없다.
*/

CREATE TABLE EMPS8(
ID NUMBER(4),
SAL NUMBER(7,2),
NAME VARCHAR2(10)
);

INSERT INTO EMPS8(ID, SAL, NAME)
SELECT EMPNO, SAL, ENAME
FROM EMP
WHERE DEPTNO = 20;

SELECT * FROM EMPS8;
SAVEPOINT INSERT1;

INSERT INTO EMPS8(ID, SAL, NAME)
SELECT EMPNO, SAL, ENAME
FROM EMP
WHERE DEPTNO = 30;

ROLLBACK TO SAVEPOINT INSERT1;
COMMIT;    
ROLLBACK;

SELECT * FROM EMPS8; 
SAVEPOINT IN1;


INSERT INTO EMPS8(ID, SAL, NAME)
SELECT EMPNO, SAL, ENAME
FROM EMP
WHERE DEPTNO = 10;

ROLLBACK TO SAVEPOINT IN1;
ROLLBACK;
/*LOCK기능 : 여러 세션에서 하나의 ROW를 작업할 때 먼저
작업한 세션이 트랜잭션을 실행하지 않은 경우, 다른 세션에서
작업을 하지 못하게 LOCK을 걸어 놓는 개념..
트랜잭션이 완료되면 다른 세션에서 작업 가능해짐.
-SELECT문에서 [FOR UPDATE절] 사용
 *SELECT문에 의하여 액세스 되는 행에는 LOCK이 걸리지 않느다.
 상황에 따라 SELECT문에 의해 엑세스 되는 행에 LOCK을 걸어야
 할 경우도 있다. 해당 세션의 사용자가 COMMIT, ROLLBACK문을
 수행하지 전까지는 다른 세션의 사용자는 행을 변경할 수 없다.
*/
SELECT EMPNO, SAL, COMM, JOB
FROM EMP
WHERE DEPTNO = 30
FOR UPDATE
ORDER BY EMPNO;

1. 부서번호 30번인 사원들의 이름, 직급,부서번호, 부서위치 출력
SELECT E.ENAME 이름,E.JOB 직급,E.DEPTNO 부서번호,D.LOC 부서위치
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.DEPTNO=30;
2. 이름에 'A'가 들어가는 사원이 소속된 부서의 사번,이름,부서번호,부서명 출력
SELECT E.EMPNO 사번,E.ENAME 이름,E.DEPTNO 부서번호,D.DNAME 부서명
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND E.ENAME LIKE '%A%'
ORDER BY 3, 2; --정렬은 앞에것이 먼저되고, 뒤에것이 되는데
--앞에 컬럼이 깨지지 않는 상태에서 정렬이된다.
3. 평균보다 적은 급여를 받는 사원의 사번, 이름, 급여 출력
SELECT EMPNO 사번,ENAME 이름,SAL 급여
FROM EMP
WHERE SAL < (SELECT AVG(SAL) FROM EMP)
ORDER BY SAL;
4. 'CLARK'이 매니저인 사원의 사번, 이름, 급여, 부서번호 출력
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE MGR = (SELECT EMPNO FROM EMP WHERE ENAME='CLARK');
5. 급여가 3000이상인 사원이 소속된 부서의 사번, 이름 ,급여, 부서번호 출력
SELECT EMPNO 사번,ENAME 이름 ,SAL 급여,DEPTNO 부서번호
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE SAL >= 3000);
* CREATE TABLE E1 AS SELECT * FROM EMP; 생성
6. E1 테이블에 EMPNO =8000, ENAME='QUEEN', SAL=4000 을 삽입하시오.
INSERT INTO E1 (EMPNO, ENAME, SAL) VALUES (8000,'QUEEN',4000);
7. E1 테이블 서브쿼리를 이용해서 EMP테이블 값을 삽입하시오.
INSERT INTO E1 SELECT * FROM EMP;
8. E1 테이블에서 EMPNO = 7369인 사원의 급여를 1500으로, 이름은 JOHNSON으로 수정하시오.
UPDATE E1 SET SAL=1500, ENAME='JOHNSON'
WHERE EMPNO = 7369;
SELECT SAL, ENAME FROM E1 WHERE EMPNO  = 7369;
9. E1 테이블에서 ID = 7499인 사원을 삭제 하시오.
DELETE FROM E1
WHERE EMPNO=7499;
10. E1 테이블에서 담당업무(JOB)가 'SALESMAN'인 행을 삭제하시오.
DELETE FROM E1 
WHERE JOB='SALESMAN';
*부서명이 SALES 인 직원을 삭제 해보자.
DELETE FROM E1 
WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');
/*
DDL : (DATA DEFINITION LANGUAGE) 데이터 정의어
CREATE, DROP, ALTER, RENAME, TRUNCATE
*TABLE, USER, VIEW, SEQUENCE, INDEX....
-TABLE : 데이터가 저장된 저장공간을 가진 객체, 사용자가
원하는 데이터를 액세스 하기 위한 데이터의 으미와 속성이
정의된 객체..
-제약조건 : DB테이블에 입력(수정,삭제)되는 데이터가 
            지켜야하는 규칙
-DB에 접속한 계정이 자신의 스키마에 테이블을 생성하기 위한 조건
 *DB계정에 CREATE TABLE 시스템 권한이 부여 되어 있어야 한다.
 *저장 공간에 대한 권한(TABLESPACE상의 QUOTA)이 설정되어 있어야 한다.
*/
/*테이블 생성 문법
CREATE TABLE 테이블명(
 컬럼이름1 데이터유형(최대길이),
 컬럼이름2 데이터유형, 
        ->일부 데이터형은 길이를 지정하지 않아도 된다.
 ....
 컬럼이름n 데이터유형(최대길이)
);
-지켜야 되는 규칙
1. 테이블의 이름 및 컬럼의 이름은 30BYTES 초과 불가.
2. A-Z, a-z, 0-9, $, # 문자만 포함, 숫자로 시작불가.
3. 테이블이름 및 컬럼이름은 오라클의 예약어 사용불가.
4. 테이블이름은 같은 유저안에서 중복 불가.
*/
--같은 사용자의 테이블은 테이블명 중복 불가.
CREATE TABLE E1(
    ID NUMBER(4),
    SAL NUMBER(7,2),
    DEPTNO NUMBER(4)
);
--DEFAULT 옵션
--UPDATE, INSERT 문에서 DEFAULT 키워드를 이용 
--데이터 입력 및 수정 가능.
CREATE TABLE CUST(
    CID NUMBER(4),
    NAME VARCHAR2(25),
    CITY VARCHAR2(10) DEFAULT 'SEOUL',
    RDATE DATE DEFAULT SYSDATE
);
INSERT INTO CUST
VALUES (10,'KIM',NULL,TO_DATE('20100321','YYYYMMDD'));
INSERT INTO CUST (CID)
VALUES (20);
INSERT INTO CUST 
VALUES (30,DEFAULT,DEFAULT,DEFAULT);
COMMIT;
SELECT * FROM CUST;

--서브쿼리를 이용해서 테이블을 생성
--테이블을 복제해서 생성, 제약조건은 복제 안됨..
--테이블의 구조와 데이터값만 복제 된다.
CREATE TABLE E2 AS SELECT * FROM EMP;
--테이블의 구조만 카피해온다.
CREATE TABLE E5 AS SELECT * FROM EMP WHERE 1=0;

CREATE TABLE E3
AS SELECT EMPNO, ENAME, SAL*12 + NVL(COMM,0) AS ANNAL,
    HIREDATE
    FROM EMP
    WHERE DEPTNO= 30;
DESC E3;
SELECT * FROM E3;

CREATE TABLE E4(EMPNO, ENAME, ANNSAL, HIREDATE)
AS SELECT EMPNO, ENAME, SAL*12 + NVL(COMM,0) AS ANNAL,
    HIREDATE
    FROM EMP
    WHERE DEPTNO= 30;
SELECT * FROM E4;
/*무결성 제약 조건
NOT NULL : NULL허용하지 않는다. 반드시 데이터 입력
UNIQUE : 유일성, 중복을 허락하지 않는다.
PRIMARY KEY : 기본키 == 행을 구분하는 식별자 컬럼
              NOT NULL, UNIQUE 속성을 갖는다.
FOREIGN KEY : 외래키 == 기본키를 참조하는 키,
                       다른테이블의 기본키....
SUPER KEY : UNIQUE하게 식별되는 모든 조합을 의미.
CHECK : 입력값의 종류나 범위를 제한하는 것.

USER_CONSTRAINTS 
*/
CREATE TABLE DEPT01(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(15),
    LOC VARCHAR2(15),
    CONSTRAINT DEPT01_DEPTNO_PK PRIMARY KEY(DEPTNO)
);--PRIMARY KEY는 한개이상가능하다.

CREATE TABLE DEPT02(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(15),
    LOC VARCHAR2(15)
);

--ALTER ADD : 제약 추가, DROP : 제약 제거
ALTER TABLE DEPT02 
ADD CONSTRAINT DEPT02_DEPTNO_PK PRIMARY KEY(DEPTNO);
ALTER TABLE DEPT02 DROP PRIMARY KEY;

--UNIQUE : 중복 불가 옵션..
CREATE TABLE DEPT03(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(15) UNIQUE,
    LOC VARCHAR2(15)
);
INSERT INTO DEPT03 VALUES (11,'기획','구로');
INSERT INTO DEPT03 VALUES (12,'기획','구로');--UNIQUE 무결성제약 위반
INSERT INTO DEPT03 VALUES (13,'NULL','종로');
INSERT INTO DEPT03 VALUES (14,'NULL','종로');--무결성 위반
INSERT INTO DEPT03 VALUES (15,NULL,'강남');
INSERT INTO DEPT03 VALUES (16,NULL,'강남');--NULL값은 중복 허용
--NULL은 UNIQUE에 해당 안됨..
SELECT * FROM DEPT03;

--check 옵션
CREATE TABLE EM1(
EMPNO NUMBER(4) CONSTRAINT EM1_EMPNO_PK PRIMARY KEY,
ENAME VARCHAR2(15),
SAL NUMBER(7,2) CONSTRAINT EM1_SAL_UQ CHECK
    (SAL BETWEEN 500 AND 5000)
);

INSERT INTO EM1 VALUES (1111,'HGD',3000);
INSERT INTO EM1 VALUES (1112,'LSS',13000);--CHECK제약 걸림
INSERT INTO EM1 VALUES (1113,'AAA',NULL);--NULL은 허용

CREATE TABLE EM2(
    EMPNO NUMBER(4) CONSTRAINT EM2_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(15),
    LOC VARCHAR2(20) CONSTRAINT EM2_LOC_CH CHECK
    (LOC IN('서울','부산','대구','대전','광주','울산'))
);

INSERT INTO EM2 VALUES (1111,'HGD','서울');
INSERT INTO EM2 VALUES (1112,'LSS','진도');--CHECK조건 위배

/*뷰 view (권장)
뷰란 쿼리의 단축이나 보안을 위해서, 사용하는 물리적테이블을
기반으로 생성한 가상의 테이블이다.
--system으로 접속해서
GRANT CREATE VIEW TO SCOTT;
*/
--EMP_COPY테이블 생성 , EMP로부터
CREATE TABLE EMP_COPY AS SELECT * FROM EMP;

CREATE VIEW EV01 AS SELECT EMPNO, ENAME, DEPTNO
                    FROM EMP_COPY
                    WHERE DEPTNO=30;
SELECT * FROM EV01;--쿼리의 단축/쿼리의 상세한 내용을
                   --감추는 보안효과까지 갖는다.
DESC EV01
INSERT INTO EV01 VALUES (2222,'BBBB',99);--DEPTNO=30아니어서 입력되고 표시안됨.
INSERT INTO EV01 VALUES (3333,'AAAA',30);
UPDATE EV01 SET DEPTNO=50 WHERE ENAME='AAAA';
DELETE FROM EV01 WHERE ENAME='BLAKE';
SELECT * FROM EV01;
SELECT * FROM EMP_COPY;

CREATE VIEW EV02 --그룹함수 사용이 가능, 입력은 불가능
AS SELECT DEPTNO, SUM(SAL) SUM_SAL
FROM EMP_COPY GROUP BY DEPTNO;

CREATE VIEW EMP_JOIN AS --JOIN을 사용해서 VIEW 생성가능.
SELECT E.EMPNO, E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
SELECT * FROM EMP_JOIN;

--제거 DROP
DROP VIEW EMP_JOIN;

--VIEW 내용 보기

--VIEW 수정, 새로만들어짐..
CREATE OR REPLACE VIEW EV01 AS
SELECT E.EMPNO, E.ENAME ,D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--WITH CHECK OPTION, DEPTNO 변경불가, 나머지는 가능.
CREATE OR REPLACE VIEW EV02 AS
SELECT EMPNO, ENAME, DEPTNO FROM EMP_COPY
WHERE DEPTNO=20 WITH CHECK OPTION;
SELECT * FROM EV02;
UPDATE EV02 SET DEPTNO=50 WHERE ENAME='SMITH';

--WITH READ ONLY, DEPTNO 읽기만 가능, 변경불가, 나머지는 가능
CREATE OR REPLACE VIEW EV03 AS
SELECT EMPNO, ENAME, DEPTNO FROM EMP_COPY
WHERE DEPTNO=20 WITH READ ONLY;
UPDATE EV03 SET DEPTNO=50 WHERE ENAME='SMITH';

--VIEW 내용 확인
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

/*SEQUENCE(시퀀스): 자동증가 번호를 생성
CREATE SEQUENCE 시퀀스명;
OPTION
INCREMENT BY n -> n만큼 증가
START WITH n -> n부터 시작
NOMAXVALUE -> 범위 제한 없음
MAXVALUE n -> 최대 n까지
NOCYCLE -> 반복없음
CYCLE -> 최대값에 다다르면 다시 시작번호 돌아감.
CACHE 10 -> 한번에 10개의 번호를 생성, DEFAULT 20개.
NOCACHE -> 그 때 그 때 번호를 생성한다.
*/
CREATE SEQUENCE TESTSEQ; //1부터시작, 1씩증가.
SELECT TESTSEQ.NEXTVAL FROM DUAL;
DROP SEQUENCE TESTSEQ;

--시퀀스 연습
CREATE SEQUENCE seSEQ 
    INCREMENT BY 15 START WITH 100;
SELECT seSEQ.NEXTVAL FROM DUAL;

CREATE TABLE EM01 AS 
SELECT EMPNO, ENAME FROM EMP WHERE 1=0;
CREATE SEQUENCE EMSEQ;
INSERT INTO EM01 VALUES (EMSEQ.NEXTVAL,'HGD');
INSERT INTO EM01 VALUES (EMSEQ.NEXTVAL,'LSS');
INSERT INTO EM01 VALUES (EMSEQ.NEXTVAL,'KKC');
COMMIT;

/*INDEX
검색속도를 높이기위해서 사용한다.
B* tree방식을 사용
추가적인 저장공간 필요
수정, 입력이 빈번하면 효율성이 감소
따라서, REBUILD(갱신)이 필요한다.
------------------------------------------------
인덱스가 필요한 경우           인덱스가 필요없는 경우
------------------------------------------------
행수가 많을 때                 행수가 적을때
WHERE절 검색빈도가 높을때       WHERE절 검색빈도가 낮을때
검색결과 데이터 2~4% 정도       검색결과 데이터가 10~15%정도
자주사용되는 : JOIN절          빈번한 DML이 일어날때
NULL 포함하는 컬럼이 많을때     입력 수정이 빈번할 때

*/

CREATE TABLE E2 AS SELECT * FROM EMP;
INSERT INTO E2 SELECT * FROM E2;
SELECT * FROM E2;

SET TIMING ON


SELECT DISTINCT EMPNO, ENAME
FROM E2
WHERE ENAME='KING'; --0.087 인덱스가 적용됨.

SELECT DISTINCT EMPNO, ENAME
FROM E2
WHERE UPPER(ENAME)='KING'; --0.34 인덱스 적용 안됨.

CREATE INDEX IDX_01 ON E2(EMPNO);
DROP INDEX IDX_01;

DROP TABLE E2 PURGE;

--TRUNCATE, 가지를 잘라내는 명령, 빠른 삭제를 위함.
SELECT * FROM EM01;
DELETE FROM EM01;
ROLLBACK;
TRUNCATE TABLE EM01;

/*
DCL : DATA CONTROL LANGUAGE 
GRANT : 권한 부여, REVOKE : 권한 제거
1.계정만들기 : CREATE USER 유저명 IDENTIFIED BY 암호;
2.권한부여 : GRANT CREATE SESSION, CREATE TABLE, 
            CREATE VIEW TO 유저명;
3.롤(ROLE)권한의 부여 (롤:여러가지 권한을 하나의 권한 묶음)
            GRANT CONNECT, RESOURCE TO 유저명;
4.권한제거 : REVOKE 권한 FROM 대상;
5.계정제거 : DROP USER 유저명;
*/
/*권한의 종류
1. CREATE USER <-> DROP USER;
2. CREATE TABLE <-> DROP TABLE;
3. QUERY REWRITE - 질의를 재작성 할 수 있는 권한
4. BACKUP 테이블 - 임의의 테이블을 백업할 수 있는 권한
5. CREATE SESSION - 접속권한
6. CREATE VIEW - VIEW 생성 권한
7. CREATE SEQUENCE - SEQUENCE 생성권한
8. CREATE PROCEDURE 
*/
/*오라클의 자료형
CHAR(N) 1~2000바이트 사이의 문자의 크기가 고정된 문장: 주민번호/전화번호/우편번호
* VARCHAR2(N) 1~4000바이트 사이의 가변 문장 ,STRING
NVARCHAR2(N) 1~4000바이트 국가별 국가 집합에 따른 크기의 문자 또는 가변문장...거의 안씀
* NUMBER(P,S) P: 전체 자리수 , S: 소수점 자리수, DOUBLE
* NUMBER(N) : N자리수 정수 , INT
ROWID : 행주소 64진수 문자 : 시스템내부에서 레코드의 고유위치를 나타낸다.
ROWNUM : 쿼리의 결과에 순서를 붙여서 출력한다. 소수점 2자리.
BLOB : BINARY LARGE OBJECT 대용량 이진데이터 최대 4기가
CLOB : CHARACTOR LARGE OBJECT 대용량 문자 파일 최대 4기가
BFILE : BINARY DATA를 파일로 저장 최대 4기가
* DATE : 날짜 -> SYSDATE , STRING
TIMESTAMP(N) : 날짜 형식 지정
INTERVAL YEAR TO MONTH : 기간을 저장 EX) 36개월 3년
INTERVAL DAY TO SECOND : 기간을 저장 EX) 3600초
*/

/*
DQL : SELECT
SELECT 컬럼
FROM 테이블
WHERE 조건
GROUP BY 그룹함수가 나올때 사용
HAVING 그룹함수 조건
ORDER BY 정렬;

JOIN
INNER JOIN : 조인하는 테이블의 값에 해당하는 값만 출력
    EQUI JOIN : PRIMARY KEY = FOREIGN KEY
        WHERE E.DEPTNO = D.DEPTNO;
    NON EQUI JOIN : 검색조건이 맞을때 
        WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
OUTER JOIN : 조인하는 테이블의 값이 매칭되지 않는 값도 출력
    WHERE E.DEPTNO(+) = D.DEPTNO;

SUB QUERY
바깥쿼리의 매개변수 역할, ()기술한다, 서브쿼리먼저 실행
서브쿼리 단일 실행 가능, 조인하고 병행가능
SELECT EMPNO, ENAME, SAL , DEPTNO
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO=30);
단일행 함수, 그룹함수, TO_CHAR(), TO_NUMBER(), TO_DATE()

DML(INSERT, UPDATE, DELETE)
INSERT INTO 테이블명 (컬럼) VALUES (값);
UPDATE 테이블명 SET (컬럼=값) WHERE 조건;
DELETE FROM 테이블명 WHERE 조건;

TCL(COMMIT, ROLLBACK, SAVEPOINT)
*TRANSACTION : COMMIT 끝나고 새롭게 시작되는 DML구문
               COMMIT되면 마무리 된다.
COMMIT : 메모리의 처리가 저장되고 마무리
ROLLBACK : 메모리의 처리가 트랜잭션이 시작될 처음으로 돌림
SAVEPOINT : 트랜잭션이 시작되서 일정작업 완료 된후에 
            저장하는 포인트, ROLLBACK TO SAVEPOINT...
DDL(CREATE, ALTER, DROP, RENAME, TRUNCATE)
TABLE, USER, VIEW, SEQUENCE, INDEX...
생성, 삭제, 수정하는 역할..

DCL(GRANT, REVOKE)
권한 부여, 권한 삭제
*/

/*
PL/SQL 언어 : 오라클이 제공하는 오라클 데이터베이스 서버의
    내장 PL/SQL PACKAGE를 이용하여 프로그래밍 하는 언어
    SQL DEVELOPER를 이용하여 작성
    
* SQL : 데이터베이스 서버에 요구하여 '데이터를 처리'를 
        수행 명령어
*PL/SQL : C, JAVA, ASP, JSP, PHP와 비슷한 기능을 제공
        오라클에서 제공하는 자체 프로그램 언어...
특징 : 블록 구조로 다수의 SQL문을 한번에 ORACLE DB로 
      보내 처리하므로 수행속도를 향상.
      모듈화 가능, 큰 블럭 안에 소블럭 선언가능,
      VARIABLE, CONSTANT, CURSOR, EXCEPTION을 정의하고,
      SQL문장과 PROCEDURAL 문장에 사용한다.
PL/SQL 블럭 구조 :
    1) 선언부 : 변수, 상수, 등 선언 (생략가능)
    2) 실행부 : SQL, 반복문, 조건문 실행
               BEGIN시작, END;로 끝, 생략불가.
    3) 예외처리 : 예외처리 (생략가능)      
*/

SHOW ALL
SET SERVEROUTPUT ON

DECLARE
    f_name varchar2(30);--String f_name;
    l_name varchar2(15);
BEGIN
    SELECT ENAME INTO f_name
    FROM EMP
    WHERE EMPNO=7369;
    --System.out.print();
    DBMS_OUTPUT.PUT_LINE(
     --"The First Name of the Emp is " + f_name;
        'The First Name of the Emp is '||f_name);
    --f_name = f_name + "--a";
    f_name := f_name||'--a';
    --System.out.print(f_name);
    DBMS_OUTPUT.PUT_LINE(f_name);    
END;
/

--함수작성
CREATE FUNCTION COMPUTE_TAX(sal in number)
    return number
IS
BEGIN
    if sal <3000 then
        return sal*0.15;
    else return sal*0.33;
    end if;
END;
/
SELECT ENAME, SAL , COMPUTE_TAX(SAL) AS TAX, SAL - COMPUTE_TAX(SAL) AS 실수령액
FROM EMP
WHERE DEPTNO=10;



