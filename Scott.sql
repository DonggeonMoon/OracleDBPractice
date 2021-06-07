select * from tab;
--���� �ּ�;
/*
sql 5���� ��ɾ� ��Ʈ�� �����Ǿ� �ִ�.
1. DQL(Data Query Language): ������ ��ȸ�� 
   Select��
   ������ ���̽����� �����͸� �˻��ؼ� ����ڰ� ���ϴ� �����͸� Ȯ�� �� ����� �� �ִ�.
2. DML(Data Manpulation Language): ������ ���۾�
   INSERT, ALTER, DROP, TRUNCATE
   �����ͺ��̽��� ���̺� ���ο� ���� ����, ����, ����
3. DDL(Data Definition Language): ������ ���Ǿ�
   CREATE, VIEW, DROP, TRUNCATE
   �����ͺ��̽��� ���̺��� ����, ����, ���� ���� �ϴ� ��ɾ�
   ���̺� ��, ����, ������ ���Ǿ�
4. DCL(Data Control Language): ������ ��Ʈ��
   GRANT(�ο�), REVOKE(����)
   �����ͺ��̽��� �����ϴ� ����ڿ��� �����ͺ��̽��� �� �ȿ� ������ ���� �׼��� ������ �ο� �Ǵ� ����
5. TCL(Transaction Control Language): ������ ���� ó������
   COMMIT, SAVEPOINT, ROLLBACK
   ��� ������ ������ ����, �ǵ����� ��...
 
*/

/*
1. DQL: SELECT ���� ������: �����ͺ��̽��� ����� �����͸� ����� ���α׷����� ����ϱ�
   ���ؼ� SELECT���� �̿��Ͽ� ������ �� �ִ�. ��, ���α׷����� ó���� �����͸� ����� 
   ���α׷����� �������� ���� ����Ѵ�. DB���� �о���⸸ �ϴϱ� DB ������ ������ �ʴ´�.
   ����Ŭ ��ҹ��� ���� �� �Ѵ�. �÷� �̸��� �����Ѵ�.(��. SMITH, Smith)
   �⺻ ���� : SELECT �÷�1, �÷�2, ..., �÷�n(���ϵ� ���� *�� ���� ����) FROM ���̺��,
   �����ڸ� - FROM��
   WHERE ���� -WHERE��

   �ܼ� SELECT���� �ϳ��� ���̺� ���� ������ �� ���, FROM���� ���̺� �� ����Ѵ�.
   SQL���� ���� �� ;���� ������.
*/

-- EMP ���̺��� ��� ������ ��ȸ�Ͻÿ�.
SELECT *
FROM EMP;

-- EMP ���̺��� ���, �̸�, �޿�, �μ���ȣ�� ��ȸ

select EMPNO, ENAME, SAL, DEPTNO
FROM EMP;

-- ���̺��� ������ �� �� �ִ� ��ɾ�, ����Ŭ���� ����. 
DESCRIBE EMP;
DESC EMP; -- ����Ŭ ��ɾ� �� ���� ; ���� ������.

--������ ������ �ִ� ��� ���̺��� �˻�
SELECT * 
FROM TAB;

--DEPT���̺�: �μ� ������ ������ �ִ� ���̺�
--DEPT���̺��� ������ �ľ��ϰ� ��� ������ ǥ���غ���

DESC DEPT;
SELECT * 
FROM DEPT;

--�÷����� NUMBER, DATE ������ ��� ������ �����ϴ�.
--NUMBER(+, -, *, /) DATE(+, -) ���� ����
--EMP���̺��� �μ���ȣ 20���� �����
-- ���, �̸�, �޿�, �޿��� 100�� ����
--����غ���.

SELECT empno, ename, SAL, SAL + 100, DEPTNO
FROM EMP
WHERE DEPTNO=20;

-- �μ���ȣ 30�� ����� ���, �̸�, �޿�, �Ի���, �μ���ȣ

SELECT EMPNO, ENAME, SAL, HIREDATE, DEPTNO
FROM EMP
WHERE DEPTNO = 30;

-- ��� ����� ���, �̸�, �޿�, ����, �Ի���, �μ���ȣ
-- ����: (�޿�*12) + Ŀ�̼�
--�÷��� ����� �� �÷��� ���� NULL�̸� ��� ���� ������ NULL�� �ȴ�.

SELECT EMPNO, ENAME, SAL, (SAL * 12) + COMM, HIREDATE, DEPTNO
FROM EMP;

