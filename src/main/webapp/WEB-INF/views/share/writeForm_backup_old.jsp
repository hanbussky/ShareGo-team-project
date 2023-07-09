<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/share/writeForm.css">
<script type="text/javascript">
	
	// 첫번째 select박스 선택시 실행
	function firstSelect(){
		let locSelect = $('#location-firstSelect').val();
		console.log(locSelect);
		
		$.ajax({
			url:'${pageContext.request.contextPath}/board/share/selectRegion',
			data:{'reg_id':locSelect},
			success: function(data){
				console.log(data);
				
				let options = '';
				for(let i=0; i<data.length; i++){
					options += '<option value="'+data[i].reg_id+'">'+data[i].reg_name+'</option>';
				}
				// 지역 소분류의 옵션을 추가하고, name 속성 부여
				$('#location-secondSelect').append(options);
			}
		});
	}
	
	// 두번째 select박스 선택시
	function secondSelect(){
		// 지역 대분류의  name 속성 제거 소분류 name 추가
		$('#location-firstSelect').removeAttr('name');
		$('#location-secondSelect').attr('name', 'trade.reg_id');
	}
	// checkbox 이벤트
	$(document).ready(()=>{
		$('#btns-checkbox').change(()=>{
			if($('#btns-checkbox').is(':checked')){
				$('#art_isnotice').val('1');
			}else{
				$('#art_isnotice').val('0');
			}
			console.info($('#art_isnotice').val());
		});
	});
</script>
</head>
<body>
	<div class="container">

		<h1>글쓰기</h1>

		<div>
			<form action="${pageContext.request.contextPath}/board/share/writeArticleForm" method="post">
				<input type="hidden" 	name="category" 		value="${category}">
				<input type="hidden" 	name="brd_id" 			value="${category}">
			<!-- 임시 기본값 저장 -->
				<input type="hidden" 	name="trade.trd_status" value="401">
				<input type="hidden" 	name="trade.trd_cost" 	value="0">
				<input type="hidden" 	name="art_good" 		value="0">
				<input type="hidden" 	name="art_bad" 			value="0">
				<input type="hidden" 	name="art_read" 		value="0">
				<input type="hidden" 	name="isdelete" 		value="0">
				
				
				<div class="form-group">
					<label for="category">카테고리</label>
					<select name="brd_id" id="brd_id">
						<option value="1210" ${category == 1210? 'selected':''}>식품</option>
						<option value="1220" ${category == 1220? 'selected':''}>패션/잡화</option>
						<option value="1230" ${category == 1230? 'selected':''}>가전/가구</option>
						<option value="1240" ${category == 1240? 'selected':''}>기타</option>
					</select>
				</div>

				<div class="form-group">
					<label for="article-title">제목</label>
					<input type="text" id="article-title" name="art_title" placeholder="제목" required="required">
				</div>
				<div class="form-group">
					<label for="article-content">내용</label>
					<textarea id="article-content" name="art_content" placeholder="내용을 입력하세요" required="required"></textarea>
				</div>

				<div class="form-group">
					<label for="tag">태그</label>
					<input type="text" 	name="art_tag1" value="태그1" placeholder="입력">
					<input type="text" 	name="art_tag2" value="태그2" placeholder="입력">
					<input type="text" 	name="art_tag3" value="태그3" placeholder="입력">
					<input type="text" 	name="art_tag4" value="태그4" placeholder="입력">
					<input type="text" 	name="art_tag5" value="태그5" placeholder="입력">
				</div>
				
				<div class="form-group" style="display: flex;">
					<!-- 대분류 -->
					<div class="form-location">
						<label for="location-limit">지역제한</label>
						<select id="location-firstSelect" name="trade.reg_id" onchange="firstSelect()">
							<option value="">지역 선택</option>
							<c:forEach var="region" items="${regionList}">
								<option id="region-parent" value="${region.reg_id}">${region.reg_name}</option>
							</c:forEach>
						</select>
						
						<!-- 소분류 -->
						<select id="location-secondSelect" onchange="secondSelect()">
							<option value="">선택</option>
						</select>
					</div>
					<!-- 상세 지역 -->
					<div class="form-locationDetail">
						<label for="deal-location">거래 지역</label>
						<input type="text" name="trade.trd_loc" value="이대" required="required">
					</div>
				</div>

				<div class="form-group">
					<label for="max-people">최대 인원</label>
					<input type="number" name="trade.trd_max" min="1" max="9" value="2" required="required">
				</div>

				<div class="form-group">
					<label for="deadline">마감일</label>
					<input type="date" name="trd_endDate" required="required">
				</div>

				<div class="form-group" style="display: flex;">
					<div class="form-gender">
						<label for="gender-limit">성별</label>
						<select name="trade.trd_gender">
							<option value="">제한 없음</option>
							<option value="201">남자</option>
							<option value="202">여자</option>
						</select>
					</div>

					<div class="form-age">
						<label for="age-limit">나이</label> 
						<input type="number" name="trade.trd_minage" min="1" max="100" value="10">
						<input type="number" name="trade.trd_maxage" min="1" max="100" value="30">
					</div>
				</div>

				<!-- 매니저 이상의 권한만 공지 설정 가능 -->
				<c:if test="${memberInfo.mem_authority >= 108}">
					<div class="form-group checkbox-group">
						<label for="notice">공지 여부</label> 
						<input type="hidden" id="art_isnotice" name="art_isnotice" value="0">
						<input type="checkbox" id="btns-checkbox">
					</div>
				</c:if>

				<div class="button-group">
					<button type="submit" class="btns-submit">작성</button>
					<button type="button" class="btns-cancel" onclick="location.href='${pageContext.request.contextPath}/board/share?category='+${category};">취소</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>