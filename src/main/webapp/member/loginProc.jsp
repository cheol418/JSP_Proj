<%@page import="member.memberBean"%>
<%@page import="member.memberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <!-- LoginForm 로그인 -> LoginProc.jsp -->
 
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	String contextPath = request.getContextPath();
	
	memberDao dao = memberDao.getInstance(); 
	memberBean bean = dao.getMemberInfo(id,pw); 
	String msg = null;
	String url = "";
	
	if(bean != null){
		
		String _id = bean.getId();
		int  no = bean.getNo(); 
		String name = bean.getName();
		msg = name;
		
		if(_id.equals("admin")){
			url = contextPath+"/admin/admin.jsp"; 
		}
		else{
			url = contextPath + "/mall/mall.jsp";
		}
		
		session.setAttribute("memid", _id); // memid="hong"
		session.setAttribute("memno", no); // memid="hong"
	}
	else{
		msg = "가입하지 않은 회원";
		url = contextPath + "/loginForm.jsp";
	}
%>
<script type="text/javascript">
	alert("'"+"<%=msg%>" + "' 회원님 환영합니다.");
	location.href="<%=url%>";
</script>
