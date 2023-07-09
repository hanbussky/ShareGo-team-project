<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 ▒ ShareGo</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/initializer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor/ckeditor.js"></script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/presets.css">
<script type="text/javascript">
	function writeAction () {
		$('#art_content').val(CKEDITOR.instances['articleEditor'].getData());
		if ($('#art_title').val() == '' || $('#art_title').val() == null) {
			return false;
		}
		if ($('#art_content').val() == '' || $('#art_content').val() == null) {
			return false;
		}
		let tagIndex = 1;
		for (let i of [1, 2, 3, 4, 5]) {
			let tag = $('#tag' + i).val();
			if (tag == '' || tag == null) continue;
			$('#art_tag' + tagIndex++).val(tag);
		}
		return true;
	}
	$(() => {
		CKEDITOR.replace('articleEditor', {
			uploadUrl : '${pageContext.request.contextPath}/board/${boardName}/imageUpload',
			filebrowserUploadUrl : '${pageContext.request.contextPath}/board/${boardName}/imageUpload',
			extraPlugins : [
				'uploadimage'
			],
			removePlugins : [
				'Title', 'resize', 'elementspath', 'sourcearea',
				'cloudservices'
			],
			removeButtons : [
				'Source', 'Anchor', 'Maximize'
			],
			height: 600,
			language : "ko"
		});
	});
</script>
<style type="text/css">
	html {
		min-height: 100%;
		
	}
	body {
		
	}
	div.form-group {
		width: 100%;
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
	}
	#articleEditor {
		height: 600px;
	}
	.ck-editor__editable {
		height: 600px;
	}
	.ck-content {
		font-size: 12px;
	}
	div.input-box {
		margin: 10px 0;
		display: flex;
		justify-content: flex-start;
		align-content: center;
	}
	div.input-box > label {
		font-weight: bold;
		padding: 2.5px 5px;
		border-radius: 2.5px 0 0 2.5px;
		border-left: 5px solid var(--subtheme);
		font-size: 18px;
	}
	div.input-box > input, div.input-box > select {
		outline: none;
		border: none;
		border-bottom: 2.5px solid var(--subtheme);
		font-size: 18px;
	}
	input.art-tag {
		width: 100px;
		flex-shrink: 1;
	}
</style>
</head>
<body>
	<div class="container">
		<form id="write-form" name="write-form" action="/board/${boardName }/writeProc" method="post" enctype="multipart/form-data" accept-charset="UTF-8" onsubmit="writeAction();">
			<input type="hidden" id="brd_idLink" name="brd_idLink" value="${brd_id }">
			<div class="form-group">
				<div class="input-box">
					<label for="art_title">제목</label>
					<input type="text" style="flex-grow: 1;" id="art_title" name="art_title" placeholder="제목을 입력해주세요" required>
				</div>
				<div style="display: flex; justify-content: space-between; align-content: center;">
					<div class="input-box">
						<label for="brd_id">카테고리</label>
						<select id="brd_id" name="brd_id">
							<c:forEach var="category" items="${categories }" varStatus="i">
								<option value="${category.comm_id }" ${(brd_id == category.comm_id || (brd_id % 100 == 0 && i.last)) }>${category.comm_value }</option>
							</c:forEach>
						</select>
					</div>
					<div class="input-box" style="margin-left: 20px;">
						<input type="hidden" id="art_tag1" name="art_tag1">
						<input type="hidden" id="art_tag2" name="art_tag2">
						<input type="hidden" id="art_tag3" name="art_tag3">
						<input type="hidden" id="art_tag4" name="art_tag4">
						<input type="hidden" id="art_tag5" name="art_tag5">
						<label>태그</label>
						<span style="font-size: 16px; font-weight: bold;">#</span>
						<input class="art-tag" type="text" id="tag1" name="tag1" maxlength="10">
						<span style="font-size: 16px; font-weight: bold;">#</span>
						<input class="art-tag" type="text" id="tag2" name="tag2" maxlength="10">
						<span style="font-size: 16px; font-weight: bold;">#</span>
						<input class="art-tag" type="text" id="tag3" name="tag3" maxlength="10">
						<span style="font-size: 16px; font-weight: bold;">#</span>
						<input class="art-tag" type="text" id="tag4" name="tag4" maxlength="10">
						<span style="font-size: 16px; font-weight: bold;">#</span>
						<input class="art-tag" type="text" id="tag5" name="tag5" maxlength="10">
					</div>
				</div>
				<input type="hidden" id="art_content" name="art_content" required>
				<textarea id="articleEditor" name="articleEditor">
					
				</textarea>
				<div id="test-box">
				</div>
			</div>
			<button type="submit">등록</button>
			<button type="button" onclick="alert(CKEDITOR.instances['articleEditor'].getData());">테스트</button>
		</form>
	</div>
</body>
</html>