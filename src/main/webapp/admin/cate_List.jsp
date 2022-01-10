<%@page import="shop.CategoryBean"%>
<%@page import="shop.CategoryDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../mall/mall_top.jsp"%>

		<table class="table table-striped">
			<caption><b>카테고리 목록</b></caption>
			<tr align="center">
				<th>번호</th>
				<th>카테고리 코드</th>
				<th>카테고리명</th>
			</tr>
		<%
		
		for(int i=0;i<lists.size();i++){ 
			CategoryBean cb = lists.get(i);
		%>
			<tr>
				<td><%=cb.getCnum()%></td>
				<td><%=cb.getCode()%></td>
				<td><%=cb.getCname()%></td>
			</tr>
		<%
		}
		%>
		</table>

