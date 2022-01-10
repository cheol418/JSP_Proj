<%@page import="shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>중앙 쇼핑</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <!-- 메뉴 오른쪽 아이콘 바 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="<%=request.getContextPath()%>/mall/mall.jsp">
			<img src="img/logo.png" width=100 height=20>
			</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="<%=request.getContextPath()%>/	mall/mall.jsp">홈</a>
				
				<%
				CategoryDao cdao = CategoryDao.getInstance();
				ArrayList<CategoryBean> lists = cdao.getAllCategory();
				
				for(CategoryBean cb : lists){
				%>
					
				<li><a href="<%=request.getContextPath()%>/mall/mall_cgList.jsp?code=<%=cb.getCode() %>&cname=<%=cb.getCname() %>">
						<%=cb.getCname() %>
					</a>
					
				<%					
				} // for
				%>
				<li><a href="<%=request.getContextPath()%>/board/list.jsp">문의 게시판</a>
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">로그인/회원가입<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="loginForm.jsp">로그인</a></li>
						<li><a href="regForm.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
		
		