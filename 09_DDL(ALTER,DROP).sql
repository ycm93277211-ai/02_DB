-- DDL(Data Definition Langusage): 데이터 정의 언어
-- 객체를 만들고(CREATE), 바꾸고(ALTER), 삭제(DROP) 하는 데이터 정의 언어

/*
 * ALTER(바꾸다, 수정하다, 변조하다)
 * 
 * -- 테이블에서 수정할 수 있는 것
 * 1) 제약 조건(추가/삭제)
 * -> 제약조건 자체를 수정하는 구문은 별도로 존재 X 
 * -> 그래서 삭제 후 추가해야함...
 * 
 * 2) 컬럼(추가/수정/삭제)
 * 
 * 3) 이름변경 ( 테이블명, 컬럼명, 제약조건명)
 * 
 * 
 * */


-- 1) 제약조건 (추가/삭제)

-- [작성법]
-- 1) 추가: ALTER TABLE 테이블명 
--			ADD [CONSTRAINT 제약조건명] 제약조건(지정할 컬럼명)
--			[REFERENCES 테이블명(컬럼명)]<- FK인 경우 추가

-- 2) 삭제: ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;

-- DEPARTMENT 테이블 복사 (컬럼명, 데이터타입, NOT NULL 만 복사)
CREATE  TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;


--DEPT_COPY의 DEPT_TITLE 컬럼에 UNIQUE 추가 -> 변경(ALTER)
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DEPT_COPY_TITLE_U UNIQUE (DEPT_TITLE);

-- DEPT_COPY의 DEPT_TITLE 컬럼에 설정된 UNIQUE 삭제
ALTER TABLE DEPT_COPY 
DROP CONSTRAINT DEPT_COPY_TITLE_U;

--*** DEPT_COPY의 DEPT_TITLE 컬럼에 NOT NULL 제약조건 추가/삭제****
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DEPT_COPY_TITLE_NN NOT NULL (DEPT_TITLE);
--부적합한 식별자 (걍 틀린거임)
--> NOT NULL 제약조건은 새로운 조건을 추가하는 것이 아닌
-- 컬럼 자체에 NULL 허용/비허용을 제어하는 성질 변경의 형태로 인식됨.

-- MODIFY(수정하다) 구문을 사용해서 NULL 제어
ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE NOT NULL; -- DEP_TITLE 컬럼에 NULL 비허용

ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE  NULL; -- DEP_TITLE 컬럼에 NULL 허용

---------------------------------------------------------------------


--2. 컬럼(추가/수정/삭제)

-- 컬럼 추가
-- ALTER TABLE 테이블명 ADD (컬럼명 데이터타입 [DEFAULT '값']);

-- 컬럼 수정
-- ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입; --> 데이터 타입 변경
-- ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT '값'; --> DEFAULT 값 변경 

--컬럼 삭제
-- ALTER TABLE 테이블명 DROP (삭제할 컬럼명);
-- ALTER TABLE 테이블명 DROP COLUMN 삭제할 컬럼명;

SELECT *FROM DEPT_COPY;

-- CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD (CNAME VARCHAR2(30));


-- LNAME 컬럼 추가 (DEFAULT '한국')
ALTER TABLE DEPT_COPY ADD (LNAME VARCHAR2(30) DEFAULT '한국');
-->컬럼이 생성되면서 DEFAULT 값이 자동 삽입되었음을 확인


-- D10 개발1팀 추가 (행 추가)
INSERT  INTO DEPT_COPY 
VALUES('D10','개발1팀','L1',DEFAULT,DEFAULT);
--"DEPT_COPY"."DEPT_ID" 열에 대한 값이 너무 큼(실제: 3, 최대값: 2)
-->DEPT_ID의 테이터 타입이 CHAR(2) 이므로 영어+숫자 2글자까지 저장 가능
-->D10 는 영어+숫자 3글자!!
--> 그래서 VARCHAR2(3)으로 변경해보기(남는 바이트 메모리 반환을 위해서)

-- DEPT_ID 컬럼 데이터 타입 수정
ALTER TABLE DEPT_COPY MODIFY DEPT_ID VARCHAR2(3);

SELECT *FROM DEPT_COPY;
--컬럼의 데이터 타입 변경 후 위 INSERT 수행-> 삽입 성공 확인

--LNAME 의 기본값을 'KOREA'로 수정
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT 'KOREA';
--> 기본값을 변경했다고 해서 기존 데이터가 변하지는 않음
--> 새로 삽입될 행에서부터 변경된 기본값 적용
--> 기본 데이터변경 할려면 UPDATE 사용
-- LNAME '한국' -> 'KOREA'로 변경
UPDATE  DEPT_COPY SET 
LNAME = DEFAULT-- DEFALUT = 'KOREA'
WHERE LNAME = '한국';

COMMIT ;

--DEPT_COPY 모든 컬러 삭제

