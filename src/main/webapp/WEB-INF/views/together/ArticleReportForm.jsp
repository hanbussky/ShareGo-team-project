<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고내용 팝업창</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>

<script>
	
	
	$(() => {
		$('.rep_submit').click(e => {
			let rawData = { art_id : ${article.art_id}, brd_id : ${article.brd_id}, mem_id : ${memberInfo.mem_id},
							report_id : ${article.report_id == null ? 'null' : article.report_id},
							report_content : $(e.target).closest('.report_table').find('.report_content').val()};
			
			//if (!(!${article.report_id})) rawData['report_id']  = ${article.report_id};
			let sendData = JSON.stringify(rawData);
	
			$.ajax({
			  url : "/board/ArticleReport",
			  type : 'post',
			  data : sendData,
			  dataType :'json',
			  contentType : 'application/json',
			  success : data => {
					  console.log(data.result);
				  if(data.result == 1) {
					  alert('신고 완료');
					  window.close();
					  
				  } else {
					  alert('신고 실패');
				  }
	  			
	  			}
			});
		});
		
		$('.rep_cancel').click(() => {
		    if (confirm('정말 취소하시겠습니까?')) {
		        window.close();
		    }
		});
	});
		  
</script>
</head>
<body>
<h2>게시글 신고</h2>
    <form action="${pageContext.request.contextPath }/board/ArticleReport" method="POST">  

        <table class="report_table" border="1">
            <tr>
                <th>신고내용</th>
                <td><textarea class="report_content" name="report_content" placeholder="신고 내용을 작성해주세요"
                rows="30" cols="50" style="resize: none;"></textarea></td>
            </tr>
            <tr>
                <td><button type="button" class="rep_submit">신고하기</button></td>
                <td><button type="button" class="rep_cancel">취소하기</button></td>
            </tr>
        </table>
    </form>
</body>
</html>