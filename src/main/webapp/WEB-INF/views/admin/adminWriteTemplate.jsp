<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/initializer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/quill/quill.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/quill/image-resize.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/quill/image-drop.min.js"></script>
<script type="text/javascript">
	function writeAjaxAction () {
		if ($('#art_title').val() == '' || $('#art_title').val() == null) {
			return false;
		}
		if ($('#art_content').val() == '' || $('#art_content').val() == null) {
			return false;
		}
		let tagIndex = 1;
		$('.tag-box-tag').each((index, value) => {
			let tag = $(value).find('.tag-box-tag-value').html();
			$('#art_tag' + tagIndex++).val(tag);
		});
		
		let dataObj = {};
		for (let datum of $('#write-form').serializeArray()) {
			let val = isNaN(parseInt(datum['value'])) ? datum['value'] : parseInt(datum['value']);
			dataObj[datum['name']] = val;
		}
		let sendData = JSON.stringify(dataObj);
		$.ajax({
			url: '${pageContext.request.contextPath}/admin/${type}/writeProc',
			type: 'post',
			data: sendData,
			dataType: 'json',
			contentType: "application/json",
			success: data => {
				let isDeleted = $('.admin-article-item[data-id="' + data.art_id[0] + '"]').attr('data-deleted') == 'true';
				if (isDeleted) {
					$('.admin-side-panel-view').find('.side-panel-button-delete').hide();
					$('.admin-side-panel-view').find('.side-panel-button-restore').show();
				} else {
					$('.admin-side-panel-view').find('.side-panel-button-delete').show();
					$('.admin-side-panel-view').find('.side-panel-button-restore').hide();
				}
				$.ajax({
					url: '${pageContext.request.contextPath}/admin/${type}/view',
					type: 'post',
					data: JSON.stringify({ 'art_id' : data.art_id[0] }),
					dataType: 'html',
					contentType: 'application/json',
					success: d => {
						$('.admin-side-panel > .admin-side-panel-content').html(d);
						$('.admin-side-panel-view').find('.side-panel-button-modify').attr('data-id', d.art_id)
							.end().find('.side-panel-button-delete').attr('data-id', d.art_id);
						$('.admin-side-panel-modify').find('.side-panel-button-submit').attr('data-id', d.art_id)
							.end().find('.side-panel-button-reset').attr('data-id', d.art_id);
					}
				});
			}
		});
		
		return false;
	}
