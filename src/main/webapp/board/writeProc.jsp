<%@page import="board.BoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
writeForm.jsp => writeProc.jsp(writeProc.java)<br>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bb" class="board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>
<!-- form=>5가지 -->
<%
bb.setReg_date(new Timestamp(System.currentTimeMillis()));
bb.setIp(request.getRemoteAddr());

BoardDao dao = BoardDao.getInstance();
int cnt = dao.insertArticle(bb);  
if(cnt>0){
	response.sendRedirect("list.jsp");
}
else{
	response.sendRedirect("writeForm.jsp");
}
%>




