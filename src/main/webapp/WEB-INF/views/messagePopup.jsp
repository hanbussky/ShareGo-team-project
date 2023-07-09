<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지함</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/message.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/message.js"></script>
</head>
<body>
	<div class="container">
		<!-- 사이드바 -->
		<div class="message-sidebar">
			<div class="sidebar-menu">
				<div class="menu-profile" style="border-bottom: 1px solid rgba(128, 128, 128, 0.5);">
					<img src="${pageContext.request.contextPath}/uploads/profile/${memberInfo.mem_image}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg';">
					<p>${memberInfo.mem_nickname}</p>
				</div>
				<div class="menu-item">
					<button onclick="writebox()">쪽지 쓰기</button>
					<button onclick="receivebox()">받은 쪽지함</button>
					<button onclick="sentbox()">보낸 쪽지함</button>
					<button onclick="storagebox()">쪽지 보관함</button>
					<button onclick="recyclebox()">휴지통</button>
				</div>				
			</div>
		</div>
		
		<!-- 본문 -->
		<div class="message-content">
		<!-- 쪽지 작성 -->
			<div class="content-write">
				<h2>쪽지 쓰기</h2>
				<form action="${pageContext.request.contextPath}/message/writeForm" method="post" id="writeForm">
					<div class="write-group">
						<label for="mem_username">받는 사람 : </label>
						<input type="text" name="mem_username" id="mem_username" required="required">
						<input type="hidden" name="mem_receiver_id" id="mem_receiver_id">
						<span id="mem_result"></span>
					</div>
					<div class="write-group">
						<label for="mes_title">제목 : </label>
						<input type="text" id="mes_title" name="mes_title" placeholder="제목을 입력해 주세요" required="required">
					</div>
					<div class="write-group">
						<textarea id="mes_content" name="mes_content" required="required"></textarea>
					</div>
					<div class="write-group">
						<button>보내기</button>
					</div>
				</form>
			</div>
		
		<!--받은 쪽지함 -->
			<div class="content-receiver">
				<h2>받은 쪽지함</h2>
				<div class="content-message">
					<c:forEach var="message" items="${messageListRec}">
						<c:if test="${message.mes_status == 301}">
							<div class="message-list" id="list-receiver" ${message.mes_isread == 1? 'style="background-color: rgba(0, 0, 0, 0.1);"':''}>
								<input type="hidden" name="mes_id" value="${message.mes_id}"> <!-- 쪽지번호 -->
								<input type="hidden" name="mem_sender_id" value="${message.mem_sender_id}"> <!-- 발신자 고유번호 -->
								<input type="hidden" name="mem_receiver_id" value="${message.mem_receiver_id}"> <!-- 수신자 고유번호 -->
								<div class="list-title">
									<span>${message.member.mem_username}<br>[${message.member.mem_nickname}]</span>
									<span>${message.mes_title}</span>
									<span><fmt:formatDate value="${message.mes_regdate}" pattern="yy.MM.dd [HH:mm]"/></span>
								</div>
								<div class="list-content">
									<span>${message.mes_content}</span>
									<button onclick="messageReply('${message.member.mem_id}','${message.member.mem_username}')">답장</button>
									<button onclick="messageAction('storage','${message.mes_id}','${message.mem_sender_id}','${message.mem_receiver_id}')">보관</button>
									<button onclick="messageAction('recycle','${message.mes_id}','${message.mem_sender_id}','${message.mem_receiver_id}')">휴지통</button>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
	
		<!--쪽지 보관함 -->
			<div class="content-storage">
				<h2>쪽지 보관함</h2>
				<div class="content-message">
					<c:forEach var="message" items="${messageListRec}">
						<c:if test="${message.mes_status == 302}">
							<div class="message-list" ${message.mes_isread == 1? 'style="background-color: rgba(0, 0, 0, 0.1);"':''}>
								<input type="hidden" name="mes_id" value="${message.mes_id}"> <!-- 쪽지번호 -->
								<input type="hidden" name="mem_receiver_id" value="${message.mem_sender_id}"> <!-- 발신자 고유번호 -->
								<input type="hidden" name="mem_receiver_id" value="${message.mem_receiver_id}"> <!-- 수신자 고유번호 -->
								<div class="list-title">
									<span>${message.member.mem_nickname}</span>
									<span>${message.mes_title}</span>
									<span><fmt:formatDate value="${message.mes_regdate}" pattern="yy.MM.dd [HH:mm]"/></span>
								</div>
								<div class="list-content">
									<span>${message.mes_content}</span>
									<button onclick="messageAction('recycle','${message.mes_id}','${message.mem_sender_id}','${message.mem_receiver_id}')">휴지통</button>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
		<!-- 휴지통 -->
			<div class="content-recycle">
				<h2>휴지통</h2>
				<div class="content-message">
					<c:forEach var="message" items="${messageListRec}">
						<c:if test="${message.mes_status == 303}">
							<div class="message-list" ${message.mes_isread == 1? 'style="background-color: rgba(0, 0, 0, 0.1);"':''}>
								<input type="hidden" name="mes_id" value="${message.mes_id}"> <!-- 쪽지번호 -->
								<input type="hidden" name="mem_receiver_id" value="${message.mem_sender_id}"> <!-- 발신자 고유번호 -->
								<input type="hidden" name="mem_receiver_id" value="${message.mem_receiver_id}"> <!-- 수신자 고유번호 -->
								<div class="list-title">
									<span>${message.member.mem_nickname}</span>
									<span>${message.mes_title}</span>
									<span><fmt:formatDate value="${message.mes_regdate}" pattern="yy.MM.dd [HH:mm]"/></span>
								</div>
								<div class="list-content">
									<span>${message.mes_content}</span>
									<button onclick="messageAction('delete','${message.mes_id}','${message.mem_sender_id}','${message.mem_receiver_id}')">삭제</button>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
		<!-- 보낸 쪽지함 -->
			<div class="content-sender">
				<h2>보낸 쪽지함</h2>
				<div class="content-message">
					<c:forEach var="message" items="${messageListSen}">
						<div class="message-list" ${message.mes_isread == 1? 'style="background-color: rgba(0, 0, 0, 0.1);"':''}>
							<input type="hidden" name="mes_id" value="${message.mes_id}"> <!-- 쪽지번호 -->
							<input type="hidden" name="mem_receiver_id" value="${message.mem_sender_id}"> <!-- 발신자 고유번호 -->
							<input type="hidden" name="mem_receiver_id" value="${message.mem_receiver_id}"> <!-- 수신자 고유번호 -->
							<div class="list-title">
								<span>${message.member.mem_nickname}</span>
								<span>${message.mes_title}</span>
								<span><fmt:formatDate value="${message.mes_regdate}" pattern="yy.MM.dd [HH:mm]"/></span>
							</div>
							<div class="list-content">
								<span>${message.mes_content}</span>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>