</script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/writeArticleForm.js"></script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/presets.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/quill/quill.core.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/quill/quill.snow.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/writeArticleForm.css">
</head>
<div class="container" style="margin: 10px;">
	<form id="write-form" name="write-form" method="post" enctype="multipart/form-data" accept-charset="UTF-8" onsubmit="return writeAjaxAction();">
		<div class="form-group">
			<div class="input-box">
				<label for="art_title">제목</label>
				<input type="text" style="flex-grow: 1;" id="art_title" name="art_title" placeholder="제목을 입력해주세요" required>
			</div>
			<div style="display: flex; justify-content: flex-start; align-content: center;">
				<div class="input-box" style="flex-grow: 1;">
					<input type="hidden" id="art_tag1" name="art_tag1">
					<input type="hidden" id="art_tag2" name="art_tag2">
					<input type="hidden" id="art_tag3" name="art_tag3">
					<input type="hidden" id="art_tag4" name="art_tag4">
					<input type="hidden" id="art_tag5" name="art_tag5">
					<label>태그</label>
					<div class="input-box" style="border-bottom: 2.5px solid var(--subtheme); margin: 0; flex-grow: 1;" onclick="$('#tag-input').focus();">
						<div id="tag-box">
							<!-- 태그들 들어갈 자리 -->
						</div>
						<input class="art_tag" style="border-bottom: 0;" type="text" id="tag-input" name="tag-input" maxlength="10">
					</div>
				</div>
			</div>
			<c:if test="${isTradeBoard }">
				<div id="trade-info">
					<h2 style="color: var(--subtheme); margin: 10px 0;">거래 정보</h2>
					<div style="display: flex; justify-content: flex-start; align-items: center;">
						<div class="input-box" style="flex-grow: 1;">
							<label for="trd_max">최대 참가 인원</label>
							<input type="number" id="trd_max" name="trd_max" min="2" value="2" style="width: 75px; text-align: center;" required>
							<span style="font-size: 16px; font-weight: bold; margin: 0 5px;">명</span>
						</div>
						<div class="input-box" style="flex-grow: 1;">
							<label for="trd_cost">소요 비용</label>
							<input type="number" id="trd_cost" name="trd_cost" min="0" value="0" style="width: 200px; text-align: center;">
							<span style="font-size: 16px; font-weight: bold; margin: 0 5px;">원</span>
						</div>
					</div>
					<div class="input-box">
						<label for="trd_enddate">모집 종료일</label>
						<input type="datetime-local" id="trd_enddate" name="trd_enddate" style="text-align: center;">
					</div>
					<div style="display: flex; justify-content: flex-start; align-items: center;">
						<div class="input-box popup-group" style="flex-grow: 1;">
							<input type="hidden" id="reg_id" name="reg_id">
							<label for="reg_id-button">지역 제한</label>
							<button type="button" id="region" name="reg_id-button" class="togglePopup theme-button"></button>
							<div id="region-popup" class="popup-window" style="top: 32px; right: auto; left: 96.28px; padding: 0;">
								<div style="position: relative;">
									<button type="button" class="subitem-header adv-hover" onclick="$('#reg_id').removeAttr('value'); $('#region').text(''); $('#region-popup').toggle();">없음</button>
								</div>
								<c:forEach var="region" items="${superRegions }">
									<div style="position: relative;">
										<button type="button" class="subitem-header adv-hover" onclick="$('#region-value').val(${region.reg_id}); $('#region').text('${region.reg_name }'); $('#region-popup').toggle();">${region.reg_name }</button>
										<c:if test="${not empty regions[region] }">
											<div class="subitem-list">
												<button type="button" class="adv-hover" onclick="$('#reg_id').removeAttr('value'); $('#region').text(''); $('#region-popup').toggle();">없음</button>
												<c:forEach var="subRegion" items="${regions[region] }">
													<button type="button" class="adv-hover" onclick="$('#reg_id').val(${subRegion.reg_id}); $('#region').text('${subRegion.reg_name }'); $('#region-popup').toggle();">${subRegion.reg_name }</button>
												</c:forEach>
											</div>
										</c:if>
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="input-box" style="flex-grow: 1;">
							<label for="trd_loc">장소</label>
							<input type="text" id="trd_loc" name="trd_loc" style="min-width: none; max-width: none; width: auto; flex-grow: 1;">
						</div>
					</div>
					<div style="display: flex; justify-content: flex-start; align-items: center;">
						<div class="input-box" style="flex-grow: 1;">
							<label for="trd_gender">성별 제한</label>
							<select name="trd_gender" style="text-align: center;">
								<option selected>제한 없음</option>
								<option value="201">남성</option>
								<option value="202">여성</option>
							</select>
						</div>
						<div class="input-box" style="flex-grow: 1;">
							<label for="trd_minage">연령 제한</label>
							<input type="number" id="trd_minage" name="trd_minage" min="0" style="width: 50px; text-align: right;">
							<span style="font-size: 16px; font-weight: bold; margin: 0 5px;">세</span>
							<span style="font-size: 16px; font-weight: bold; margin: 0 5px;">~</span>
							<input type="number" id="trd_maxage" name="trd_maxage" min="0" style="width: 50px; text-align: right;">
							<span style="font-size: 16px; font-weight: bold; margin: 0 5px;" min="0">세</span>
						</div>
					</div>
				</div>
			</c:if>
			<input type="hidden" id="art_content" name="art_content" required>
			<div id="articleEditor">
				
			</div>
		</div>
	</form>
</div>