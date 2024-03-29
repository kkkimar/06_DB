-- 유저명 VARCHAR2(100)
-- VARCHAR2 란 : 숫자 영어 한글 등 모든 문자들 넣을 수 있는 공간

-- PRIMARY KEY : 만들어진 정보에 기본으로 보여되는 키
CREATE TABLE TB_GRADE(
	GRADE_CODE VARCHAR2(10) PRIMARY KEY,
	GRADE_NAME VARCHAR2(20)
);

CREATE TABLE TB_AREA(
	AREA_CODE VARCHAR2(10) PRIMARY KEY,
	AREA_NAME VARCHAR2(20)
);

-- GRADE에 테이블 데이터 넣기! INSERT
/*
 * 20 우수회원
 * 30 특별회원
 * 40 골드회원
 * 50 플래티넘
 * 60 다이아몬드
 * */
INSERT INTO TB_GRADE(GRADE_CODE, GRADE_NAME) VALUES('10','일반회원');
INSERT INTO TB_GRADE(GRADE_CODE, GRADE_NAME) VALUES('20','우수회원');
INSERT INTO TB_GRADE(GRADE_CODE, GRADE_NAME) VALUES('30','특별회원');
INSERT INTO TB_GRADE(GRADE_CODE, GRADE_NAME) VALUES('40','골드회원');
INSERT INTO TB_GRADE(GRADE_CODE, GRADE_NAME) VALUES('50','플래티넘');
INSERT INTO TB_GRADE(GRADE_CODE, GRADE_NAME) VALUES('60','다이아몬드');


-- TB_MEMBER 테이블 생성 
CREATE TABLE TB_MEMBER ( MEMBERID VARCHAR2(20) PRIMARY KEY, MEMBERPWD VARCHAR2(20), MEMBER_NAME VARCHAR2(50), GRADE VARCHAR2(10), AREA_CODE VARCHAR2(10), FOREIGN KEY (GRADE) REFERENCES TB_GRADE(GRADE_CODE), FOREIGN KEY (AREA_CODE) REFERENCES TB_AREA(AREA_CODE) );


-- TB_AREA 테이블 데이터 삽입 
INSERT INTO TB_AREA (AREA_CODE, AREA_NAME) VALUES ('02', '서울'); 
INSERT INTO TB_AREA (AREA_CODE, AREA_NAME) VALUES ('031', '경기'); 
INSERT INTO TB_AREA (AREA_CODE, AREA_NAME) VALUES ('032', '인천');

-- TB_MEMBER 테이블 데이터 삽입 
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('hong01', 'pass01', '홍길동', '10', '02'); 
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('leess99', 'pass02', '이순신', '10', '032'); 
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('SS50000', 'pass03', '신사임당', '30', '031'); 
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('1u93', 'pass04', '아이유', '30', '02'); 
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('pcs1234', 'pass05', '박철수', '20', '031'); 
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('you_is', 'pass06', '유재석', '10', '02'); 
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('kyh9876', 'pass07', '김영희', '20', '031');

SELECT AREA_NAME 지역명, MEMBERID 아이디, MEMBER_NAME 이름, GRADE_NAME 등급명
FROM TB_MEMBER
JOIN TB_GRADE ON(GRADE = GRADE_CODE)
JOIN TB_AREA USING (AREA_CODE)
WHERE AREA_CODE = (
SELECT AREA_CODE 
FROM TB_MEMBER
WHERE MEMBER_NAME = '김영희')
AND MEMBER_NAME != '김영희'
ORDER BY 이름;

--1: TB_GRADE 테이블에서 모든 등급 코드와 등급 이름을 조회
SELECT * FROM TB_GRADE;

--2: TB_AREA 테이블에서 지역 코드가 '02'인 지역의 이름을 조회
SELECT AREA_NAME FROM TB_AREA WHERE AREA_CODE = '02';

--3: TB_MEMBER 테이블에서 모든 회원의 이름과 등급을 조회
SELECT MEMBER_NAME, GRADE FROM TB_MEMBER;

--4: TB_MEMBER 테이블에서 이름이 '이순신'인 회원의 아이디를 조회
SELECT MEMBERID FROM TB_MEMBER WHERE MEMBER_NAME = '이순신';

