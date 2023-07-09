<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지 ▒ ShareGo</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/initializer.js"></script>
<script type="text/javascript">
	$(window).scroll(() => {
		let scrollTop = $(window).scrollTop();
		let header = $('header');
		if (header != null) {
			if (scrollTop > 21 && !header.hasClass('fix-header')) {
				header.addClass('fix-header');
			}
			else if (scrollTop <= 21 && header.hasClass('fix-header')) {
				header.removeClass('fix-header');
			}
		}
	});
	$(() => {
		$('#scrollToTop').click(e => $(window).scrollTop(0));
		$('#scrollToBottom').click(e => $(window).scrollTop($(document).height() - 1120));
	});
</script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/presets.css">
<style type="text/css">
	body {
		width: 100%;
		display: grid;
		grid-template-columns: 200px 1fr 200px;
		grid-template-rows: 100px 1fr 200px;
		grid-template-areas:
			"header header header"
			"leftside main rightside"
			"footer footer footer";
	}
	header {
		grid-area: header;
		height: 100px;
		background-color: var(--theme);
		border-bottom: 0.5px solid #CCCCCC;
		z-index: 99;
	}
	aside {
		background-color: var(--backtheme);
	}
	aside#leftside {
		grid-area: leftside;
		/* TEST */
		height: 5000px;
	}
	main {
		grid-area: main;
		background-color: var(--theme);
		/* TEST */
		height: 5000px;
	}
	aside#rightside {
		grid-area: rightside;
		/* TEST */
		height: 5000px;
	}
	footer {
		grid-area: footer;
		height: 200px;
		border-top: 0.5px solid #CCCCCC;
		background-color: var(--theme);
	}
	
	header > div#usernav {
		width: 100%;
		display: flex;
		justify-content: flex-end;
		align-items: center;
		background-color: var(--backtheme);
	}
	header > div#usernav > a {
		font-size: 14px;
		color: var(--subtheme);
		font-weight: bold;
		margin: 0 5px;
	}
	header > div#topbar > div#logo-div, header > div#topbar > div#top-right { width: 200px; }
	header > div#topbar > div#top-right {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	header > div#topbar {
		display: flex;
		justify-content: space-between;
		align-items: center;
		height: calc(100% - 21px);
	}
	header > div#topbar > div#topmenu {
		display: flex;
		height: 100%;
		justify-content: flex-start;
		align-items: stretch;
	}
	header > div#topbar > div#topmenu > div.menu-separator {
		width: 0;
		height: 20px;
		border: 1px solid #888888;
		opacity: 0.25;
		margin: 29.5px 0;
	}
	header > div#topbar > div#topmenu > a.menuitem {
		display: block;
		font-size: 18px;
		background-color: var(--theme);
		padding: 0 10px;
		line-height: 79px;
		font-weight: bold;
		width: 120px;
		text-align: center;
	}
	div#dropdown {
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		position: absolute;
		top: 100px;
		left: 0;
		width: 100%;
		height: 0px;
		background-color: var(--theme);
		border-bottom: 0.5px solid #CCCCCC;
		transition: height .125s cubic-bezier(.5,1,.5,1);
		overflow: hidden;
	}
	header > div#topbar > div#topmenu > a.menuitem:hover ~ div#dropdown,
	header > div#topbar > div#topmenu > div.menu-separator:hover ~ div#dropdown,
	header > div#topbar > div#topmenu > div#dropdown:hover {
		height: 192.5px;
	}
	header > div#topbar > div#topmenu > div#dropdown > div.submenu-items {
		display: flex;
		justify-content: flex-start;
		align-items: stretch;
	}
	header > div#topbar > div#topmenu > div#dropdown > div.submenu-items > div.submenu {
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
		width: 120px;
		margin: 0 1px;
	}
	header > div#topbar > div#topmenu > div#dropdown > div.submenu-items > div.submenu > a.submenuitem {
		display: block;
		width: 100%;
		height: 32px;
		line-height: 32px;
		font-size: 16px;
		background-color: var(--theme);
		text-align: center;
	}
	.fix-header {
		top: -21px;
		position: fixed;
		grid-area: none;
		width: 100%;
	}
	
	/* Dark And Light Mode Switcher */
	#viewMode {
		border: 2px solid var(--subtheme-font);
		border-radius: 14.5px;
		width: 54px;
		height: 29px;
		background-color: var(--subtheme);
		position: relative;
	}
	#viewModeButton {
		border: 0;
		background-color: var(--subtheme-font);
		width: 20px;
		height: 20px;
		border-radius: 10px;
		position: absolute;
		top: 2.5px;
		left: 2.5px;
		transition: left .25s cubic-bezier(.5, 1, .5, 1);
	}
	#viewMode[data-toggle="true"] > #viewModeButton {
		left: 27.5px;
	}
	
	/* User Info Popup */
	div.popup-group {
		position: relative;
	}
	div.popup-group > button.togglePopup {
		width: 50px;
		height: 50px;
		/*border-radius: 25px;
		background-color: var(--subtheme);*/
		overflow: hidden;
	}
	div.popup-group > div.popup-window {
		position: absolute;
		padding: 10px 20px;
		border-radius: 5px;
		background-color: var(--theme);
		/* border: 2px solid var(--theme-font); */
		border: 2px solid #CCCCCC;
		top: 64.5px;
		right: 0px;
	}
	
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
	button#login-button {
		width: 100px;
		height: 32px;
		line-height: 32px;
		text-align: center;
		font-size: 16px;
	}
	button.init-button {
		border: 0;
		background-color: var(--theme);
		padding: 0;
		margin: 0;
		outline: none;
		cursor: pointer;
	}
	button > svg {
		pointer-events: none;
	}
	button#scrollToTop, button#scrollToBottom {
		position: fixed;
		width: 40px;
		height: 40px;
		outline: none;
		border: 0.5px solid var(--subtheme);
		border-radius: 10px;
		background-color: var(--theme);
		cursor: pointer;
		opacity: 0.5;
		box-shadow: 0 5px 5px var(--theme-font);
	}
	button#scrollToTop {
		bottom: 60px;
		right: 10px;
	}
	button#scrollToBottom {
		bottom: 10px;
		right: 10px;
	}
	
	/* Footer */
	#footer-info {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
