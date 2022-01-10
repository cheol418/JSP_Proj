<%@page import="board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
deleteProc.jsp<br>

<%
	request.setCharacterEncoding("UTF-8");
	int num =  Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	String passwd = request.getParameter("passwd");
	
	BoardDao dao = BoardDao.getInstance();
	int cnt = dao.deleteArticle(passwd, num); // where num=? s
	
%>
<!-- form=>5가지 -->
<% 
	int pageSize = 10;
if(cnt >= 0){
	int recordCount = dao.getArticleCount(); //레코드의 개수
	System.out.println("남은 레코드 갯수 count:"+ recordCount);
	
	int pageCount = recordCount/pageSize + (recordCount % pageSize);
	
	if(pageCount < pageNum){
		response.sendRedirect("list.jsp?pageNum="+(pageNum-1));
	}
	else{
		response.sendRedirect("list.jsp?pageNum="+pageNum);
	}
	
}else{ // 비번 일치 안함
	%>
		<script type="text/javascript">
			alert("비밀 번호가 맞지 않습니다.");
			//history.back(); deleteForm으로이동
			history.go(-1);
		</script>   
<%
	
	//response.sendRedirect("deleteForm.jsp?num="+num+"&pageNum="+pageNum);

}//else

%>