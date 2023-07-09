<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 쓰기 폼</title>
<style>
/* 전체 레이아웃 */
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	margin: 10%;
}

.container {
	width: 80%;
	height: 90%; max-width : 800px;
	margin: 0 auto;
	background-color: #fff;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	box-sizing: border-box;
	max-width: 800px;
}

/* 제목 */
.title {
	font-size: 2rem;
	text-align: center;
	margin-bottom: 20px;
}

/* 입력 폼 간격 */
.form-group {
	margin-bottom: 20px;
}

.form-group label {
	font-size: 18px;
	font-weight: bold;
	display: block;
	margin-bottom: 5px;
}

.form-group #title, .form-group textarea {
	width: 100%;
	padding: 10px;
	font-size: 18px;
	box-sizing: border-box;
}

input[type="text"],[type="number"], textarea{
	display: inline-block;
	height: 30px;
	width: 80px;
	font-size: 14px;
	color: #495057;
	background-color: #fff;
	border: 1px solid #ced4da;
	border-radius: 8px;
	transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
	margin-right: 10px;
}

input:focus, textarea:focus {
	outline: 0;
	box-shadow: 0 0 0 2px rgba(0, 123, 255, .25);
}
/* 내용 크기 */
.form-group textarea {
	height: 200px;
	resize: none;
}

/* 버튼 */
.button-group {
	text-align: center;
	margin-top: 20px;
}

.button-group input[type="submit"], .button-group input[type="button"] {
	background-color: #007bff;
	border: none;
	color: #fff;
	font-size: 1.2rem;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
}


/* 작성 버튼 스타일 */
.submit-button {
	background-color: #4CAF50;
	color: #fff;
	border: none;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin-right: 10px;
	border-radius: 4px;
	cursor: pointer;
}

/* 작성 버튼 호버 효과 */
.submit-button:hover {
	background-color: #3e8e41;
}

/* 취소 버튼 스타일 */
.cancel-button {
	background-color: #f44336;
	color: #fff;
	border: none;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	border-radius: 4px;
	cursor: pointer;
}

/* 취소 버튼 호버 효과 */
.cancel-button:hover {
	background-color: #da190b;
}
</style>


</head>
<body>
	<div class="container">
		<h2 class="title">게시글 작성</h2>
		<form method="post" action="/write">


			<div class="form-group">
				<label for="tag">태그</label>
				<input type="text" id="tag1" name="tag" placeholder="태그를 입력하세요">
				<input type="text" id="tag2" name="tag" placeholder="태그를 입력하세요">
				<input type="text"
					id="tag3" name="tag" placeholder="태그를 입력하세요"> <input
					type="text" id="tag4" name="tag" placeholder="태그를 입력하세요"> <input
					type="text" id="tag5" name="tag" placeholder="태그를 입력하세요">
			</div>


			<div class="form-group">
				<label for="location-limit">지역 제한</label> <select
					id="location-limit" name="location-limit">
					<option value="all">전체</option>
					<option value="seoul">서울</option>
					<option value="busan">부산</option>
					<option value="incheon">인천</option>
					<option value="daegu">대구</option>
					<option value="gwangju">광주</option>
					<option value="daejeon">대전</option>
					<option value="ulsan">울산</option>
				</select>
			</div>

			<div class="form-group">
				<label for="deal-location">거래 지역</label> <input type="text"
					id="deal-location" name="deal-location" placeholder="거래 지역을 입력하세요">
			</div>

			<div class="form-group">
				<label for="max-people">최대 인원</label> <input type="number"
					id="max-people" name="max-people" placeholder="최대 인원을 입력하세요">
			</div>

			<div class="form-group">
				<label for="deadline">마감일</label> <input type="date" id="deadline"
					name="deadline">
			</div>

			<div class="form-group checkbox-group">
				<label>성별 제한</label> <input type="checkbox" id="male"
					name="gender-limit" value="male"> <label for="male">남성</label>
				<input type="checkbox" id="female" name="gender-limit"
					value="female"> <label for="female">여성</label>
			</div>

			<div class="form-group">
				<label for="min-age">최소 나이</label> <input type="number" id="min-age"
					name="min-age" placeholder="최소 나이를 입력하세요">
			</div>
			<div class="form-group checkbox-group">
				<label>공지 여부</label> <input type="checkbox" id="notice"
					name="notice" value="true"> <label for="notice">공지</label>
			</div>

			<div class="button-group">
				<button type="submit" class="submit-button">작성</button>
				<button type="button" class="cancel-button">취소</button>
			</div>
		</form>
	</div>
</body>
</html>