--5: TB_MEMBER 테이블에서 등급이 '20'인 회원의 이름과 지역 코드를 조회
SELECT MEMBER_NAME, AREA_CODE FROM TB_MEMBER WHERE GRADE = '20';

--6: TB_MEMBER 테이블에서 지역이 '서울'인 회원의 아이디와 이름을 조회
SELECT MEMBERID, MEMBER_NAME FROM TB_MEMBER 
WHERE AREA_CODE IN (SELECT AREA_CODE FROM TB_AREA WHERE AREA_NAME = '서울');

--7: TB_MEMBER 테이블에서 등급이 '특별회원'인 회원의 수를 조회
SELECT COUNT(*) FROM TB_MEMBER 
WHERE GRADE IN (SELECT GRADE_CODE FROM TB_GRADE WHERE GRADE_NAME = '특별회원');

--8: TB_MEMBER 테이블에서 이름이 '홍길동'이거나 '박철수'인 회원의 아이디를 조회
SELECT MEMBERID FROM TB_MEMBER WHERE MEMBER_NAME IN ('홍길동', '박철수');

--9: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 지역 코드가 '031'인 회원의 이름을 조회
SELECT MEMBER_NAME FROM TB_MEMBER WHERE GRADE = '20' AND AREA_CODE = '031';

--10: TB_MEMBER 테이블에서 아이디가 'kyh9876'인 회원의 등급을 조회
SELECT GRADE FROM TB_MEMBER WHERE MEMBERID = 'kyh9876';


--11: TB_MEMBER 테이블에서 등급이 '일반회원'이면서 지역이 '경기' 또는 '인천'인 회원의 아이디와 이름을 조회
SELECT MEMBERID, MEMBER_NAME FROM TB_MEMBER 
WHERE GRADE = '10' AND AREA_CODE IN ('031', '032');

--12: TB_MEMBER 테이블에서 등급이 '특별회원'인 회원 중에서 지역이 '서울'이 아닌 회원의 수를 조회
SELECT COUNT(*) FROM TB_MEMBER 
WHERE GRADE = '30' AND AREA_CODE <> '02';

--13: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 이름이 '김영희'인 회원의 등급과 지역을 조회
SELECT GRADE, AREA_CODE FROM TB_MEMBER 
WHERE GRADE = '20' AND MEMBER_NAME = '김영희';

--14: TB_MEMBER 테이블에서 등급이 '일반회원'이고 지역이 '경기'인 회원 중에서 가입일이 2024년 3월 1일 이후인 회원의 이름을 조회
SELECT MEMBER_NAME FROM TB_MEMBER 
WHERE GRADE = '10' AND AREA_CODE = '031' 
AND JOIN_DATE > TO_DATE('2024-03-01', 'YYYY-MM-DD');

--15: TB_MEMBER 테이블에서 등급이 '특별회원'이면서 아이디가 'SS50000'이거나 '1u93'인 회원의 지역을 조회
SELECT AREA_CODE FROM TB_MEMBER 
WHERE GRADE = '30' AND MEMBERID IN ('SS50000', '1u93');

--16: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 이름에 '유'가 포함된 회원의 아이디를 조회
SELECT MEMBERID FROM TB_MEMBER 
WHERE GRADE = '20' AND MEMBER_NAME LIKE '%유%';

--17: TB_MEMBER 테이블에서 등급이 '일반회원'이면서 가입일이 현재 날짜보다 이전인 회원의 수를 조회
SELECT COUNT(*) FROM TB_MEMBER 
WHERE GRADE = '10' AND JOIN_DATE < SYSDATE;

--18: TB_MEMBER 테이블에서 등급이 '특별회원'이면서 가장 오래된 회원의 아이디를 조회
SELECT MEMBERID 
FROM TB_MEMBER 
WHERE GRADE = '30' 
ORDER BY JOIN_DATE ASC 
FETCH FIRST 1 ROWS ONLY;

--19: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 이름이 '신사임당'이 아닌 회원의 수를 조회
SELECT COUNT(*) FROM TB_MEMBER 
WHERE GRADE = '20' AND MEMBER_NAME <> '신사임당';