--��� �� NULL���� �ذ��ϴ� ���: ������ �Լ� NVL()
--NVL(COMM, 0) COMM�� NULL�̸� 0���� ġȯ�ض�.
SELECT EMPNO, ENAME, SAL, (SAL * 12) + NVL(COMM, 0), HIREDATE, DEPTNO
FROM EMP;

--�μ���ȣ 20���� ����� ���, �̸�, ����, �μ���ȣ�� ����غ���.
-- ����: (�޿�*12) + Ŀ�̼�

SELECT EMPNO, ENAME, (SAL * 12) + NVL(COMM, 0), DEPTNO
FROM EMP
WHERE DEPTNO=20;

--�÷��� ��Ī(ALIAS), ������ ����ؼ� HEADING�� �����ϱ�
--�μ���ȣ 30���� ����� ���, �̸�, ����, �μ���ȣ�� ���

SELECT EMPNO AS ���, ENAME AS �����, (SAL * 12) + NVL(COMM, 0) AS ����, DEPTNO AS �μ���ȣ
FROM EMP
WHERE DEPTNO=30;

--�μ���ȣ 10���� ����� ���, �̸�, ����, �Ի���, �μ���ȣ ���
--AS ���� ����������, �ظ��ϸ� ��� ���

SELECT EMPNO AS ���, ENAME AS �̸�, (SAL * 12) + NVL(COMM, 0) AS ����, HIREDATE AS �Ի���, DEPTNO AS �μ���ȣ
FROM EMP
WHERE DEPTNO = 10;

--�÷����� �ٿ��� ����ϱ� ������ ||(������)
SELECT EMPNO||ENAME AS �������
FROM EMP
WHERE DEPTNO=20;

--EMP���̺��� �μ���ȣ�� ���
--�ߺ��� ����
SELECT DISTINCT DEPTNO
FROM EMP;
/* SELECT������ ���� �˻�
WHERE�� ���������, BETWEEN, IN(), LIKE ������
�� ������ AND, OR, NOT
*/
--EMP���̺��� �̸��� KING�̰� �μ���ȣ 10�� ����� 
--���, �̸�, �޿�, �Ի���, ��å, �μ���ȣ�� ����غ���

SELECT EMPNO, ENAME, (SAL * 12) + NVL(COMM, 0), HIREDATE, JOB, DEPTNO
FROM EMP
WHERE ENAME='KING' AND DEPTNO=10;

--EMP���̺��� �Ի����� 80�� 12�� 1�Ϻ��� �ʰ� �Ի���
--����� ���, �̸�, �Ի��� ���
--��¥�� ��� �������� 0�ʺ��� 60*60*24*365

SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE HIREDATE>'81/12/01';

--�μ���ȣ�� 20���̰� �Ի����� 81/05/31���� ���� �����
-- ���, �̸�, �̻���, �μ���ȣ�� ���

SELECT EMPNO AS ���, ENAME AS �̸�, HIREDATE AS �Ի���, DEPTNO AS �μ���ȣ
FROM EMP
WHERE DEPTNO=20 AND HIREDATE>'81/05/31';

-- �ܼ� �� ������(=, <, >, <= >=, !=, ^=)
-- �޿��� 1500���� �۰ų� ���� ����� ������ ���
-- ���, �̸�, �޿�, �μ���ȣ ���

SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, DEPTNO AS �μ���ȣ
FROM EMP
WHERE SAL<=1500;

--�޿��� 2000���� ���� ����� ���, �̸�, �޿�, �μ���ȣ, ���

SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, DEPTNO AS �μ���ȣ
FROM EMP
WHERE SAL>2000;

--EMP���̺��� SAL�� 1000���� �۰ų� 3000���� ū ����� ���, �̸�, �޿�, �μ���ȣ ���
SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, DEPTNO AS �μ���ȣ
FROM EMP
WHERE SAL < 1000 OR SAL > 3000;

--EMP���̺��� SAL 1500�� 3000 ������ ����� ���, �̸�, �޿�, �μ���ȣ ���
SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, DEPTNO AS �μ���ȣ
FROM EMP
WHERE SAL >= 1500 AND SAL <= 3000;

SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, DEPTNO AS �μ���ȣ
FROM EMP
WHERE SAL BETWEEN 1500 AND 3000;

--�Ի����� 81/03/03 ~ 82/01/01
SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, DEPTNO AS �μ���ȣ, HIREDATE AS �Ի���
FROM EMP
WHERE HIREDATE BETWEEN '81/03/03' AND '82/01/01';

