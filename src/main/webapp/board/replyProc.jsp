<%@page import="board.BoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
replyProc.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 부모(3) + 자식(5) -->

<!-- 8가지 묶음 -->
<jsp:useBean class="board.BoardBean" id="bb"/> 
<jsp:setProperty name="bb" property="*" />

<!-- 
날짜
IP
10가지 묶음 -->
<%
bb.setReg_date(new Timestamp(System.currentTimeMillis()));
bb.setIp(request.getRemoteAddr());
BoardDao dao = BoardDao.getInstance();
dao.replyArticle(bb); 
/* response.sendRedirect("list.jsp"); */
%>

<jsp:forward page="list.jsp"/>

