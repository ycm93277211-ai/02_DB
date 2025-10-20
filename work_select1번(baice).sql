

SELECT * FROM TB_CLASS  ;
SELECT * FROM TB_DEPARTMENT    ;	
SELECT * FROM TB_GRADE     ;
SELECT * FROM TB_PROFESSOR      ;
SELECT * FROM TB_STUDENT       ;
-------------------------- 1번 문제 ----------------------------

SELECT DEPARTMENT_NAME"학과 명",CATEGORY "계열"
FROM TB_DEPARTMENT td;

-------------------------- 2번 문제 ----------------------------

SELECT
DEPARTMENT_NAME || '의 정원은 ',CAPACITY||'명 입니다.'"학과별 정원"
FROM 
TB_DEPARTMENT td;

-------------------------- 3번 문제 ----------------------------

SELECT STUDENT_NAME 
FROM TB_STUDENT td
WHERE DEPARTMENT_NO='001' AND ABSENCE_YN ='Y'
AND SUBSTR(STUDENT_SSN,8,1) ='2' ;

-------------------------- 4번 문제 ----------------------------
SELECT STUDENT_NAME
FROM TB_STUDENT td
WHERE STUDENT_NO IN('A513079','A513090','A513091','A513110','A513119')
ORDER BY STUDENT_NAME DESC ;

-------------------------- 5번 문제 ----------------------------

SELECT DEPARTMENT_NAME ,CATEGORY  
FROM TB_DEPARTMENT
WHERE CAPACITY>=20 AND CAPACITY<=30;

-------------------------- 6번 문제 ----------------------------

SELECT PROFESSOR_NAME 
FROM TB_PROFESSOR  
WHERE DEPARTMENT_NO IS NULL;-- NULL 사용 시 IS 써야함

-------------------------- 7번 문제 ----------------------------

SELECT STUDENT_NAME
FROM TB_STUDENT 
WHERE DEPARTMENT_NO IS NULL;

-------------------------- 8번 문제 ----------------------------

SELECT CLASS_NO 
FROM TB_CLASS 
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-------------------------- 9번 문제 ----------------------------

SELECT DISTINCT CATEGORY -- DISTINCT : 중복 제거
FROM TB_DEPARTMENT    ;

-------------------------- 10번 문제 ----------------------------

SELECT * FROM TB_STUDENT  ;

SELECT STUDENT_NO,STUDENT_NAME ,STUDENT_SSN 
FROM TB_STUDENT
WHERE TO_CHAR(ENTRANCE_DATE,'YY') = '02' -- DATE 타입은 숫자 문자로 비교 불가 그래서 문자열로 바꿔줘야함
AND STUDENT_ADDRESS LIKE '%전주%' AND  ABSENCE_YN IN('N');
-- %전주% 전주포함 , '전주'정확히 전주