--EMP���̺��� �μ���ȣ 10�̰ų� 20���� ����� ���, �̸�, �޿�, �Ի���, �μ���ȣ ���
SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, DEPTNO AS �μ���ȣ
FROM EMP
WHERE DEPTNO = 10 OR DEPTNO =20;

--IN() ������
SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, DEPTNO AS �μ���ȣ
FROM EMP
WHERE DEPTNO IN(10, 20);
-- SAL�� 800, 1200, 3000�� ����� ������ ���
-- ���, �����, �޿�, �μ���ȣ
SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, DEPTNO AS �μ���ȣ
FROM EMP
WHERE SAL IN(800, 1200, 3000);
-- LIKE ������: ���� �������� ����, ���� ��õ� ���ϰ� �������� ��
-- ���ϵ� ���� %(��� ��), _(�ѱ��� ��ġ)
-- EMP���̺��� �̸��� 'A'�� �����ϴ� ����� �˻�
SELECT *
FROM EMP
WHERE ENAME LIKE 'A%';
-- EMP���̺��� �̸��� 'K'�� �����ϴ� ����� �˻�
SELECT *
FROM EMP
WHERE ENAME LIKE 'K%';
--�̸��� �� ��° ���ڰ� M�� ����� ���� ���
SELECT *
FROM EMP
WHERE ENAME LIKE '_M%';

--������ �ٷ��� ���ڰ� N�� ����� ������ ����غ���
SELECT *
FROM EMP
WHERE ENAME LIKE '%N_';

--�̸��� �� ��° ���ڰ� 'A'�� ����� ������ ���
SELECT *
FROM EMP
WHERE ENAME LIKE '__A%';

-- %, _ ���ϵ� ���ڸ� �˻��ؾ� �� �ʿ伺�� ���� ��

CREATE TABLE TEST01(J_CODE VARCHAR2(30));
INSERT INTO TEST01 VALUES('ADPRES');
INSERT INTO TEST01 VALUES('AD_PRES');
INSERT INTO TEST01 VALUES('AD_%PRES');
COMMIT;

SELECT *
FROM TEST01;

SELECT * 
FROM TEST01
WHERE J_CODE LIKE 'AD_%'; -- ���ϵ幮�� _

--AD_ESCAPE���� ������ ������ ���ڸ� ���ϵ幮�ڰ� �ƴ� �Ϲ� ���ڷ� �ν��ϰ� �Ѵ�.
SELECT * 
FROM TEST01
WHERE J_CODE LIKE 'AD\_%' ESCAPE '\';

--AD_% ���ϵ� ���ڰ� �ƴ� �Ϲݹ��ڷ� �˻� ����غ���
SELECT * 
FROM TEST01
WHERE J_CODE LIKE 'AD%\_\%%' ESCAPE '\';

DROP TABLE TEST01;

SELECT * FROM TAB;

PURGE RECYCLEBIN;
SELECT * FROM TAB;

-- NULL�� �÷��� ��ȸ, IS NULL, IS NOT NULL
SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NULL;

SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NOT NULL;

-- AND, OR, NOT
-- MANAGER IS NULL�̰� SAL 3000���� ū ��� ������ ���

SELECT *
FROM EMP
WHERE MGR IS NULL AND SAL > 3000;

--MGR IS NOT NULL�̰ų� SAL 4500���� ���� ����
SELECT *
FROM EMP
WHERE MGR IS NOT NULL OR SAL < 4500;

--NOT ����: ������ �����̾�� ����� ��.
--WHERE ������ �����ڿ� ���� NOT �������� ��� ��
--WHERE JOB NOT IN('CLERK', 'PRESIDENT');
--WHERE SAL NOT BETWEEN 800 AND 1500;
--WHEER ENAME NOT LIKE '%A%';
--WHERE COMM IS NOT NULL;
/*
ORDER BY��: ��� ���ڵ带 �����ؼ� ǥ���ϰ��� �� �� ���
SELECT �÷�1,..., �÷�n
FROM ���̺��
[WHERE ����]: ���� ����
[ORDER BY]: ���� ����
ORDER BY �÷���, ALIAS;
OPTION: ASC: �������� ���� ��->ū ��, DESC: �������� ū �� -> ���� ��
DEFAULT: ASC, �׷��� ���� ����.
*/
-- EMP ���̺��� �μ���ȣ�� �����غ���.
SELECT *
FROM EMP
ORDER BY DEPTNO ASC;

