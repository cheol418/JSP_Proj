<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--mall_cartList삭제 -> mall_cartDel.jsp<Br> -->

<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));
%>

<jsp:useBean id="mallCart" class="order.CartBean" scope="session"/>

<%
	mallCart.removeProduct(pnum);
	response.sendRedirect("mall_cartList.jsp");
%>