</style>
</head>
<body>
	<header>
		<div id="usernav">
			<!-- <a href="">로그인</a>
			<a href="">회원가입</a>
			<a href="">마이페이지</a> -->
			<a href="">이용 약관</a>
			<a href="">개인정보 취급 방침</a>
		</div>
		<div id="topbar">
			<div id="logo-div" class="full-height" style="display: flex; justify-content: flex-start; align-items: center; padding: 0 10px;">
				<a id="logo" class="full-height" href="/">
					<!-- <img class="full-height" src="image/ShareGo_forLight.png"/> -->
					<div style="width: auto; display: flex; flex-direction: column; justify-content: center; align-items: flex-end;">
						<img src="${pageContext.request.contextPath}/image/ShareGo_Img.png" style="height: 30px;">
						<span style="font-size: 24px; font-weight: 900; margin: -5px 0 0 0;">ShareGo</span>
					</div>
				</a>
			</div>
			<div id="topmenu">
				<a class="adv-hover menuitem" href="">함께해요</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="">같이사요</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="">나눔해요</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="">커뮤니티</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="">정보공유</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="">고객센터</a>
				<div id="dropdown">
					<div style="width: 200px;"></div>
					<div class="submenu-items">
						<div class="submenu">
							<a class="submenuitem adv-hover" href="">밥 / 카페</a>
							<a class="submenuitem adv-hover" href="">스포츠 / 운동</a>
							<a class="submenuitem adv-hover" href="">쇼핑</a>
							<a class="submenuitem adv-hover" href="">문화생활</a>
							<a class="submenuitem adv-hover" href="">취미생활</a>
							<a class="submenuitem adv-hover" href="">기타</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="">식료품</a>
							<a class="submenuitem adv-hover" href="">의류 / 잡화</a>
							<a class="submenuitem adv-hover" href="">생활용품</a>
							<a class="submenuitem adv-hover" href="">해외배송</a>
							<a class="submenuitem adv-hover" href="">기타</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="">식품</a>
							<a class="submenuitem adv-hover" href="">패션 / 잡화</a>
							<a class="submenuitem adv-hover" href="">가전 / 가구</a>
							<a class="submenuitem adv-hover" href="">기타</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="">일상수다</a>
							<a class="submenuitem adv-hover" href="">자랑하기</a>
							<a class="submenuitem adv-hover" href="">홍보하기</a>
							<a class="submenuitem adv-hover" href="">질문 / 요청</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="">동네정보</a>
							<a class="submenuitem adv-hover" href="">구매정보</a>
							<a class="submenuitem adv-hover" href="">신규점포</a>
							<a class="submenuitem adv-hover" href="">지역활동</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="">공지</a>
							<a class="submenuitem adv-hover" href="">Q&A</a>
							<a class="submenuitem adv-hover" href="">이벤트</a>
							<a class="submenuitem adv-hover" href="">문의 / 건의</a>
						</div>
					</div>
					<div style="width: 200px;"></div>
				</div>
			</div>
			<div id="top-right">
				<!-- <button id="viewMode">
					<div id="viewModeButton"></div>
				</button> -->
				<div></div>
				<div class="popup-group">
					<c:choose>
						<c:when test="${1 == 1 }">
							<button id="login" class="togglePopup init-button">
								<svg width="40" height="40" viewBox="0 0 512 512" style="margin: 5px;">
									<!-- <path d="M192 176v-40a40 40 0 0140-40h160a40 40 0 0140 40v240a40 40 0 01-40 40H240c-22.09 0-48-17.91-48-40v-40" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/>
									<path fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="32" d="M288 336l80-80-80-80M80 256h272"/> -->
									<path d="M258.9 48C141.92 46.42 46.42 141.92 48 258.9c1.56 112.19 92.91 203.54 205.1 205.1 117 1.6 212.48-93.9 210.88-210.88C462.44 140.91 371.09 49.56 258.9 48zm126.42 327.25a4 4 0 01-6.14-.32 124.27 124.27 0 00-32.35-29.59C321.37 329 289.11 320 256 320s-65.37 9-90.83 25.34a124.24 124.24 0 00-32.35 29.58 4 4 0 01-6.14.32A175.32 175.32 0 0180 259c-1.63-97.31 78.22-178.76 175.57-179S432 158.81 432 256a175.32 175.32 0 01-46.68 119.25z"/>
									<path d="M256 144c-19.72 0-37.55 7.39-50.22 20.82s-19 32-17.57 51.93C191.11 256 221.52 288 256 288s64.83-32 67.79-71.24c1.48-19.74-4.8-38.14-17.68-51.82C293.39 151.44 275.59 144 256 144z"/>
								</svg>
							</button>
							<div id="login-popup" class="popup-window">
								<button id="login-button" class="subtheme-button adv-hover" click="location.href = '/login';">
									로그인
								</button>
							</div>
						</c:when>
						<c:otherwise>
							<button id="userInfo" class="togglePopup adv-hover">
								
							</button>
							<div id="userInfo-popup" class="popup-window">
								
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</header>
	<aside id="leftside">
		
	</aside>
	<main>
		
		<button id="scrollToTop" class="adv-hover">
			<svg style="fill: var(--subtheme); stroke: var(--subtheme); stroke-width: 2px; stroke-linecap: round; stroke-linejoin: round;" width="20" height="10" viewBox="0 0 32 16">
				<path d="M 15 1 L 1 15 31 15 Z"/>
			</svg>
		</button>
		<button id="scrollToBottom" class="adv-hover">
			<svg style="fill: var(--subtheme); stroke: var(--subtheme); stroke-width: 2px; stroke-linecap: round; stroke-linejoin: round;" width="20" height="10" viewBox="0 0 32 16">
				<path d="M 15 15 L 1 1 31 1 Z"/>
			</svg>
		</button>
	</main>
	<aside id="rightside">
		
	</aside>
	<footer>
		<div id="footer-info" class="full-height">
			<span style="font-size: 40px; font-weight: 900; margin: 0 10px; text-align: left; opacity: 0.5;">ShareGo</span>
			<div style="font-size: 12px; flex-grow: 1;">
				<p>서울특별시 마포구 신촌로 176</p>
				<p>02-313-1711</p>
				<p>choongang@naver.com</p>
			</div>
			<div>
				<a href="" style="margin: 10px;">
					<svg style="fill: var(--theme-font);" width="30" height="30" viewBox="0 0 512 512">
						<path d="M480 257.35c0-123.7-100.3-224-224-224s-224 100.3-224 224c0 111.8 81.9 204.47 189 221.29V322.12h-56.89v-64.77H221V208c0-56.13 33.45-87.16 84.61-87.16 24.51 0 50.15 4.38 50.15 4.38v55.13H327.5c-27.81 0-36.51 17.26-36.51 35v42h62.12l-9.92 64.77H291v156.54c107.1-16.81 189-109.48 189-221.31z" fill-rule="evenodd"/>
					</svg>
				</a>
				<a href="" style="margin: 10px;">
					<svg style="stroke: var(--theme-font);" width="30" height="30" viewBox="0 0 512 512">
						<path d="M349.33 69.33a93.62 93.62 0 0193.34 93.34v186.66a93.62 93.62 0 01-93.34 93.34H162.67a93.62 93.62 0 01-93.34-93.34V162.67a93.62 93.62 0 0193.34-93.34h186.66m0-37.33H162.67C90.8 32 32 90.8 32 162.67v186.66C32 421.2 90.8 480 162.67 480h186.66C421.2 480 480 421.2 480 349.33V162.67C480 90.8 421.2 32 349.33 32z"/>
						<path d="M377.33 162.67a28 28 0 1128-28 27.94 27.94 0 01-28 28zM256 181.33A74.67 74.67 0 11181.33 256 74.75 74.75 0 01256 181.33m0-37.33a112 112 0 10112 112 112 112 0 00-112-112z"/>
					</svg>
				</a>
				<a href="" style="margin: 10px;">
					<svg style="fill: var(--theme-font);" width="30" height="30" viewBox="0 0 512 512">
						<path d="M508.64 148.79c0-45-33.1-81.2-74-81.2C379.24 65 322.74 64 265 64h-18c-57.6 0-114.2 1-169.6 3.6C36.6 67.6 3.5 104 3.5 149 1 184.59-.06 220.19 0 255.79q-.15 53.4 3.4 106.9c0 45 33.1 81.5 73.9 81.5 58.2 2.7 117.9 3.9 178.6 3.8q91.2.3 178.6-3.8c40.9 0 74-36.5 74-81.5 2.4-35.7 3.5-71.3 3.4-107q.34-53.4-3.26-106.9zM207 353.89v-196.5l145 98.2z"/>
					</svg>
				</a>
				<a href="" style="margin: 10px;">
					<svg style="fill: var(--theme-font);" width="30" height="30" viewBox="0 0 512 512">
						<path d="M496 109.5a201.8 201.8 0 01-56.55 15.3 97.51 97.51 0 0043.33-53.6 197.74 197.74 0 01-62.56 23.5A99.14 99.14 0 00348.31 64c-54.42 0-98.46 43.4-98.46 96.9a93.21 93.21 0 002.54 22.1 280.7 280.7 0 01-203-101.3A95.69 95.69 0 0036 130.4c0 33.6 17.53 63.3 44 80.7A97.5 97.5 0 0135.22 199v1.2c0 47 34 86.1 79 95a100.76 100.76 0 01-25.94 3.4 94.38 94.38 0 01-18.51-1.8c12.51 38.5 48.92 66.5 92.05 67.3A199.59 199.59 0 0139.5 405.6a203 203 0 01-23.5-1.4A278.68 278.68 0 00166.74 448c181.36 0 280.44-147.7 280.44-275.8 0-4.2-.11-8.4-.31-12.5A198.48 198.48 0 00496 109.5z"/>
					</svg>
				</a>
			</div>
		</div>
	</footer>
</body>
</html>