ALTER TABLE DEPT_COPY DROP (LNAME);
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;
-- ORA-12983: 테이블에 모든 열들을 삭제할 수 없습니다
-- 컬럼이 꼭 한개는 있어야함!
SELECT *FROM DEPT_COPY;

-- 테이블 삭제
DROP TABLE DEPT_COPY;
-- ORA-00942: 테이블 또는 뷰가 존재하지 않습니다


--DEPARTMENT 테이블 복사해서 DEPT_COPY 생성
CREATE  TABLE DEPT_COPY 
AS SELECT * FROM DEPARTMENT;
-- 컬럼명,데이터타입,NOT NULL 여부만 복사

-- DEPT_COPY 테이블에서 PK 추가(컬럼: DEPT_ID,제약조건명:D_COPY_PK)
ALTER TABLE DEPT_COPY ADD CONSTRAINT D_COPY_PK PRIMARY KEY(DEPT_ID);


--3 이름변경(컬럼,제약조건명,테이블)

--1) 컬럼명 변경 (EPT_TITLE -> DEPT_NAME)
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
SELECT *FROM DEPT_COPY;

--2) 제약조건명 변경 (D_COPY_PK ->DEPT_COPY_PK )
ALTER TABLE DEPT_COPY RENAME  CONSTRAINT D_COPY_PK TO DEPT_COPY_PK ;

--3 테이블명 변경(DEPT_COPY -> DCOPY)
ALTER TABLE DEPT_COPY RENAME TO DCOPY;
--ORA-00942: 테이블 또는 뷰가 존재하지 않습니다

SELECT *FROM  DCOPY;-- 테이블명을 변경 했기에 DCOPY로 조회 해야한다


-- 4. 테이블 삭제
-- DROP TABLE 테이블명 [CASCADE CONSTRAINTS];

--1) 관계가 형성되지 않은 테이블 삭제
DROP TABLE DCOPY;

--2) 관계가 형성된 테이블 삭제

CREATE TABLE  TB1(
	TB1_PK NUMBER PRIMARY KEY,
	TB1_COL NUMBER
); -- 부모 테이블

CREATE TABLE  TB2(
	TB2_PK NUMBER PRIMARY KEY,
	TB2_COL NUMBER REFERENCES TB1
); -- 자식 테이블

-- TB1에 샘플 데이터 삽입
INSERT INTO TB1 VALUES(1,100);
INSERT INTO TB1 VALUES(2,200);
INSERT INTO TB1 VALUES(3,300);

-- TB1에 샘플 데이터 삽입
INSERT INTO TB2 VALUES(11,1);
INSERT INTO TB2 VALUES(12,2);
INSERT INTO TB2 VALUES(13,3);


COMMIT;

-- TB1과 TB2는 부모 - 자식 테이블 관계 형성
DROP TABLE TB1;
--ORA-02449: 외래 키(FK)에 의해 참조되는 고유/기본 키가 테이블에 있습니다
--> 해결 방법
--1) 자식테이블 삭제 후 부모 테이블 삭제
--2) ALTET 를 이용해서 FK 제약조건 삭제 후 TB1 삭제 
--3) DROP TABLE 삭제 옵션 CASCADE CONSTRAINTS 사용
--> CASCADE CONSTRAINTS: 삭제하려는 테이블과 연결된 FK 제약조건을 모두 삭제

DROP TABLE TB1 CASCADE CONSTRAINTS;
-- 테이블 삭제 시 FK 관계도 모두 삭제

SELECT * FROM TB1;-- 삭제 확인 됨!!
-- ORA-00942: 테이블 또는 뷰가 존재하지 않습니다

SELECT * FROM TB2;-- TB2 테이블은 독락적인 테이블로 혼자 남게됨(TB1이랑 아무 관계 없음)

------------------------------------------------------------------------------

-- DDL 주의 사항
--1) DDL은 COMMIT/ROLLBACK 의 대상이 아님.
--2) DDL과 DML 구문 섞어서 수행하면 안된다!
--> DDL은 수행 시 존재하고 있는 트랜잭션을 모두 DB에 강제 COMMIT 시킴!
--> DDL이 종료된 후 DML 구문을 수행할 수 있도록 하자(권장)
-- DDL(CREATE,ALTER,DROP): 객체 생성/수정/삭제
-- DML(INSERT/UPDATE/DELETE): 데이터(행) 추가/갱신/삭제

SELECT  * FROM TB2;

COMMIT;

--DML
INSERT INTO TB2 VALUES(14,4);
INSERT INTO TB2 VALUES(15,5);

SELECT *FROM TB2;-- 그냥 조회만 해줌 저장 안됨!

-- DDL(컬럼명 변경)
ALTER TABLE TB2 RENAME COLUMN TB2_COL TO TB2_COLUMN;
-- 강제로 COMMIT 이 됨!
ROLLBACK ;

SELECT *FROM TB2;
-- 롤백 안된다. 위에서 DDL 구문 중 ALTER를 사용하여 그 시점에 COMMIT 됨






































