--EMP ���̺��� �μ���ȣ 30���� ����� �޿� ������ �����غ���.
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO=30
ORDER BY SAL;

SELECT EMPNO AS �����ȣ, ENAME AS �����, (SAL*12) + NVL(COMM, 0) AS ����, DEPTNO AS �μ���ȣ
FROM EMP
WHERE DEPTNO=30
ORDER BY ����; --ALIAS�� ORDER BY�ȴ�.

SELECT EMPNO, DEPTNO
FROM EMP
ORDER BY 2; -- 2��° �÷����� �����ض�

--NULL���� �ִ� �÷��� ����
SELECT EMPNO, ENAME, COMM, DEPTNO
FROM EMP
WHERE DEPTNO=30
ORDER BY 3 ASC NULLS FIRST; --NULL���� ���� ���

SELECT EMPNO, ENAME, COMM, DEPTNO
FROM EMP
WHERE DEPTNO=30
ORDER BY 3 ASC NULLS LAST; --NULL���� �������� ���

--1���� ����
--1.
SELECT ENAME, SAL, HIREDATE
FROM EMP
DESC EMP;

--2.
SELECT ENAME, SAL, HIREDATE
FROM EMP
WHERE DEPTNO = 20;

--3.
SELECT ENAME, (SAL * 12) +NVL(COMM, 0) AS ����, HIREDATE
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
SELECT ENAME AS �̸�, (SAL * 12) +NVL(COMM, 0) AS ����, EMPNO AS ���, SAL AS �޿�, HIREDATE AS �Ի���, 
FROM EMP
WHERE COMM IS NULL;

--7.
SELECT ENAME AS �̸�, SAL AS �޿�, (SAL * 12) + NVL(COMM, 0) AS ����
FROM EMP
WHERE DEPTNO = 30
ORDER BY ���� DESC;

--8.
SELECT *
FROM DEPT
ORDER BY DEPTNO;

select *
from TAB;

DESC EMP

--DEPT ���̺��� ������ �ľ�?
desc dept;
select *
from dept;

--SALGRADE ���̺��� ������ �ľ��ϰ� ��� ������ ���
DESC SALGRADE;
SELECT
    *
FROM SALGRADE;


--EMP ������ �˾ƾ� �÷����� �����ؼ� ����� �� �ִ�.
--EMP���̺� ���, �̸�, �޿�, �μ���ȣ�� �����ؼ� ���

DESC EMP;
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP;

--SELECT ������ �ܼ� ������ �����Ѵ�.
SELECT
EMPNO, ENAME, (SAL * 12), DEPTNO
FROM EMP;

-- ALIAS(��Ī, ����), ����� �ٲ� �� �ִ�.
SELECT
EMPNO, ENAME, (SAL * 12) AS ����, DEPTNO
FROM EMP;

SELECT
EMPNO, ENAME, (SAL * 12) + NVL(COMM, 0) AS ����, DEPTNO
FROM EMP;

--EMP���̺��� �μ���ȣ 20�� ��� ������ �˻�...
SELECT
*
FROM EMP
WHERE DEPTNO = 20;

--EMP

SELECT
EMPNO, ENAME, SAL, (SAL*12) + NVL(COMM, 0) AS ����, DEPTNO
FROM EMP
WHERE DEPTNO = 30;

--�÷��� �ٿ��� ����ϱ� ||(������);
--EMMP���̺��� �μ���ȣ 20���� ����� ���, �̟��� �ٿ��� ��Ī�� ��������� �Ͻÿ�.
SELECT EMPNO || ENAME AS �������
FROM EMP
WHERE DEPTNO = 20;

-- �ߺ����� DISTINCT ������
-- �ߺ� ��� ALL ������ DEFAULT ���� ����.
SELECT DISTINCT DEPTNO
FROM EMP;

/* SELECT������ ���� �˻�
    WHERE��: ���������, BETWEEN, IN(), LIKE ������, ��������(AND, OR, NOT)...
*/

--EMP���� �̸��� KING�̰� �μ���ȣ 10���� ����� ���, �̸�, �޿�, �Ի���, �μ���ȣ�� ����غ���
SELECT
EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, HIREDATE AS �Ի���, DEPTNO �μ���ȣ
FROM EMP
WHERE ENAME = 'KING' AND DEPTNO = 10;

--��¥������ �����ϴ�. EMP���� 81�� 12�� 1�Ϻ��� �ʰ� �Ի��� ����� ���, �̸�, �Ի���, �μ���ȣ ���
SELECT EMPNO AS ���, ENAME AS �̸�, HIREDATE AS �Ի���, DEPTNO �μ���ȣ
FROM EMP
WHERE HIREDATE > '81/12/01';

