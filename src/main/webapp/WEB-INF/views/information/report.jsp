<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<c:if test="${isReported}">
	<script type="text/javascript">
		window.close();
	</script>
</c:if>
<script type="text/javascript">
function write(){
	alert("신고가 완료 되었습니다");
}
</script>
</head>
<body>
<form action="${pageContext.request.contextPath }/board/information/reportinsert" method = "post">
<div>
<input type="hidden" name="report_id" value="${report.report_id }">
<input type="hidden" name="category" value="${category}">
<input type="hidden" name="mem_id" value="${memberInfo.mem_id}">
</div>
<table>
  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
     <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
      <td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
      <td>신고하기</td>
      <td width="5"><img src="img/table_right.gif" width="5" height="30" /></td>
     </tr>
    </table>
    <table>
<%--      <tr>
      <td>&nbsp;</td>
      <td align="center">신고닉네임</td>
      <td><input name="mem_id" size="50" maxlength="100"  value="${member.mem_id }"></td>
      <td>&nbsp;</td>
     </tr>
     	<tr height="1" bgcolor="#dddddd"><td colspan="4"></td>
     </tr> --%>
    <tr>
      <td>&nbsp;</td>
      <td align="center">내용</td>
      <td><textarea name="report_content" cols="50" rows="13"></textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr align="center">
      <td>&nbsp;</td>
      <td colspan="2">
      <td>&nbsp;</td>
     </tr>
    </table>
   </td>
  </tr>
 </table>
 <input type=submit value="등록하기">
 <input type=button onclick="window.close();" value="취소">
 </form>
</body>
</html>