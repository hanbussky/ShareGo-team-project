<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${article.art_title } - ${boardScope } 게시판${currentPage != null ? ' ' + currentPage + ' 페이지' : ' 1 페이지' } ▒ ShareGo</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/initializer.js"></script>
<script type="text/javascript">
	// 댓글 읽어오기
	const getReplyList = (art_id, brd_id) => {
		let dataObj = {};
		dataObj["art_id"] = art_id;
		dataObj["brd_id"] = brd_id;
		let sendData = JSON.stringify(dataObj);
		$.ajax({
			url: '${pageContext.request.contextPath}/board/${boardName}/${article.art_id}/replies',
			type: 'post',
			data: sendData,
			dataType: 'html',
			contentType: 'application/json',
			traditional: true,
			success: data => {
				$('#reply-section').html(data);
			}
		});
	};
	
	// 댓글 쓰기
	function replyToAjax(elem) {
		let content = $(elem).find('textarea').val();
		if (!(!content) || content != null || content != '') ajaxForReply(elem);
		return false;
	}
	const ajaxForReply = (elem) => {
		let formData = $(elem).serializeArray();
		let dataObject = {};
		for (let datum of formData) {
			let temp = parseInt(datum.value);
			if (isNaN(temp)) temp = datum.value;
			dataObject[datum.name] = temp;
		}
		let sendData = JSON.stringify(dataObject);
		$.ajax({
			url: '${pageContext.request.contextPath}/board/${boardName}/${article.art_id}/replyWrite',
			type: 'post',
			data: sendData,
			dataType: 'json',
			contentType: 'application/json',
			success: data => {
				if (data.result == 0) alert('댓글 등록에 실패했습니다');
				getReplyList(${article.art_id}, ${article.brd_id});
				$(elem).find('textarea[name="rep_content"]').val('');
			}
		});
	};
	
	// 추천 및 비추천 기능
	const recommend = (art_id, brd_id, isGood, target) => {
		let dataObj = {};
		dataObj["art_id"] = art_id;
		dataObj["brd_id"] = brd_id;
		dataObj["isGood"] = isGood;
		let sendData = JSON.stringify(dataObj);
		$.ajax({
			url: '${pageContext.request.contextPath}/board/${boardName}/${article.art_id}/recommend',
			type: 'post',
			data: sendData,
			dataType: 'json',
			contentType: 'application/json',
			success: data => {
				if (data.result == 0) {
					if (isGood) alert('이미 추천하셨습니다');
					else alert('이미 비추천하셨습니다');
				} else if (data.result >= 1) {
					$(target).find('.art-recommend-value').text(data.value);
				} else {
					if (isGood) alert('로그인 후 추천할 수 있습니다');
					else alert('로그인 후 비추천할 수 있습니다');
				}
			}
		});
	}
	
	$(() => {
		getReplyList(${article.art_id}, ${article.brd_id});
		// 페이지 로딩이 되면 댓글 목록을 모두 불러온다
	});
</script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/presets.css">
<!-- ignoring Style -->
<style type="text/css">
	/* Buttons */
	button.theme-button {
		background-color: var(--theme);
		color: var(--theme-font);
		font-weight: bold;
		padding: 0;
		border-radius: 5px;
		outline: none;
		border: 2px solid var(--subtheme);
		cursor: pointer;
	}
	button.subtheme-button {
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		font-weight: bold;
		padding: 0;
		border-radius: 5px;
		outline: none;
		border: 0;
		cursor: pointer;
	}
</style>
<style type="text/css">
	html {
		width: 100%;
		min-height: 100%;
	}
	div.container {
		width: 100%;
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
		background-color: var(--theme);
	}
	div#art_title {
		display: flex;
		justify-content: flex-start;
		align-items: center;
		border: 2px solid var(--subtheme);
		border-left: 0;
		border-right: 0;
	}
	div#art_title > span {
		margin: 5px 10px;
		font-size: 24px;
		font-weight: bold;
	}
	div#art_info {
		display: flex;
		justify-content: space-between;
		align-items: center;
		border-bottom: 1px solid var(--subtheme);
	}
	div#art_info > div#art_tags {
		display: flex;
		justify-content: flex-start;
		align-items: center;
		margin: 5px 10px;
	}
	div#art_info > div#art_tags > span {
		font-size: 14px;
		font-weight: bold;
		color: var(--subtheme);
	}
	div#art_info > div#art_tags > span:not(:last-child) {
		margin-right: 10px;
	}
	div#art_info > div#art_misc {
		display: flex;
		justify-content: flex-end;
		align-items: center;
		margin: 5px 10px;
	}
	div#art_info > div#art_misc > span {
		font-size: 14px;
		font-weight: bold;
	}
	div#art_info > div#art_misc > span:not(:last-child) {
		margin-right: 10px;
	}
	div#art_content {
		padding: 5px 10px;
	}
	div#art_recommend {
		display: flex;
		margin: 0 auto;
	}
	div#art_recommend > button {
		margin: 0 10px;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		padding: 0;
		width: 75px;
		user-select: none;
	}
	div#art_recommend > button * {
		pointer-events: none;
	}
	div#art_recommend > button > div {
		width: 100%;
		padding: 2.5px 0;
		border-bottom: 1px solid rgba(var(--subtheme-rgb), 0.5);
	}
	div#art_recommend > button > span {
		width: 100%;
		padding: 5px 0;
	}
	div#art_writer {
		padding: 5px 10px;
		border-bottom: 2px solid var(--subtheme);
	}