-- �μ���ȣ�� 20�̰�, �Ի����� '81/05/31'���� ���� ����� ���, �̸�, �Ի���, �μ���ȣ�� ����غ���.
SELECT EMPNO AS ���, ENAME AS �̸�, HIREDATE AS �Ի���, DEPTNO �μ���ȣ
FROM EMP
WHERE DEPTNO = 20 AND HIREDATE > '81/05/31';

-- �ܼ� �� ������(=, <, >, <=, >=, !=, ^=)
-- �޿��� 1500���� �۰ų� ���� ����� ������ ��� 
-- ���, �̸�, �޿�, �μ���ȣ
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL <=1500;

-- �޿��� 1000���� ũ�� 3000���� ���� ����� ������ ���.
SELECT  EMPNO AS ���, ENAME AS �̸�, DEPTNO �μ���ȣ, SAL
FROM EMP
WHERE SAL>1000 AND SAL<3000;
-- �޿��� 1500���� 3000 ������ ���� ����� ������ ���.

SELECT  EMPNO AS ���, ENAME AS �̸�, DEPTNO �μ���ȣ, SAL
FROM EMP
WHERE SAL>=1500 AND SAL<3000;

-- BETWEEN A AND B, �������� ���δ�.
SELECT  EMPNO AS ���, ENAME AS �̸�, DEPTNO �μ���ȣ, SAL
FROM EMP
WHERE SAL BETWEEN 1500 AND 3000;

SELECT  EMPNO AS ���, ENAME AS �̸�, SAL, DEPTNO �μ���ȣ
FROM EMP
WHERE DEPTNO = 10 OR DEPTNO = 20;

-- IN() ������, �������� ���δ�.
SELECT  EMPNO AS ���, ENAME AS �̸�, SAL, DEPTNO �μ���ȣ
FROM EMP
WHERE DEPTNO IN(10, 20);

--���ڿ� �� ������ LIKE ������
--���ϵ� ���� %(��� ��), _(�� ���� ��ġ)
--EMP���̺��� �̸��� 'A'�� �����ϴ� ����� �˻�
SELECT
    *
FROM EMP
WHERE ENAME LIKE 'A%';

SELECT
    *
FROM EMP
WHERE ENAME LIKE '%H';

SELECT
    *
FROM EMP
WHERE ENAME LIKE '_I%';

�̸��� ������ �� ���ڰ� N�� ����� ���
SELECT
    *
FROM EMP
WHERE ENAME LIKE '%N_';

SELECT
    *
FROM EMP
WHERE ENAME LIKE '__A%';

-- /%, _���ϵ� ���ڸ� �˻��ؾ� �� �ʿ伺�� ���� ��

CREATE TABLE TEST01(J_CODE VARCHAR2(30));
INSERT INTO TEST01 VALUES('ADPRES');
INSERT INTO TEST01 VALUES('AD_PRES');
INSERT INTO TEST01 VALUES('AD_%PRES');
COMMIT;

SELECT
    *
FROM TEST01;

SELECT
    *
FROM TEST01;
WHERE J_CODE LIKE 'A_%' ESCAPE \;

--ESCAPE ������ ���´� ���ڴ� ���ϵ� ���ڰ� �ƴϰ� �Ϲ� ����
-- �Ϲݹ��ڷ� �ν��ض�

SELECT
    *
FROM TEST01
WHERE J_CODE LIKE 'AD\_%' ESCAPE '\';

SELECT
    *
FROM TEST01
WHERE J_CODE LIKE 'AD\_\%%' ESCAPE '\'; --AD_

DROP TABLE TEST01 PURGE;// ���̺��� ������ ���ÿ� �����뵵 ���.

SELECT
    *
FROM EMP
WHERE COMM IS NOT NULL;

-- AND, OR, NOT;
-- MGR IS NULL�̰� SAL�� 3000���� ū ���� ���
SELECT
    *
FROM EMP
WHERE MGR IS NULL AND SAL > 3000;

SELECT
    *
FROM EMP;
-- WHERE JOB NOT IN ('CLERK', 'PRESIDENT');
-- WHERE SAL NOT BETWEEN 800 AND 1500;
-- WHERE ENAME NOT LIKE '%A%';
-- WHERE COMM IS NOT NULL;
/* ���� ORDER BY��
SELECT �÷�
FROM ���̺�
[WHERE ���� ] []: ���� ����
[ORDER BY �÷�];
�� �������� ����Ѵ�.
�ɼ�: ASC(��������), DESC(��������) DEFAULT: ASC
*/

