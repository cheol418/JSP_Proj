<%@page import="member.memberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
%> 

<jsp:useBean id="bean" class="member.memberBean"/>
<jsp:setProperty property="*" name="bean"/> 
    
<%
	memberDao dao = memberDao.getInstance();
	int cnt = dao.insertMember(bean);  
	String msg="",url="";
	
  if(cnt>=0){
       msg="회원 가입 성공";
       url = "loginForm.jsp";
    }else{
       msg="회원 가입 실패";
       url = "regForm.jsp";
    }
%>

<script type="text/javascript">
   alert("<%=msg%>");   
   location.href="<%=url%>";
</script>