--20:TB_MEMBER 테이블에서 등급이 '일반회원'이면서 지역이 '서울'인 회원의 이름과 등급을 조회 단, 결과를 등급에 따라 내림차순으로 정렬
SELECT MEMBER_NAME, GRADE FROM TB_MEMBER 
WHERE GRADE = '10' AND AREA_CODE = '02' 
ORDER BY GRADE DESC;
--21: TB_MEMBER 테이블에서 회원 이름의 길이가 4 이상인 회원의 아이디와 이름을 조회
SELECT MEMBERID, MEMBER_NAME FROM TB_MEMBER WHERE LENGTH(MEMBER_NAME) >= 4;

--22: TB_MEMBER 테이블에서 등급이 '특별회원'이면서 이름이 '김영희'가 아닌 회원의 아이디를 조회
SELECT MEMBERID FROM TB_MEMBER WHERE GRADE = '30' AND MEMBER_NAME != '김영희';

--23: TB_MEMBER 테이블에서 등급이 '일반회원'인 회원 중에서 이름이 '김영희'이거나 '아이유'인 회원의 수를 조회
SELECT COUNT(*) FROM TB_MEMBER 
WHERE GRADE = '10' AND MEMBER_NAME IN ('김영희', '아이유');

--24: TB_MEMBER 테이블에서 등급이 '특별회원'이 아니면서 이름이 '홍길동'이 아닌 회원의 아이디를 조회
SELECT MEMBERID FROM TB_MEMBER 
WHERE GRADE != '30' AND MEMBER_NAME != '홍길동';

--25: TB_MEMBER 테이블에서 등급이 '일반회원'이면서 지역이 '인천' 또는 '경기'인 회원의 아이디와 이름을 조회
SELECT MEMBERID, MEMBER_NAME FROM TB_MEMBER 
WHERE GRADE = '10' AND AREA_CODE IN ('032', '031');

--26: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 이름이 '홍길동'이 아니면서 가장 최근에 가입한 회원의 아이디를 조회
SELECT MEMBERID FROM TB_MEMBER 
WHERE GRADE = '20' AND MEMBER_NAME != '홍길동' AND MEMBERID = (SELECT MAX(MEMBERID) FROM TB_MEMBER WHERE GRADE = '20');

--27: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 가장 최근에 가입한 회원의 이름을 조회
SELECT MEMBER_NAME FROM TB_MEMBER 
WHERE GRADE = '20' AND MEMBERID = (SELECT MAX(MEMBERID) FROM TB_MEMBER WHERE GRADE = '20');

--28: TB_MEMBER 테이블에서 등급이 '일반회원'이면서 이름에 '김'이 들어가는 회원의 수를 조회
SELECT COUNT(*) FROM TB_MEMBER WHERE GRADE = '10' AND MEMBER_NAME LIKE '%김%';

--29: TB_MEMBER 테이블에서 등급이 '특별회원'이 아닌 회원의 수를 조회
SELECT COUNT(*) FROM TB_MEMBER WHERE GRADE != '30';

--30: TB_MEMBER 테이블에서 등급이 '우수회원'인 회원 중에서 아이디가 가장 큰 회원의 이름을 조회
SELECT MEMBER_NAME FROM TB_MEMBER 
WHERE GRADE = '20' AND MEMBERID = (SELECT MAX(MEMBERID) FROM TB_MEMBER WHERE GRADE = '20');

--31: 모든 회원의 이름과 등급을 조회

--32: ​서울에 거주하는 모든 회원의 이름과 등급을 조회

--33: ​우수회원인 회원들의 이름과 등급을 조회

--34: ​특별회원 중에서 이름에 '이'가 들어가는 회원들의 이름을 조회

--35: ​각 등급별로 몇 명의 회원이 있는지 조회

--36: 각 지역별로 몇 명의 회원이 있는지 조회

--37: ​각 지역별로 등급이 '우수회원'인 회원의 수를 조회

--38: ​​지역별로 회원 수가 2명 이상인 지역 중에서 등급이 '일반회원'인 회원 수가 1명 이상인 지역을 조회

--39: ​​각 등급별로 평균 회원 수와 최대 회원 수를 조회

--40: ​​등급이 '특별회원'이면서, 서울에 거주하는 회원 중에서 등급별로 가장 많은 회원 수를 가진 지역을 조회