-- EMP���̺��� �μ���ȣ�� �����غ���..

SELECT *
FROM EMP
ORDER BY DEPTNO ASC;

SELECT *
FROM EMP
WHERE DEPTNO = 30
ORDER BY SAL  DESC;

--EMP���� �μ���ȣ 30���� ����� ���������� �����غ���

Select EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, (SAL*12+NVL(COMM, 0)) AS ����, DEPTNO AS �μ���ȣ
from EMP
where DEPTNO = 30
ORDER BY ���� DESC;

-���ڷ� ����, 3 SELECT �� ��° �÷����� �����ض�.
Select EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, (SAL*12+NVL(COMM, 0)) AS ����, DEPTNO AS �μ���ȣ
from EMP
where DEPTNO = 30
ORDER BY 4 DESC;

-- NULL ���� �ִ� �÷��� ����
Select EMPNO AS ���, ENAME AS �̸�, COMM, SAL AS �޿�, (SAL*12+NVL(COMM, 0)) AS ����, DEPTNO AS �μ���ȣ
from EMP
where DEPTNO = 30
ORDER BY 3 DESC NULLS FIRST; -- NULL ���� ��� �� ����

Select EMPNO AS ���, ENAME AS �̸�, COMM, SAL AS �޿�, (SAL*12+NVL(COMM, 0)) AS ����, DEPTNO AS �μ���ȣ
from EMP
where DEPTNO = 30
ORDER BY 3 DESC NULLS FIRST; -- ���� �� NULL �� ���

--���� �� �Լ�: ����Ŭ�� �ٸ� DB�ϰ� �̸�, ��� ���̰� ���� �� �ִ�.
1. ���� �Լ�: ó���Ǵ� �����Ͱ� ���� ���� ������
2. ���� �Լ�: ó���Ǵ� �����Ͱ� ���� ���� ������
3. ��¥ �Լ�: ó���Ǵ� �����Ͱ� ��¥ ���� ������
4. �Ϲ� �Լ�: ó���Ǵ� �����Ͱ� �Ϲ� ���� ������
5. ����ȯ �Լ�: ó���Ǵ� �����Ͱ� ���� ������
            ������ �������� ������ �ʿ䰡 ���� �� ���.
            * ����, ��¥ �����͸� ���� �����ͷ� ��ȯ
            * ���� �����͸� ��¥, ���� �����ͷ� ��ȯ
-- DUAL ���̺�: ����Ŭ ������ �����ϴ� ��� ������ �Լ��� �׽�Ʈ ���� ����� �� �ֵ��� �����Ǵ� ���� ���̺�

DESC DUAL;

SELECT UPPER('abcd efg hijk') AS "UPPER",
        LOWER('abcd efg hijk') AS "lower",
        INITCAP('abcd efg hijk') AS "InitCap"
FROM DUAL;
--���� ������ �Լ� UPPER('���ڿ�') �Լ�, LOWER('���ڿ�') �Լ�
--�빮��, �ҹ���, ù���ڸ� �빮�� �������� �ҹ���

--EMP�μ���ȣ 20���� ����� �̸��� ��� �ҹ��ڷ� ǥ��, JOB�÷��� ù���� �빮�� ������ �ҹ��ڷ� ǥ���غ���
SELECT LOWER(ENAME), INITCAP(JOB), UPPER(ENAME)
FROM EMP
WHERE DEPTNO = 20;