</style>
</head>
<body>
	<div class="container">
		<div style="height: 100px; display: flex; justify-content: flex-start; align-items: center; border: 2px solid var(--subtheme); border-radius: 10px; margin-bottom: 10px; padding: 0 10px">
			<span style="font-size: 32px; font-weight: bold; color: var(--subtheme);">${boardScope }</span>
		</div>
		<div id="art_data" style="display: flex; justify-content: flex-end; align-items: center;">
			<c:if test="${memberInfo.mem_id == article.mem_id }">
				<button class="theme-button adv-hover" style="margin: 5px; padding: 2.5px 5px; font-size: 12px;" type="button">수정</button>
				<button class="theme-button adv-hover" style="margin: 5px; padding: 2.5px 5px; font-size: 12px;" type="button">삭제</button>
			</c:if>
			<button class="subtheme-button adv-hover" style="margin: 5px; padding: 4.5px 7px; font-size: 12px;" type="button">목록</button>
		</div>
		<div id="art_title">
			<c:if test="${board != null }">
				<span style="font-size: 14px; font-weight: bold; padding: 2.5px 5px; border-radius: 5px; border: 0; background-color: var(--subtheme); color: var(--subtheme-font);">${board }</span>
			</c:if>
			<span>${article.art_title }</span>
		</div>
		<div id="art_info">
			<div id="art_tags">
				<c:forEach var="loop" begin="1" end="5">
					<c:set var="indexer" value="art_tag${loop }"/>
					<c:if test="${article[indexer] != null }">
						<span>#${article[indexer] }</span>
					</c:if>
				</c:forEach>
			</div>
			<div id="art_misc" style="display: flex; justify-content: flex-end; align-items: center;">
				<span>
					댓글 수: ${article.rep_count }
				</span>
				<span>
					작성일자:
					<fmt:formatDate value="${article.art_regdate }" pattern="yyyy/MM/dd HH:mm:ss"/>
				</span>
				<span>
					조회수: ${article.art_read }
				</span>
			</div>
		</div>
		<div id="art_share" style="display: flex; justify-content: flex-end; align-items: center; padding: 2.5px 10px;">
			<svg viewBox="0 0 512 512" style="width: 20px; height: 20px; fill: none; stroke: var(--subtheme); stroke-width: 32px; stroke-linecap: round; stroke-linejoin: round;">
				<circle cx="128" cy="256" r="48" style="fill: var(--subtheme);"/>
				<circle cx="384" cy="112" r="48" style="fill: var(--subtheme);"/>
				<circle cx="384" cy="400" r="48" style="fill: var(--subtheme);"/>
				<path d="M169.83 279.53l172.34 96.94M342.17 135.53l-172.34 96.94"/>
			</svg>
			<span style="font-size: 10px; font-weight: bold; color: var(--subtheme);">
				<a href="${pageContext.request.contextPath }/board/${boardName }/${article.art_id }?brd_id=${article.brd_id }">
					${baseUrl }/board/${boardName }/${article.art_id }?brd_id=${article.brd_id }
				</a>
			</span>
		</div>
		<div id="art_content">
			${article.art_content }
		</div>
		<div id="art_recommend">
			<button type="button" class="theme-button adv-hover" onclick="recommend(${article.art_id}, ${article.brd_id }, true, this);">
				<div style="display: flex; justify-content: space-evenly; align-items: center;">
					<svg viewBox="596.9167 0.0194 1565.0834 1639.8086" style="fill: var(--theme-font); width: 12px; height: 12px; margin: 0 5px;">
						<!-- https://freesvg.org/thumbs-up-silhouette -->
						<path d="M1520.5629,60.7246c9.2529,0,22.9001-2.2927,31.0228,1.2784c4.0228,1.7685,10.0901,1.592,14.4762,2.7188 c5.8456,1.5018,11.6852,2.95,17.423,4.8376c19.8309,6.524,38.4539,17.5962,54.3069,31.1189 c15.4873,13.2107,28.811,28.8823,38.5651,46.7913c10.3126,18.9348,15.6564,39.2017,20.9418,59.9346 c5.438,21.3307,6.3975,44.4503,6.5536,66.3782c0.1575,22.0935-1.3568,45.1182-6.2789,66.6433 c-4.7166,20.626-9.5502,40.6268-17.2726,60.4215c-8.1235,20.8223-19.2517,40.6216-29.2167,60.5945 c-9.6312,19.3036-18.8459,38.775-28.1715,58.2219c-9.0332,18.8382-17.9552,38.7832-24.1283,58.7702 c-6.0906,19.7205-11.4923,40.3191-10.5479,61.155c0.3005,6.6298,1.0413,21.0134,7.0928,25.2928 c3.0446,2.1529,8.7776,0.9438,12.2129,0.8727c6.3768-0.1321,12.7501-0.3911,19.1221-0.6643 c46.1556-1.9804,92.4683-1.7981,138.6613-1.7421c45.6135,0.0554,91.168,0.327,136.7052,3.2466 c22.5062,1.4431,45.473,2.3863,67.7657,5.9072c20.1079,3.1758,39.5485,8.5963,55.7,21.558 c15.6963,12.5963,29.2531,29.2695,40.9388,45.5461c11.8752,16.5402,23.2302,34.9225,30.1526,54.1568 c3.2183,8.9421,6.8928,18.6378,7.8779,28.1332c1.1016,10.6202-0.9648,19.2577-6.2202,28.4807 c-10.1318,17.7805-24.4211,32.9326-35.489,50.126c-5.583,8.6729-9.6936,17.2821-8.1272,27.8564 c1.5747,10.6291,6.9783,20.636,12.1709,29.8923c9.8293,17.5203,21.5195,34.1235,30.4695,52.1269 c4.1145,8.2762,7.9856,17.6038,7.1602,27.0314c-0.873,9.9706-6.8962,18.98-12.7485,26.7786 c-12.3955,16.5182-27.3953,30.9061-39.7224,47.4825c-5.7537,7.7368-11.4421,16.1678-11.7715,26.1475 c-0.349,10.5802,2.4435,20.917,6.0121,30.7833c7.3593,20.3463,17.4034,40.3459,23.2218,61.1707 c6.0962,21.8181-0.4746,39.7147-13.5889,57.3821c-12.5927,16.9652-28.8911,30.9794-43.8359,45.7869 c-14.4075,14.2753-27.1533,28.6671-27.001,50.0262c0.078,10.9647,0.1594,21.9293,0.2654,32.8938 c0.1068,11.0503,1.4434,22.9386-1.6632,33.6997c-5.4886,19.0134-21.4039,36.1284-34.7365,50.1152 c-14.4594,15.1687-30.6368,28.7886-47.7722,40.8331c-17.229,12.1102-34.8148,20.5139-55.1942,25.6375 c-20.9213,5.2599-42.9412,7.8329-64.4313,9.6827c-90.5679,7.7957-181.6688,2.4065-272.3201-0.8159 c-44.7479-1.5908-89.6749-4.4669-134.2426-8.8455c-10.2728-1.0093-20.5367-1.4325-30.8199-2.1771 c-10.1438-0.7345-20.5139-3.3689-30.5206-5.2036
								 c-21.0529-3.8597-42.129-7.6986-63.1381-11.7871 c-42.7938-8.328-85.7592-15.8619-128.62-23.8524c-21.6165-4.0298-43.25-7.9535-64.874-11.9396 c-10.5157-1.9385-21.0328-3.881-31.521-5.9642c-3.2131-0.6381-6.5777-1.077-7.1765-4.8949 c-0.9216-5.8757-0.113-12.4637-0.1102-18.4089c0.0895-185.7694,0.0862-371.5388,0.087-557.3082 c0.0001-11.146,0.0001-22.2924,0.0002-33.4384c0-2.7115-0.8728-7.2691,0.6964-9.6804c1.8351-2.8201,9.785-1.3683,12.4819-1.3834 c9.8492-0.0552,19.8955,0.8073,29.6094-1.1854c9.9312-2.0372,19.0519-6.6622,27.5282-12.1067 c34.0913-21.8972,59.651-57.7686,81.01-91.4886c23.2795-36.7521,43.9276-75.4404,62.1334-114.9429 c18.3373-39.788,34.3848-80.5327,51.8765-120.6971c17.0248-39.0923,48.2561-65.2728,80.8578-91.2554 c16.4827-13.1361,32.6666-26.548,46.3193-42.7003c13.8022-16.3293,24.9845-34.8267,33.7615-54.2959 c18.1166-40.1859,30.1417-84.3115,36.2227-127.9681c6.2136-44.6116,12.6005-89.2005,14.9655-134.2462 c0.3915-7.4563,1.6073-14.5817,7.3704-19.8748c2.4473-2.2476,5.3876-3.8947,8.4872-5.0599 C1513.9449,63.4004,1519.2778,63.2971,1520.5629,60.7246C1530.4342,60.7246,1519.7723,62.3071,1520.5629,60.7246z M654.1641,898.2689c0,113.5108,0,227.0218,0,340.5325c0,46.5209,0,93.0417,0,139.5626c0,23.2604,0,46.5209,0,69.7813 c0,12.0956,0,24.1909,0,36.2863c0,5.5826,0,11.165,0,16.7476c2.9518,0.6001,3.0689,7.4297,3.9023,9.6901 c5.8673,15.9106,20.7537,29.5836,36.6451,35.1024c9.34,3.2439,18.8117,3.2965,28.5798,3.3029 c11.0439,0.0074,22.0878,0.012,33.1318,0.0145c46.0164,0.0112,92.0328-0.0095,138.0493,0.0101 c19.0814,0.0082,36.9496-6.9194,49.56-21.6554c13.4414-15.7072,14.5669-34.699,14.5618-54.4558 c-0.012-46.6202-0.0196-93.2406-0.025-139.8608c-0.0109-93.2407-0.0132-186.4812-0.0248-279.7219 c-0.0057-46.3734,1.1533-92.9179-0.0865-139.2733c-0.5342-19.9727-7.4376-38.3519-23.3443-51.1132 c-15.4163-12.3679-33.5844-13.338-52.5065-13.3804c-46.3998-0.1041-92.7999-0.1375-139.1995-0.0057 c-20.9935,0.0595-42.7304-1.9652-61.1382,10.0648c-7.4174,4.8474-13.9482,11.0446-18.7111,18.5484 c-2.1867,3.4451-3.9904,7.1271-5.4059,10.9533C657.395,891.446,656.8574,897.8079,654.1641,898.2689 C654.1641,1099.2389,655.7422,897.9987,654.1641,898.2689z"/>
					</svg>
					<span style="font-size: 12px; font-weight: bold;">추천</span>
				</div>
				<span class="art-recommend-value" style="font-size: 16px; font-weight: bold;">${article.art_good }</span>
			</button>
			<button type="button" class="theme-button adv-hover" onclick="recommend(${article.art_id}, ${article.brd_id }, false, this);">
				<div style="display: flex; justify-content: space-evenly; align-items: center;">
					<svg viewBox="596.9167 0.0194 1565.0834 1639.8086" style="fill: var(--theme-font); width: 12px; height: 12px; transform: rotate(180deg); transform-origin: 50% 50%; margin: 0 5px;">
						<!-- https://freesvg.org/thumbs-up-silhouette -->
						<path d="M1520.5629,60.7246c9.2529,0,22.9001-2.2927,31.0228,1.2784c4.0228,1.7685,10.0901,1.592,14.4762,2.7188 c5.8456,1.5018,11.6852,2.95,17.423,4.8376c19.8309,6.524,38.4539,17.5962,54.3069,31.1189 c15.4873,13.2107,28.811,28.8823,38.5651,46.7913c10.3126,18.9348,15.6564,39.2017,20.9418,59.9346 c5.438,21.3307,6.3975,44.4503,6.5536,66.3782c0.1575,22.0935-1.3568,45.1182-6.2789,66.6433 c-4.7166,20.626-9.5502,40.6268-17.2726,60.4215c-8.1235,20.8223-19.2517,40.6216-29.2167,60.5945 c-9.6312,19.3036-18.8459,38.775-28.1715,58.2219c-9.0332,18.8382-17.9552,38.7832-24.1283,58.7702 c-6.0906,19.7205-11.4923,40.3191-10.5479,61.155c0.3005,6.6298,1.0413,21.0134,7.0928,25.2928 c3.0446,2.1529,8.7776,0.9438,12.2129,0.8727c6.3768-0.1321,12.7501-0.3911,19.1221-0.6643 c46.1556-1.9804,92.4683-1.7981,138.6613-1.7421c45.6135,0.0554,91.168,0.327,136.7052,3.2466 c22.5062,1.4431,45.473,2.3863,67.7657,5.9072c20.1079,3.1758,39.5485,8.5963,55.7,21.558 c15.6963,12.5963,29.2531,29.2695,40.9388,45.5461c11.8752,16.5402,23.2302,34.9225,30.1526,54.1568 c3.2183,8.9421,6.8928,18.6378,7.8779,28.1332c1.1016,10.6202-0.9648,19.2577-6.2202,28.4807 c-10.1318,17.7805-24.4211,32.9326-35.489,50.126c-5.583,8.6729-9.6936,17.2821-8.1272,27.8564 c1.5747,10.6291,6.9783,20.636,12.1709,29.8923c9.8293,17.5203,21.5195,34.1235,30.4695,52.1269 c4.1145,8.2762,7.9856,17.6038,7.1602,27.0314c-0.873,9.9706-6.8962,18.98-12.7485,26.7786 c-12.3955,16.5182-27.3953,30.9061-39.7224,47.4825c-5.7537,7.7368-11.4421,16.1678-11.7715,26.1475 c-0.349,10.5802,2.4435,20.917,6.0121,30.7833c7.3593,20.3463,17.4034,40.3459,23.2218,61.1707 c6.0962,21.8181-0.4746,39.7147-13.5889,57.3821c-12.5927,16.9652-28.8911,30.9794-43.8359,45.7869 c-14.4075,14.2753-27.1533,28.6671-27.001,50.0262c0.078,10.9647,0.1594,21.9293,0.2654,32.8938 c0.1068,11.0503,1.4434,22.9386-1.6632,33.6997c-5.4886,19.0134-21.4039,36.1284-34.7365,50.1152 c-14.4594,15.1687-30.6368,28.7886-47.7722,40.8331c-17.229,12.1102-34.8148,20.5139-55.1942,25.6375 c-20.9213,5.2599-42.9412,7.8329-64.4313,9.6827c-90.5679,7.7957-181.6688,2.4065-272.3201-0.8159 c-44.7479-1.5908-89.6749-4.4669-134.2426-8.8455c-10.2728-1.0093-20.5367-1.4325-30.8199-2.1771 c-10.1438-0.7345-20.5139-3.3689-30.5206-5.2036
									 c-21.0529-3.8597-42.129-7.6986-63.1381-11.7871 c-42.7938-8.328-85.7592-15.8619-128.62-23.8524c-21.6165-4.0298-43.25-7.9535-64.874-11.9396 c-10.5157-1.9385-21.0328-3.881-31.521-5.9642c-3.2131-0.6381-6.5777-1.077-7.1765-4.8949 c-0.9216-5.8757-0.113-12.4637-0.1102-18.4089c0.0895-185.7694,0.0862-371.5388,0.087-557.3082 c0.0001-11.146,0.0001-22.2924,0.0002-33.4384c0-2.7115-0.8728-7.2691,0.6964-9.6804c1.8351-2.8201,9.785-1.3683,12.4819-1.3834 c9.8492-0.0552,19.8955,0.8073,29.6094-1.1854c9.9312-2.0372,19.0519-6.6622,27.5282-12.1067 c34.0913-21.8972,59.651-57.7686,81.01-91.4886c23.2795-36.7521,43.9276-75.4404,62.1334-114.9429 c18.3373-39.788,34.3848-80.5327,51.8765-120.6971c17.0248-39.0923,48.2561-65.2728,80.8578-91.2554 c16.4827-13.1361,32.6666-26.548,46.3193-42.7003c13.8022-16.3293,24.9845-34.8267,33.7615-54.2959 c18.1166-40.1859,30.1417-84.3115,36.2227-127.9681c6.2136-44.6116,12.6005-89.2005,14.9655-134.2462 c0.3915-7.4563,1.6073-14.5817,7.3704-19.8748c2.4473-2.2476,5.3876-3.8947,8.4872-5.0599 C1513.9449,63.4004,1519.2778,63.2971,1520.5629,60.7246C1530.4342,60.7246,1519.7723,62.3071,1520.5629,60.7246z M654.1641,898.2689c0,113.5108,0,227.0218,0,340.5325c0,46.5209,0,93.0417,0,139.5626c0,23.2604,0,46.5209,0,69.7813 c0,12.0956,0,24.1909,0,36.2863c0,5.5826,0,11.165,0,16.7476c2.9518,0.6001,3.0689,7.4297,3.9023,9.6901 c5.8673,15.9106,20.7537,29.5836,36.6451,35.1024c9.34,3.2439,18.8117,3.2965,28.5798,3.3029 c11.0439,0.0074,22.0878,0.012,33.1318,0.0145c46.0164,0.0112,92.0328-0.0095,138.0493,0.0101 c19.0814,0.0082,36.9496-6.9194,49.56-21.6554c13.4414-15.7072,14.5669-34.699,14.5618-54.4558 c-0.012-46.6202-0.0196-93.2406-0.025-139.8608c-0.0109-93.2407-0.0132-186.4812-0.0248-279.7219 c-0.0057-46.3734,1.1533-92.9179-0.0865-139.2733c-0.5342-19.9727-7.4376-38.3519-23.3443-51.1132 c-15.4163-12.3679-33.5844-13.338-52.5065-13.3804c-46.3998-0.1041-92.7999-0.1375-139.1995-0.0057 c-20.9935,0.0595-42.7304-1.9652-61.1382,10.0648c-7.4174,4.8474-13.9482,11.0446-18.7111,18.5484 c-2.1867,3.4451-3.9904,7.1271-5.4059,10.9533C657.395,891.446,656.8574,897.8079,654.1641,898.2689 C654.1641,1099.2389,655.7422,897.9987,654.1641,898.2689z"/>
					</svg>
					<span style="font-size: 12px; font-weight: bold;">비추천</span>
				</div>
				<span class="art-recommend-value" style="font-size: 16px; font-weight: bold;">${article.art_bad }</span>
			</button>
		</div>
		<div id="art_writer" style="display: flex; justify-content: flex-end; align-items: center;">
			<div style="display: flex; flex-direction: column; justify-content: flex-end; align-items: center;">
				<span style="font-size: 16px; font-weight: bold;">${article.mem_nickname }</span>
				<div style="display: flex; justify-content: flex-end; align-items: center;">
					<div style="display: flex; justify-content: center; align-items: center; flex-grow: 1;">
						<svg viewBox="596.9167 0.0194 1565.0834 1639.8086" style="fill: var(--confirm); width: 12px; height: 12px; margin: 0 5px;">
							<!-- https://freesvg.org/thumbs-up-silhouette -->
							<path d="M1520.5629,60.7246c9.2529,0,22.9001-2.2927,31.0228,1.2784c4.0228,1.7685,10.0901,1.592,14.4762,2.7188 c5.8456,1.5018,11.6852,2.95,17.423,4.8376c19.8309,6.524,38.4539,17.5962,54.3069,31.1189 c15.4873,13.2107,28.811,28.8823,38.5651,46.7913c10.3126,18.9348,15.6564,39.2017,20.9418,59.9346 c5.438,21.3307,6.3975,44.4503,6.5536,66.3782c0.1575,22.0935-1.3568,45.1182-6.2789,66.6433 c-4.7166,20.626-9.5502,40.6268-17.2726,60.4215c-8.1235,20.8223-19.2517,40.6216-29.2167,60.5945 c-9.6312,19.3036-18.8459,38.775-28.1715,58.2219c-9.0332,18.8382-17.9552,38.7832-24.1283,58.7702 c-6.0906,19.7205-11.4923,40.3191-10.5479,61.155c0.3005,6.6298,1.0413,21.0134,7.0928,25.2928 c3.0446,2.1529,8.7776,0.9438,12.2129,0.8727c6.3768-0.1321,12.7501-0.3911,19.1221-0.6643 c46.1556-1.9804,92.4683-1.7981,138.6613-1.7421c45.6135,0.0554,91.168,0.327,136.7052,3.2466 c22.5062,1.4431,45.473,2.3863,67.7657,5.9072c20.1079,3.1758,39.5485,8.5963,55.7,21.558 c15.6963,12.5963,29.2531,29.2695,40.9388,45.5461c11.8752,16.5402,23.2302,34.9225,30.1526,54.1568 c3.2183,8.9421,6.8928,18.6378,7.8779,28.1332c1.1016,10.6202-0.9648,19.2577-6.2202,28.4807 c-10.1318,17.7805-24.4211,32.9326-35.489,50.126c-5.583,8.6729-9.6936,17.2821-8.1272,27.8564 c1.5747,10.6291,6.9783,20.636,12.1709,29.8923c9.8293,17.5203,21.5195,34.1235,30.4695,52.1269 c4.1145,8.2762,7.9856,17.6038,7.1602,27.0314c-0.873,9.9706-6.8962,18.98-12.7485,26.7786 c-12.3955,16.5182-27.3953,30.9061-39.7224,47.4825c-5.7537,7.7368-11.4421,16.1678-11.7715,26.1475 c-0.349,10.5802,2.4435,20.917,6.0121,30.7833c7.3593,20.3463,17.4034,40.3459,23.2218,61.1707 c6.0962,21.8181-0.4746,39.7147-13.5889,57.3821c-12.5927,16.9652-28.8911,30.9794-43.8359,45.7869 c-14.4075,14.2753-27.1533,28.6671-27.001,50.0262c0.078,10.9647,0.1594,21.9293,0.2654,32.8938 c0.1068,11.0503,1.4434,22.9386-1.6632,33.6997c-5.4886,19.0134-21.4039,36.1284-34.7365,50.1152 c-14.4594,15.1687-30.6368,28.7886-47.7722,40.8331c-17.229,12.1102-34.8148,20.5139-55.1942,25.6375 c-20.9213,5.2599-42.9412,7.8329-64.4313,9.6827c-90.5679,7.7957-181.6688,2.4065-272.3201-0.8159 c-44.7479-1.5908-89.6749-4.4669-134.2426-8.8455c-10.2728-1.0093-20.5367-1.4325-30.8199-2.1771 c-10.1438-0.7345-20.5139-3.3689-30.5206-5.2036
										 c-21.0529-3.8597-42.129-7.6986-63.1381-11.7871 c-42.7938-8.328-85.7592-15.8619-128.62-23.8524c-21.6165-4.0298-43.25-7.9535-64.874-11.9396 c-10.5157-1.9385-21.0328-3.881-31.521-5.9642c-3.2131-0.6381-6.5777-1.077-7.1765-4.8949 c-0.9216-5.8757-0.113-12.4637-0.1102-18.4089c0.0895-185.7694,0.0862-371.5388,0.087-557.3082 c0.0001-11.146,0.0001-22.2924,0.0002-33.4384c0-2.7115-0.8728-7.2691,0.6964-9.6804c1.8351-2.8201,9.785-1.3683,12.4819-1.3834 c9.8492-0.0552,19.8955,0.8073,29.6094-1.1854c9.9312-2.0372,19.0519-6.6622,27.5282-12.1067 c34.0913-21.8972,59.651-57.7686,81.01-91.4886c23.2795-36.7521,43.9276-75.4404,62.1334-114.9429 c18.3373-39.788,34.3848-80.5327,51.8765-120.6971c17.0248-39.0923,48.2561-65.2728,80.8578-91.2554 c16.4827-13.1361,32.6666-26.548,46.3193-42.7003c13.8022-16.3293,24.9845-34.8267,33.7615-54.2959 c18.1166-40.1859,30.1417-84.3115,36.2227-127.9681c6.2136-44.6116,12.6005-89.2005,14.9655-134.2462 c0.3915-7.4563,1.6073-14.5817,7.3704-19.8748c2.4473-2.2476,5.3876-3.8947,8.4872-5.0599 C1513.9449,63.4004,1519.2778,63.2971,1520.5629,60.7246C1530.4342,60.7246,1519.7723,62.3071,1520.5629,60.7246z M654.1641,898.2689c0,113.5108,0,227.0218,0,340.5325c0,46.5209,0,93.0417,0,139.5626c0,23.2604,0,46.5209,0,69.7813 c0,12.0956,0,24.1909,0,36.2863c0,5.5826,0,11.165,0,16.7476c2.9518,0.6001,3.0689,7.4297,3.9023,9.6901 c5.8673,15.9106,20.7537,29.5836,36.6451,35.1024c9.34,3.2439,18.8117,3.2965,28.5798,3.3029 c11.0439,0.0074,22.0878,0.012,33.1318,0.0145c46.0164,0.0112,92.0328-0.0095,138.0493,0.0101 c19.0814,0.0082,36.9496-6.9194,49.56-21.6554c13.4414-15.7072,14.5669-34.699,14.5618-54.4558 c-0.012-46.6202-0.0196-93.2406-0.025-139.8608c-0.0109-93.2407-0.0132-186.4812-0.0248-279.7219 c-0.0057-46.3734,1.1533-92.9179-0.0865-139.2733c-0.5342-19.9727-7.4376-38.3519-23.3443-51.1132 c-15.4163-12.3679-33.5844-13.338-52.5065-13.3804c-46.3998-0.1041-92.7999-0.1375-139.1995-0.0057 c-20.9935,0.0595-42.7304-1.9652-61.1382,10.0648c-7.4174,4.8474-13.9482,11.0446-18.7111,18.5484 c-2.1867,3.4451-3.9904,7.1271-5.4059,10.9533C657.395,891.446,656.8574,897.8079,654.1641,898.2689 C654.1641,1099.2389,655.7422,897.9987,654.1641,898.2689z"/>
						</svg>
						<span style="font-size: 12px;">${article.his_good }</span>
					</div>
					<div style="display: flex; justify-content: center; align-items: center; flex-grow: 1;">
						<div style="width: 6px; height: 2px; background-color: var(--theme-font); margin: 0 3px;"></div>
						<span style="font-size: 12px;">${article.his_normal }</span>
					</div>
					<div style="display: flex; justify-content: center; align-items: center; flex-grow: 1;">
						<svg viewBox="596.9167 0.0194 1565.0834 1639.8086" style="fill: var(--warning); width: 12px; height: 12px; transform: rotate(180deg); transform-origin: 50% 50%; margin: 0 5px;">
							<!-- https://freesvg.org/thumbs-up-silhouette -->
							<path d="M1520.5629,60.7246c9.2529,0,22.9001-2.2927,31.0228,1.2784c4.0228,1.7685,10.0901,1.592,14.4762,2.7188 c5.8456,1.5018,11.6852,2.95,17.423,4.8376c19.8309,6.524,38.4539,17.5962,54.3069,31.1189 c15.4873,13.2107,28.811,28.8823,38.5651,46.7913c10.3126,18.9348,15.6564,39.2017,20.9418,59.9346 c5.438,21.3307,6.3975,44.4503,6.5536,66.3782c0.1575,22.0935-1.3568,45.1182-6.2789,66.6433 c-4.7166,20.626-9.5502,40.6268-17.2726,60.4215c-8.1235,20.8223-19.2517,40.6216-29.2167,60.5945 c-9.6312,19.3036-18.8459,38.775-28.1715,58.2219c-9.0332,18.8382-17.9552,38.7832-24.1283,58.7702 c-6.0906,19.7205-11.4923,40.3191-10.5479,61.155c0.3005,6.6298,1.0413,21.0134,7.0928,25.2928 c3.0446,2.1529,8.7776,0.9438,12.2129,0.8727c6.3768-0.1321,12.7501-0.3911,19.1221-0.6643 c46.1556-1.9804,92.4683-1.7981,138.6613-1.7421c45.6135,0.0554,91.168,0.327,136.7052,3.2466 c22.5062,1.4431,45.473,2.3863,67.7657,5.9072c20.1079,3.1758,39.5485,8.5963,55.7,21.558 c15.6963,12.5963,29.2531,29.2695,40.9388,45.5461c11.8752,16.5402,23.2302,34.9225,30.1526,54.1568 c3.2183,8.9421,6.8928,18.6378,7.8779,28.1332c1.1016,10.6202-0.9648,19.2577-6.2202,28.4807 c-10.1318,17.7805-24.4211,32.9326-35.489,50.126c-5.583,8.6729-9.6936,17.2821-8.1272,27.8564 c1.5747,10.6291,6.9783,20.636,12.1709,29.8923c9.8293,17.5203,21.5195,34.1235,30.4695,52.1269 c4.1145,8.2762,7.9856,17.6038,7.1602,27.0314c-0.873,9.9706-6.8962,18.98-12.7485,26.7786 c-12.3955,16.5182-27.3953,30.9061-39.7224,47.4825c-5.7537,7.7368-11.4421,16.1678-11.7715,26.1475 c-0.349,10.5802,2.4435,20.917,6.0121,30.7833c7.3593,20.3463,17.4034,40.3459,23.2218,61.1707 c6.0962,21.8181-0.4746,39.7147-13.5889,57.3821c-12.5927,16.9652-28.8911,30.9794-43.8359,45.7869 c-14.4075,14.2753-27.1533,28.6671-27.001,50.0262c0.078,10.9647,0.1594,21.9293,0.2654,32.8938 c0.1068,11.0503,1.4434,22.9386-1.6632,33.6997c-5.4886,19.0134-21.4039,36.1284-34.7365,50.1152 c-14.4594,15.1687-30.6368,28.7886-47.7722,40.8331c-17.229,12.1102-34.8148,20.5139-55.1942,25.6375 c-20.9213,5.2599-42.9412,7.8329-64.4313,9.6827c-90.5679,7.7957-181.6688,2.4065-272.3201-0.8159 c-44.7479-1.5908-89.6749-4.4669-134.2426-8.8455c-10.2728-1.0093-20.5367-1.4325-30.8199-2.1771 c-10.1438-0.7345-20.5139-3.3689-30.5206-5.2036
										 c-21.0529-3.8597-42.129-7.6986-63.1381-11.7871 c-42.7938-8.328-85.7592-15.8619-128.62-23.8524c-21.6165-4.0298-43.25-7.9535-64.874-11.9396 c-10.5157-1.9385-21.0328-3.881-31.521-5.9642c-3.2131-0.6381-6.5777-1.077-7.1765-4.8949 c-0.9216-5.8757-0.113-12.4637-0.1102-18.4089c0.0895-185.7694,0.0862-371.5388,0.087-557.3082 c0.0001-11.146,0.0001-22.2924,0.0002-33.4384c0-2.7115-0.8728-7.2691,0.6964-9.6804c1.8351-2.8201,9.785-1.3683,12.4819-1.3834 c9.8492-0.0552,19.8955,0.8073,29.6094-1.1854c9.9312-2.0372,19.0519-6.6622,27.5282-12.1067 c34.0913-21.8972,59.651-57.7686,81.01-91.4886c23.2795-36.7521,43.9276-75.4404,62.1334-114.9429 c18.3373-39.788,34.3848-80.5327,51.8765-120.6971c17.0248-39.0923,48.2561-65.2728,80.8578-91.2554 c16.4827-13.1361,32.6666-26.548,46.3193-42.7003c13.8022-16.3293,24.9845-34.8267,33.7615-54.2959 c18.1166-40.1859,30.1417-84.3115,36.2227-127.9681c6.2136-44.6116,12.6005-89.2005,14.9655-134.2462 c0.3915-7.4563,1.6073-14.5817,7.3704-19.8748c2.4473-2.2476,5.3876-3.8947,8.4872-5.0599 C1513.9449,63.4004,1519.2778,63.2971,1520.5629,60.7246C1530.4342,60.7246,1519.7723,62.3071,1520.5629,60.7246z M654.1641,898.2689c0,113.5108,0,227.0218,0,340.5325c0,46.5209,0,93.0417,0,139.5626c0,23.2604,0,46.5209,0,69.7813 c0,12.0956,0,24.1909,0,36.2863c0,5.5826,0,11.165,0,16.7476c2.9518,0.6001,3.0689,7.4297,3.9023,9.6901 c5.8673,15.9106,20.7537,29.5836,36.6451,35.1024c9.34,3.2439,18.8117,3.2965,28.5798,3.3029 c11.0439,0.0074,22.0878,0.012,33.1318,0.0145c46.0164,0.0112,92.0328-0.0095,138.0493,0.0101 c19.0814,0.0082,36.9496-6.9194,49.56-21.6554c13.4414-15.7072,14.5669-34.699,14.5618-54.4558 c-0.012-46.6202-0.0196-93.2406-0.025-139.8608c-0.0109-93.2407-0.0132-186.4812-0.0248-279.7219 c-0.0057-46.3734,1.1533-92.9179-0.0865-139.2733c-0.5342-19.9727-7.4376-38.3519-23.3443-51.1132 c-15.4163-12.3679-33.5844-13.338-52.5065-13.3804c-46.3998-0.1041-92.7999-0.1375-139.1995-0.0057 c-20.9935,0.0595-42.7304-1.9652-61.1382,10.0648c-7.4174,4.8474-13.9482,11.0446-18.7111,18.5484 c-2.1867,3.4451-3.9904,7.1271-5.4059,10.9533C657.395,891.446,656.8574,897.8079,654.1641,898.2689 C654.1641,1099.2389,655.7422,897.9987,654.1641,898.2689z"/>
						</svg>
						<span style="font-size: 12px;">${article.his_bad }</span>
					</div>
				</div>
			</div>
			<div style="width: 50px; height: 50px; border-radius: 50%; margin: 10px; box-shadow: 0 2.5px 2.5px var(--theme-font); overflow: hidden;">
				<img style="object-fit: cover; width: 50px; height: 50px;" src="${pageContext.request.contextPath }/uploads/profile/${article.mem_image }" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/anonymous.png';">
			</div>
		</div>
		<div style="display: flex; justify-content: flex-start; align-items: center; border-bottom: 1px solid var(--subtheme);">
			<h2 style="color: var(--subtheme); margin: 10px;">댓글</h2>
			<button type="button" class="theme-button adv-hover" style="padding: 2.5px; border: 0; display: flex; justify-content: center; align-items: center;" onclick="getReplyList(${article.art_id}, ${article.brd_id});">
				<svg width="32" height="32" viewBox="0 0 512 512" style="pointer-events: none; stroke-width: 64px; stroke-linecap: round; stroke-linejoin: round; stroke-miterlimit: 10px; stroke: var(--subtheme); fill: none;">
					<path d="M320 146s24.36-12-64-12a160 160 0 10160 160"/>
					<path d="M256 58l80 80-80 80"/>
				</svg>
			</button>
		</div>
		<c:choose>
			<c:when test="${memberInfo != null }">
				<div id="reply-write" style="margin-top: 10px;">
					<form id="reply-form" name="reply-form" method="post" onsubmit="return replyToAjax(this);">
						<input type="hidden" name="art_id" value="${article.art_id }">
						<input type="hidden" name="brd_id" value="${article.brd_id }">
						<input type="hidden" name="mem_id" value="${memberInfo.mem_id }">
						<div id="reply-form-group" style="display: flex; flex-direction: column; justify-content: center; align-content: stretch; border: 2px solid var(--subtheme); border-radius: 5px;">
							<div class="reply-box-title" style="display: flex; justify-content: space-between; align-items: center; padding: 5px 10px;">
								<div style="display: flex; justify-content: flex-start; align-items: center;">
									<div style="width: 40px; height: 40px; border-radius: 50%; overflow: hidden; margin-right: 10px; box-shadow: 0 2.5px 2.5px var(--theme-font); display: flex; justify-content: center; align-items: center; background-color: white;">
										<img src="${pageContext.request.contextPath }/uploads/profile/${memberInfo.mem_image }" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg';" style="width: 40px; height: 40px; object-fit: cover;">
									</div>
									<div style="display: flex; flex-direction: column; justify-content: center; align-items: flex-start;">
										<span style="font-size: 18px; font-weight: bold;">${memberInfo.mem_nickname }</span>
									</div>
								</div>
								<button type="submit" class="subtheme-button" style="margin: 0 10px; padding: 2.5px 5px; font-size: 16px; font-weight: bold;">댓글 등록</button>
							</div>
							<textarea id="rep_content" name="rep_content" maxlength="300" style="height: 100px; margin: 0 10px; margin-bottom: 10px; border: 0.5px solid var(--theme-font); border-radius: 2.5px; outline: none; resize: none; background-color: var(--theme);" required></textarea>
						</div>
					</form>
				</div>
			</c:when>
			<c:otherwise>
				<div style="border: 0; border-radius: 5px; margin-top: 10px; padding: 10px; background-color: rgba(var(--subtheme-rgb), 0.125); display: flex; justify-content: flex-start; align-items: center;">
					<span style="font-size: 14px; color: var(--theme-font);">로그인 후 댓글을 작성할 수 있습니다</span>
					<a href="${pageContext.request.contextPath }/login" style="margin: 0; margin-left: 10px; font-size: 16px; font-weight: bold; color: var(--subtheme);">로그인</a>
				</div>
			</c:otherwise>
		</c:choose>
		<div id="reply-section" style="display: flex; flex-direction: column; justify-content: flex-start; align-items: stretch;">
			
		</div>
	</div>
</body>
</html>