--41: ​​​회원 아이디가 'hong'으로 시작하고 등급이 '일반회원'인 회원의 이름을 조회

--42: ​​​각 등급별로 회원의 수가 가장 많은 지역을 조회

--43: ​​​각 지역별로 등급이 '특별회원'인 회원의 수를 조회 만약 그 지역에 특별회원이 없으면 '0'으로 표시

--44: ​​​등급이 '특별회원'이 아니고 지역이 '서울'이 아닌 회원 중에서 이름이 '김'으로 시작하는 회원의 수를 조회

--45: ​​​우수회원이면서 지역이 '경기'인 회원들의 평균 등급을 조회

--46: ​​​서울과 경기에 거주하는 회원 중에서 이름이 '이'로 끝나는 회원의 등급을 조회

--47: ​​​특별회원이 아닌 회원 중에서 등급이 가장 높은 회원의 이름을 조회

--48: ​​​서울과 인천에 거주하며 등급이 '일반회원'인 회원의 수를 조회

 

 

모든 회원의 이름과 등급을 조회

SELECT M.MEMBER_NAME, G.GRADE_NAME

FROM TB_MEMBER M

JOIN TB_GRADE G ON M.GRADE = G.GRADE_CODE;

 

서울에 거주하는 모든 회원의 이름과 등급을 조회

SELECT M.MEMBER_NAME, G.GRADE_NAME

FROM TB_MEMBER M

JOIN TB_GRADE G ON M.GRADE = G.GRADE_CODE

JOIN TB_AREA A ON M.AREA_CODE = A.AREA_CODE

WHERE A.AREA_NAME = '서울';

 

우수회원인 회원들의 이름과 등급을 조회

SELECT MEMBER_NAME, GRADE

FROM TB_MEMBER

WHERE GRADE = '20';

 

특별회원 중에서 이름에 '이'가 들어가는 회원들의 이름을 조회

SELECT MEMBER_NAME

FROM TB_MEMBER

WHERE GRADE = '30' AND MEMBER_NAME LIKE '%이%';

 

각 등급별로 몇 명의 회원이 있는지 조회

SELECT G.GRADE_NAME, COUNT(*) AS MEMBER_COUNT

FROM TB_MEMBER M

JOIN TB_GRADE G ON M.GRADE = G.GRADE_CODE

GROUP BY G.GRADE_NAME;

 

각 지역별로 몇 명의 회원이 있는지 조회

SELECT A.AREA_NAME, COUNT(*) AS MEMBER_COUNT

FROM TB_MEMBER M

JOIN TB_AREA A ON M.AREA_CODE = A.AREA_CODE

GROUP BY A.AREA_NAME;

 

각 지역별로 등급이 '우수회원'인 회원의 수를 조회

SELECT A.AREA_NAME, COUNT(*) AS EXCELLENT_MEMBER_COUNT

FROM TB_MEMBER M

JOIN TB_AREA A ON M.AREA_CODE = A.AREA_CODE

WHERE M.GRADE = '20'

GROUP BY A.AREA_NAME;

 

지역별로 회원 수가 2명 이상인 지역 중에서 등급이 '일반회원'인 회원 수가 1명 이상인 지역을 조회

SELECT A.AREA_NAME

FROM TB_MEMBER M

JOIN TB_AREA A ON M.AREA_CODE = A.AREA_CODE

GROUP BY A.AREA_NAME

HAVING COUNT(*) >= 2

AND SUM(CASE WHEN M.GRADE = '10' THEN 1 ELSE 0 END) >= 1;

 

각 등급별로 평균 회원 수와 최대 회원 수를 조회

SELECT G.GRADE_NAME, AVG(MEMBER_COUNT) AS AVERAGE_MEMBER_COUNT, MAX(MEMBER_COUNT) AS MAX_MEMBER_COUNT

FROM (

    SELECT G.GRADE_NAME, COUNT(*) AS MEMBER_COUNT

    FROM TB_MEMBER M

    JOIN TB_GRADE G ON M.GRADE = G.GRADE_CODE

    GROUP BY G.GRADE_NAME

) GROUP_BY_RESULT

GROUP BY G.GRADE_NAME;

 