--SELECT ENAME
--FROM EMP
--WHERE UPPER(ENAME) = 'KIM';
--CONCAT('���ڿ�', '���ڿ�' �Լ�: �� ���ڿ��� ���δ�.
SELECT CONCAT('HELLO', 'WORLD')
FROM DUAL;

-- SUBSTR('���ڿ�', ������ġ,[������ ���� ��])
-- �����ͷκ��� ���ϴ� ���ڿ��� ����

SELECT SUBSTR('20080815', 1, 4),
        SUBSTR('20080815', 5, 4), 
        SUBSTR('20080815', 7), 
        SUBSTR('20080815', -2)
FROM DUAL;

-- LENGTH('���ڿ�') �Լ�: ���ڿ��� ���̸� ���� ���� ��ȯ
-- LENGTHB('���ڿ�') �Լ�: ���ڿ��� ���̸� ����Ʈ ���� ��ȯ
SELECT LENGTH('ȫ�浿'), LENGTHB('ȫ�浿')
FROM DUAL;

-- REPLACE('���ڿ�', 'ã�� ����', '��ü ����') �Լ�
-- ���ڿ����� ����(��)�� ã�Ƽ� ����(��)�� ��ü
SELECT REPLACE('JACK AND JUE', 'J', 'BL'),
            REPLACE('JAVA AND ORACLE', ' AND ', '')
FROM DUAL;

-- TRIM('����'FROM'���ڿ�') �Լ�: ���ڿ� �糡�� ���ӵ� ���ڸ� ����, �߰��� �ִ� ���ڴ� ���� �Ұ�
SELECT TRIM(BOTH 'S' FROM 'SSMISTHSS') AS "R1",
        TRIM('S' FROM 'SSMISTHSS') AS "R2",
        TRIM(LEADING 'S' FROM 'SSMISTHSS') AS "R3",
        TRIM(TRAILING BOTH 'S' FROM 'SSMISTHSS') AS "R4",

SELECT LTRIM('S', 'SSMISTHSS') AS "R1",
        RTRIM('S', 'SSMISTHSS') AS "R2",
        LTRIM(RTRIM('SSMISTHSS', 'S'), 'S') AS "R3",
FROM DUAL;

LPAD('���ڿ�' ��� �� ���Ǵ� BYTE ����, '���� ��ĭ�� ä�� ����')
RPAD('���ڿ�' ��� �� ���Ǵ� BYTE ����, '���� ��ĭ�� ä�� ����')
SELECT LPAD('SMITH', 10, '*') AS "RESULT"
FROM DUAL;

--INSTR('���ڿ�'), ã�� ����(��)' [, �˻� ���� �ڸ���, ���� )
-- ã�� ���ڳ� ���ڿ��� ������ �� ���ڳ� ���ڿ��� ���۵� �ڸ� ���� ��ȯ�ϰ�, ������ 0 ��ȯ

SELECT INSTR('HELLO ORACLE', 'L', 1, 1) AS "R1",
        INSTR('HELLO ORACLE', 'L') AS "R2",
        INSTR('HELLO ORACLE', 'L', 4, 2) AS "R3",
        INSTR('HELLO ORACLE', 'L', 4, 3) AS "R4",
        INSTR('HELLO ORACLE', 'L', -8, 2) AS "R5",
        INSTR('HELLO ORACLE', 'ORACLE') AS "R6"
FROM DUAL;

SELECT EMPNO, CONCAT(ENAME, JOB) AS "NAMEJOB",
                LENGTH(ENAME), INSTR(ENAME,'A') AS "CONTIAINS A?"
FROM EMP
WHERE SUBSTR(JOB, 4) = 'RK';
-- ���� ���� �� �Լ�
-- MOD(����1, ����2) �Լ�: ����1�� ����2�� ������ ���� ������
SELECT MOD(1600, 2)
FROM DUAL;
---ROUND(����[, �Ҽ��� ���� ��ȿ �ڸ���]) �Լ�
SELECT ROUND(1745.9260, 4) As "R1", 
        ROUND(1745.9260, 1) As "R2", 
        ROUND(1745.9260, 0) As "R3", 
        ROUND(1745.9260) As "R4"
FROM DUAL;

SELECT ROUND(1745.9260, -1) As "R1", --1�� �ڸ�
        ROUND(1745.9260, -2) As "R2", --10�� �ڸ�
        ROUND(1745.9260, -3) As "R3", --100�� �ڸ�
        ROUND(1745.9260, -4) As "R4" --1000�� �ڸ�
FROM DUAL;

-- TRUNC(����[, �Ҽ��� ���� ��ȿ�ڸ���]): �Ҽ������� ��ȿ�ڸ��� ����

SELECT TRUNC(1745.9260, 4) AS "R1", --�Ҽ��� 4�ڸ� ������ ����(����)
        TRUNC(1745.9260, 2) AS "R2", --�Ҽ��� 2�ڸ� ������ ����(����)
        TRUNC(1745.9260, 0) AS "R3", --�Ҽ��� ����
        TRUNC(1745.9260) AS "R4" --�Ҽ���
FROM DUAL;

SELECT ENAME, SAL, TRUNC(SAL/500,0), MOD(SAL, 500)
FROM EMP
WHERE DEPTNO = 30;

--CEIL(N) : N���� ū ���� ���� ����, ������ ���밪�� �������� ���� ��

SELECT CEIL(23.223), CEIL(-45.923)
FROM DUAL;
--FLOOR(N); N���� ���� ���� ū ����
SELECT FLOOR(23.223), FLOOR(-45.923)
FROM DUAL;
--POWER(M, N): M�� N����
SELECT POWER(3, 3), POWER(9, 3)
FROM DUAL;

--ABS(N): N�� ����
SELECT ABS(3), ABS(-3)
FROM DUAL;
--SQRT(N): N�� ������, ��Ʈ
SELECT SQRT(9), SQRT(18)
FROM DUAL;

-SIGN(N): N�� �����̸� -1, ����̸� 1, 0�̸� 0 ���
SELECT SIGN(-1), SIGN(1), SIGN(0)
FROM DUAL;

--��¥ �Լ�
--SYSDATE: ����Ŭ ������ ��Ǵ� OS�� ��¥�� �ð���
--DATE Ÿ������ ��ȯ

SELECT SYSDATE
FROM DUAL;

--WHERE������ ��¥ ������ �����ؾ� �ϴµ�, �ѱ� WINDOWS�� ��ġ�� SQL-DEVELOPER�� �⺻�� �ѱ��̶� YY//MM/DD�� ���ϵ�
--���� 07-JUN-21, �����Ϥ��� ���� ������ �ٸ��� ���ϵ�.
--WHERE������ TO_DATE() �Լ��� �̿��Ͽ� ��¥�� ���ó�� ����
SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE < TO_DATE('1981-01-01', 'YY-MM-DD');

--DATE ������ �����Ϳ� ��� �����ϱ�
--��¥+����: TO_DATE('2009/10/04', 'YYYY/MM/DD')+3

SELECT ENAME, TRUNC((SYSDATE-HIREDATE)/7,0) AS "WEEK"
FROM EMP
WHERE DEPTNO = 30;

--MONTHS_BETWEEN('��¥1', '��¥2') �Լ�: �� ��¥ ������ ����
SELECT ENAME, TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate), 0) AS "RESULT", DEPTNO
FROM EMP
WHERE DEPTNO = 30
ORDER BY RESULT DESC;

