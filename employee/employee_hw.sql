-- <JOIN 미사용 연습문제>
-- 1. 모든 사원 모든 컬럼 조회
SELECT 
			*
	FROM employee;
  
-- 2. 사원들의 사번(사원번호), 이름 조회
SELECT
			EMP_ID
		,	EMP_NAME
	FROM employee;
  
-- 3. 201번 사번의 사번 및 이름 조회
SELECT
			EMP_ID
		,	EMP_NAME
	FROM employee
	WHERE EMP_ID = 201;
 
-- 4. employee 테이블에서 부서 코드가 'D9'인 사원 조회
SELECT 
			*
	FROM employee
	WHERE	DEPT_CODE = 'D9';

 
-- 5. employee 테이블에서 직급 코드가 'J1'인 사원 조회
SELECT 
			*
	FROM employee
	WHERE JOB_CODE = 'J1';

 
-- 6. employee 테이블에서 급여가 300만원 이상(>=)인 사원의
-- 사번, 이름, 부서코드, 급여를 조회하시오.
SELECT
			EMP_ID
		,	EMP_NAME
		,	DEPT_CODE
		,	SALARY
	FROM employee
	WHERE SALARY >= 3000000;


-- 7. 부서코드가 'D6'이고 급여를 300만원보다 많이 받는
-- 직원의 이름, 부서코드, 급여 조회
SELECT 
			EMP_NAME
	,		DEPT_CODE
	,		SALARY
	FROM employee
	WHERE DEPT_CODE = 'D6' AND SALARY >= 3000000;


-- 8. 보너스를 받지 않는 사원에 대한
-- 사번, 직원명, 급여, 보너스를 조회
SELECT 
			EMP_ID
	,		EMP_NAME
	,		SALARY
	,		BONUS
	FROM employee
	WHERE BONUS IS NULL;

 
-- 9. 'D9' 부서에서 근무하지 않는 사원의
-- 사번, 이름, 부서코드를 조회
SELECT 
			EMP_ID
	,		EMP_NAME
	,		DEPT_CODE
	FROM employee
	WHERE DEPT_CODE != 'D9';

 
-- 10. employee 테이블에서 퇴사 여부가 N인 직원들 조회하고
-- 사번, 이름, 입사일을 별칭을 사용해 조회해 보기
-- (퇴사 여부 컬럼은 ENT_YN이고 N은 퇴사 안한 사람, Y는 퇴사 한 사람)
SELECT 
			a.EMP_ID
	,		a.EMP_NAME
	,		a.HIRE_DATE
	FROM employee a
	WHERE ENT_YN = 'N';


-- 11. employee 테이블에서 급여 350만원 이상
-- 550만원 이하를 받는 직원의
-- 사번, 이름, 급여, 부서코드, 직급코드를 별칭을 사용해 조회해 보기
SELECT 
			emp_id
	,		emp_name
	,		salary
	,		dept_code
	,		job_code
	FROM employee
	WHERE salary BETWEEN 3500000 AND 5500000;
 
-- 12. employee 테이블에서 '성이 김씨'인 직원의 사번, 이름, 입사일 조회
SELECT 
			emp_id
	,		emp_name
	,		hire_date
	FROM employee
	WHERE emp_name LIKE '김%';
 
-- 13. employee 테이블에서 '성이 김씨'가 아닌 직원의 사번, 이름, 입사일 조회
SELECT 
			emp_id
	,		emp_name
	,		hire_date
	FROM employee
	WHERE NOT emp_name LIKE '김%';


-- 14. EMPLOYEE 테이블에서 '하'문자가 이름에 포함 된
-- 직원의 이름, 주민번호, 부서코드 조회
SELECT
			emp_name
	,		emp_no
	,		dept_code
	FROM employee
	WHERE emp_name LIKE '%하%';
 
-- 15. 'J2'직급이면서 급여가 200만원 이상인 직원이거나
-- 'J7'직급인 직원의 이름, 급여, 직급코드 조회
SELECT 
			emp_name
	,		salary
	,		job_code
	FROM employee
	WHERE job_code = 'J2' 
	AND salary >= 2000000 
	OR job_code = 'J7';
 
-- 16. 'J2'직급이거나 'J7'직급인 직원들 중에
-- 급여가 200만원 이상인 직원의 이름, 급여, 직급코드 조회
SELECT 
			emp_name
	,		salary
	,		job_code
	FROM employee
	WHERE (job_code = 'J2' OR job_code = 'J7')
	AND salary >= 2000000;

