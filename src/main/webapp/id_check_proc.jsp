<%@page import="member.memberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userid = request.getParameter("userid");
	System.out.println("id_check_proc.jsp userid:" + userid);
	String str = "";
	
	member.memberDao dao = member.memberDao.getInstance();
	boolean flag = dao.searchId(userid); 
	if(flag == true){
		str = "NO";
		out.print(str);
	}else{
		str = "YES";
		out.print(str);
	}
%>
