<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="preset.jsp" %>
<c:forEach var="reply" items="${replies }">
	<div class="reply-box" style="display: flex; flex-direction: column; justify-content: flex-start; align-items: stretch;">
		<div class="reply-main" style="display: flex; justify-content: flex-start; align-items: stretch;">
			<c:if test="${reply.rep_id != reply.rep_parent }">
				<div class="reply-indent" style="width: 30px; display: flex; justify-content: flex-end; align-items: stretch;">
					<div style="border-left: 2px solid var(--theme-font); width: 50%; opacity: 0.5;"></div>
				</div>
			</c:if>
			<!-- <div class="reply-indented" style="display: flex; flex-direction: column; justify-content: flex-start; align-items: stretch; border: 1px solid var(--subtheme); border-radius: 5px; margin-top: 10px; flex-grow: 1;"> -->
			<div id="reply-${reply.rep_id }" class="reply-indented" style="display: flex; flex-direction: column; justify-content: flex-start; align-items: stretch; border: 0; border-radius: 5px; margin-top: 10px; flex-grow: 1; background-color: ${reply.rep_id == reply.rep_parent ? 'rgba(var(--subtheme-rgb), 0.25)' : 'rgba(var(--subtheme-rgb), 0.125)'};">
				<div class="reply-box-title" style="display: flex; justify-content: space-between; align-items: center; padding: 5px 10px;">
					<div style="display: flex; justify-content: flex-start; align-items: center;">
						<div style="width: 40px; height: 40px; border-radius: 50%; overflow: hidden; margin-right: 10px; box-shadow: 0 2.5px 2.5px var(--theme-font); display: flex; justify-content: center; align-items: center; background-color: white;">
							<img src="${pageContext.request.contextPath }/uploads/profile/${reply.mem_image }" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg';" style="width: 40px; height: 40px; object-fit: cover;">
						</div>
						<div style="display: flex; flex-direction: column; justify-content: center; align-items: flex-start;">
							<span style="font-size: 18px; font-weight: bold;">${reply.mem_nickname }</span>
							<c:set var="date"><fmt:formatDate value="${reply.rep_regdate }" pattern="MM.dd"/></c:set>
							<c:set var="time"><fmt:formatDate value="${reply.rep_regdate }" pattern="hh:mm"/></c:set>
							<span style="font-size: 14px; font-weight: bold;">${date } [${time }]</span>
						</div>
					</div>
					<div style="display: flex; justify-content: flex-end; align-items: center;">
						<c:if test="${memberInfo != null }">
							<button type="button" onclick="$('.reply-reply-box').not('#reply-reply-box-${reply.rep_id }').hide(); $('#reply-reply-box-${reply.rep_id }').toggle();" style="cursor: pointer; border: 0; outline: none; background-color: transparent; font-weight: bold; color: var(--theme-font);">댓글 달기</button>
						</c:if>
					</div>
				</div>
				<span style="margin: 10px;">${reply.rep_content }</span>
			</div>
		</div>
		<div id="reply-reply-box-${reply.rep_id }" class="reply-reply-box" style="display: none; width: 100%;">
			<div class="reply-reply" style="display: flex; justify-content: flex-start; align-items: stretch; width: 100%;">
				<div class="reply-indent" style="width: 30px; display: flex; justify-content: flex-end; align-items: stretch;">
					<div style="border-left: 2px solid var(--theme-font); width: 50%; opacity: 0.5;"></div>
				</div>
				<div style="margin-top: 10px; border: 2px solid var(--subtheme); border-radius: 5px; flex-grow: 1;">
					<form id="reply-reply-form" name="reply-reply-form" method="post" onsubmit="return replyToAjax(this);">
						<input type="hidden" name="art_id" value="${reply.art_id }">
						<input type="hidden" name="brd_id" value="${reply.brd_id }">
						<input type="hidden" name="mem_id" value="${memberInfo.mem_id }">
						<input type="hidden" name="rep_parent" value="${reply.rep_parent }">
						<c:if test="${reply.rep_id != reply.rep_parent }">
							<input type="hidden" name="reply-add" value="reply-${reply.rep_id }">
							<input type="hidden" name="display-whose" value="@${reply.mem_nickname }">
						</c:if>
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
							<textarea name="rep_content" maxlength="300" style="height: 100px; margin: 0 10px; margin-bottom: 10px; border: 0.5px solid var(--theme-font); border-radius: 2.5px; outline: none; resize: none; background-color: var(--theme);" required></textarea>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</c:forEach>