-- 17. IN 연산자로 업그레이드
SELECT 
			emp_name
	,		salary
	,		job_code
	FROM employee
	WHERE job_code IN ('J2', 'J7')
	AND salary >= 2000000;

-- ------------------------------------------
-- <JOIN 사용 연습문제>              

-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1명)
SELECT 
			a.emp_ID
	,		a.emp_name
	,		b.DEPT_TITLE
	FROM employee a
	JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
	WHERE a.emp_name LIKE '%형%';



-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9명)
SELECT 
			a.emp_name
	,		a.job_code
	,		a.DEPT_CODE
	,		b.DEPT_TITLE
	FROM employee a
	JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
	WHERE b.DEPT_TITLE LIKE '해외영업%';

-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8명)(INNER JOIN 결과)
SELECT
			a.EMP_NAME
	,		a.BONUS
	,		b.DEPT_TITLE
	,		b.LOCATION_ID
	FROM employee a
	JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
	WHERE a.Bonus IS NOT NULL;


-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3명)
SELECT 
			a.EMP_NAME
	,		a.BONUS
	,		b.DEPT_TITLE
	,		e.LOCAL_NAME
	FROM employee a
	JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
	JOIN location e ON (b.LOCATION_ID = e.LOCAL_CODE)
	WHERE a.DEPT_CODE = 'D2';

-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20명)


SELECT 
			a.EMP_NAME
	,		c.job_NAME
	,		a.salary '급여'
	,		12 * a.salary * (1+a.BONUS) '연봉'
	FROM employee a
	JOIN job c ON (a.JOB_CODE = c.JOB_CODE)
	JOIN sal_grade d ON (a.SAL_LEVEL = d.SAL_LEVEL)
	WHERE d.min_sal < a.salary;
 
-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의 
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15명)
SELECT
			a.EMP_NAME
	,		b.DEPT_TITLE
	,		b.LOCATION_ID
	,		f.national_name
	FROM employee a
	JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
	JOIN location e ON (b.location_ID = e.LOCAL_CODE)
	JOIN national f ON (E.NATIONAL_CODE = f.NATIONAL_CODE)
	WHERE e.national_code IN ('KO', 'JP');


-- 7. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
-- self join 사용(60명)
SELECT 
			a.emp_name
	,		a.dept_code
	,		b.emp_name
	FROM employee a
	JOIN employee b ON (a.DEPT_CODE = b.DEPT_CODE)
	WHERE a.DEPT_CODE = b.dept_code
	AND NOT a.EMP_NAME = b.emp_name;
	

-- 8. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8명)
SELECT 
			a.emp_name
	,		c.JOB_NAME
	,		a.salary
	FROM employee a
	JOIN job c ON (a.JOB_CODE = c.job_code)
	WHERE a.BONUS IS NULL
	AND a.job_code IN ('J4', 'J7');


-- 9. 직급이 대리('J6')이면서 아시아 지역(ASIA1(L1), ASIA2(L2), ASIA3(L3) 모두 해당)에 근무하는 직원 조회
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오
-- (해당 컬럼을 찾고, 해당 컬럼을 지닌 테이블들을 찾고, 테이블들을 어떤 순서로 조인해야 하는지 고민하고 SQL문을 작성할 것)
SELECT * FROM employee a;
SELECT * FROM department b;
SELECT * FROM job c; 
SELECT * FROM sal_grade d;
SELECT * FROM location e;
SELECT * FROM national f;

SELECT 
			a.EMP_ID
	,		a.EMP_NAME
	,		c.JOB_NAME
	,		b.DEPT_TITLE
	,		e.LOCAL_NAME
	,		a.SALARY
	FROM employee a
	JOIN job c ON (a.job_code = c.JOB_CODE)
	JOIN department b ON (a.dept_code = b.DEPT_ID)
	JOIN location e ON (b.LOCATION_ID = e.LOCAL_CODE)
	WHERE a.job_code = 'J6'
-- 	AND e.LOCAL_NAME LIKE 'ASIA%';
-- 	AND b.LOCATION_ID IN ('L1','L2','L3');



-- 연봉 
-- 1. 보너스 없을 때, 급여(salary) * 12
-- 2. 보너스 받을 때, 급여(salary) * 12 + (급여 * 보너스) * 12 = 12*급여*(1+보너스)