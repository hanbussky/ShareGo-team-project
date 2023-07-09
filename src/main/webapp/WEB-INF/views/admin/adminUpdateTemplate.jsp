<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/quill/quill.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/quill/image-resize.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/quill/image-drop.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/updateArticleForm.js"></script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/quill/quill.core.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/quill/quill.snow.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/updateArticleForm.css">
<script type="text/javascript">
	function updateNoticeAction() {
		let tagIndex = 1;
		for (let i = $('.tag-box-tag').length + 1; i <= 5; i++) $('#art_tag' + i).val(null); 
		$('.tag-box-tag').each((index, value) => {
			let tag = $(value).find('.tag-box-tag-value').html();
			$('#art_tag' + tagIndex++).val(tag);
		});
		updateAjax();
		return false;
	}
	const updateAjax = () => {
		let dataObj = {};
		let formSerializedArray = $('#update-form').serializeArray();
		for (let data of formSerializedArray) {
			dataObj[data['name']] = data['value'];
		}
		let sendData = JSON.stringify(dataObj);
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/${type}/updateProc',
			type : 'post',
			data : sendData,
			dataType: 'json',
			contentType: 'application/json',
			success : data => {
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
						$('.admin-side-panel-view').find('.side-panel-button-modify').attr('data-id', data.art_id[0]);
					}
				});
			}
		});
	}
	$(() => {
		for (let i = 1; i <= 5; i++) {
			if (!$('#art_tag' + i).val()) continue;
			let elem = '<div class="tag-box-tag"><span class="tag-box-tag-value">' + $('#art_tag' + i).val() + '</span><button class="tag-box-tag-remove adv-hover" type="button"><svg class="tag-box-tag-remove-svg" width="10" height="10" viewBox="0 0 12 12" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"><path d="M 2 2 L 10 10 M 10 2 L 2 10"/></svg></button></div>';
			$('#tag-box').append(elem);
			$('#tag-box').find('div.tag-box-tag:last-child > button.tag-box-tag-remove').click(e => {
				$(e.target).parent().remove();
			});
		}
		
		let delta = editor.clipboard.convert($('#art_content').val());
		editor.setContents(delta, 'silent');
	});
</script>
<div class="container" style="margin: 10px;">
	<form id="update-form" name="update-form" method="post" enctype="multipart/form-data" accept-charset="UTF-8" onsubmit="return updateNoticeAction();">
		<input type="hidden" id="art_id" name="art_id" value="${article.art_id }">
		<div class="form-group">
			<div class="input-box">
				<label for="art_title">제목</label>
				<input type="text" style="flex-grow: 1;" id="art_title" name="art_title" value="${article.art_title }" required>
			</div>
			<div style="display: flex; justify-content: flex-start; align-content: center;">
				<div class="input-box" style="flex-grow: 1;">
					<input type="hidden" id="art_tag1" name="art_tag1" value="${article.art_tag1 != null ? article.art_tag1 : null }">
					<input type="hidden" id="art_tag2" name="art_tag2" value="${article.art_tag2 != null ? article.art_tag2 : null }">
					<input type="hidden" id="art_tag3" name="art_tag3" value="${article.art_tag3 != null ? article.art_tag3 : null }">
					<input type="hidden" id="art_tag4" name="art_tag4" value="${article.art_tag4 != null ? article.art_tag4 : null }">
					<input type="hidden" id="art_tag5" name="art_tag5" value="${article.art_tag5 != null ? article.art_tag5 : null }">
					<label>태그</label>
					<div class="input-box" style="border-bottom: 2.5px solid var(--subtheme); margin: 0; flex-grow: 1;" onclick="$('#tag-input').focus();">
						<div id="tag-box">
							<!-- 태그들 들어갈 자리 -->
						</div>
						<input class="art_tag" style="border-bottom: 0; flex-shrink: 1;" type="text" id="tag-input" name="tag-input" maxlength="10">
					</div>
				</div>
			</div>
			<input type="hidden" id="art_content" name="art_content" value="<c:out value="${article.art_content }" escapeXml="true"/>" required>
			<div id="articleEditor">
				
			</div>
		</div>
		<button type="submit" style="display: none;"></button>
	</form>
</div>