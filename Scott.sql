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