--NEXT_DAY('��¥', '����') �Լ�
--��¥ �������� ������ ���� ������ ��¥ ��ȯ
SELECT NEXT_DAY(TO_DATE('21/06/07', 'YY/MM/DD'), '�ݿ���')
FROM DUAL;

-- ADD_MONTHS('��¥', '����') �Լ�
-- ���ڸ�ŭ �� ���� ���� ��¥�� ��ȯ

--LAST_DAY('��¥') �Լ�: ��¥�� ���Ե� ���� �� ������ ��
SELECT LAST_DAY(TO_DATE('2000-02-15', 'YYYY-MM-DD'))
FROM DUAL;
SELECT LAST_DAY(TO_DATE('2001-02-29', 'YYYY-MM-DD'))
FROM DUAL;

--��¥ ROUND() �ݿø�, TRUNC() ����
--�ǽ��� ���� ���� ��¥ ǥ�� ������ �ٲ�
--���������ϸ� ������� ���ƿ´�.
ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD';

--ROUND()
SELECT SYSDATE, ROUND(SYSDATE, 'YEAR')
FROM DUAL;

--TRUNC()
SELECT SYSDATE, TRUNC(SYSDATE, 'YEAR')
FROM DUAL;

/*
VARCHAR OR CHAR -> NUMBER: ���ڷ� �� ���ڸ� ���ڷ� �ڵ� ��ȯ
VARCHAR OR CHAR -> DATE: ������ DATE ǥ�� ���İ� ��ġ��
*/

SELECT '1' + '1' AS "RESULT1", 1||1 AS "RESULT2"
FROM DUAL;

-- TO_CHAR(), TO_DATE(), TO_NUMBER() ����ؼ� ��������� ��ȯ�ض�..

/* ��¥ ����
YYYY: 4�ڸ� ���� ����
YY: 2�ڸ� ����(2000�⵵)
RR: 2�ڸ� ����(1900�⵵)
YEAR: ����� ǥ���� ����.
MM: ���ڷ� �� �� EX) 12
MONTH: ���̸�. ����: June, �ѱ���: 6��
MON: 3�ڸ� ���, ����: JUN, �ѱ���: 6��
Day: ����(����: MONDAY, �ѱ���: ������)
DY: 3�ڸ� ���(����: MON, �ѱ��� ��)
HH24: ���ڷε� �ð�(24�ð� ǥ���)

*/