등급이 '특별회원'이면서, 서울에 거주하는 회원 중에서 등급별로 가장 많은 회원 수를 가진 지역을 조회

SELECT G.GRADE_NAME, A.AREA_NAME, MAX(MEMBER_COUNT) AS MAX_MEMBER_COUNT

FROM (

    SELECT G.GRADE_NAME, A.AREA_NAME, COUNT(*) AS MEMBER_COUNT

    FROM TB_MEMBER M

    JOIN TB_GRADE G ON M.GRADE = G.GRADE_CODE

    JOIN TB_AREA A ON M.AREA_CODE = A.AREA_CODE

    WHERE G.GRADE_NAME = '특별회원' AND A.AREA_NAME = '서울'

    GROUP BY G.GRADE_NAME, A.AREA_NAME

) GROUP_BY_RESULT;

 

회원 아이디가 'hong'으로 시작하고 등급이 '일반회원'인 회원의 이름을 조회

SELECT MEMBER_NAME

FROM TB_MEMBER

WHERE MEMBERID LIKE 'hong%' AND GRADE = '10';

 

각 등급별로 회원의 수가 가장 많은 지역을 조회

SELECT G.GRADE_NAME, A.AREA_NAME, MAX(MEMBER_COUNT) AS MAX_MEMBER_COUNT

FROM (

    SELECT G.GRADE_NAME, A.AREA_NAME, COUNT(*) AS MEMBER_COUNT

    FROM TB_MEMBER M

    JOIN TB_GRADE G ON M.GRADE = G.GRADE_CODE

    JOIN TB_AREA A ON M.AREA_CODE = A.AREA_CODE

    GROUP BY G.GRADE_NAME, A.AREA_NAME

) GROUP_BY_RESULT

GROUP BY G.GRADE_NAME;

 

각 지역별로 등급이 '특별회원'인 회원의 수를 조회 만약 그 지역에 특별회원이 없으면 '0'으로 표시

SELECT A.AREA_NAME, NVL(COUNT(M.MEMBERID), 0) AS SPECIAL_MEMBER_COUNT

FROM TB_AREA A

LEFT JOIN TB_MEMBER M ON A.AREA_CODE = M.AREA_CODE AND M.GRADE = '30'

GROUP BY A.AREA_NAME;

 

 

등급이 '특별회원'이 아니고 지역이 '서울'이 아닌 회원 중에서 이름이 '김'으로 시작하는 회원의 수를 조회

SELECT COUNT(*)

FROM TB_MEMBER

WHERE GRADE <> '30' AND AREA_CODE <> '02' AND MEMBER_NAME LIKE '김%';

 

우수회원이면서 지역이 '경기'인 회원들의 평균 등급을 조회

SELECT AVG(G.GRADE_CODE)

FROM TB_MEMBER M

JOIN TB_GRADE G ON M.GRADE = G.GRADE_CODE

WHERE M.GRADE = '20' AND M.AREA_CODE = '031';

 

서울과 경기에 거주하는 회원 중에서 이름이 '이'로 끝나는 회원의 등급을 조회

SELECT G.GRADE_NAME

FROM TB_MEMBER M

JOIN TB_GRADE G ON M.GRADE = G.GRADE_CODE

JOIN TB_AREA A ON M.AREA_CODE = A.AREA_CODE

WHERE A.AREA_NAME IN ('서울', '경기') AND M.MEMBER_NAME LIKE '%이';

 

특별회원이 아닌 회원 중에서 등급이 가장 높은 회원의 이름을 조회

SELECT M.MEMBER_NAME

FROM TB_MEMBER M

JOIN TB_GRADE G ON M.GRADE = G.GRADE_CODE

WHERE G.GRADE_NAME != '특별회원'

ORDER BY G.GRADE_CODE DESC

FETCH FIRST 1 ROW ONLY;

 

서울과 인천에 거주하며 등급이 '일반회원'인 회원의 수를 조회

SELECT COUNT(*)

FROM TB_MEMBER M

JOIN TB_AREA A ON M.AREA_CODE = A.AREA_CODE

JOIN TB_GRADE G ON M.GRADE = G.GRADE_CODE

WHERE A.AREA_NAME IN ('서울', '인천') AND G.GRADE_NAME = '일반회원';​​





