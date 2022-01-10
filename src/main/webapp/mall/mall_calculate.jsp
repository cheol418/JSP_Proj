<%@page import="shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- order 결제하기 -> mall_calculate.jsp -->

<jsp:useBean id="mallCart" class="order.CartBean" scope="session"/>
<jsp:useBean id="order" class="order.ordersDao"/> 
<%
ArrayList<ProductBean> calList = mallCart.getAllProducts();

String id = (String)session.getAttribute("memid");
int memno = (Integer)session.getAttribute("memno");

int cnt = order.insertOrder(calList,memno);
String msg="", url="";
if(cnt >= 0){
	msg = "주문이 완료되었습니다.";
	url = "mall.jsp";
	mallCart.removeAllProduct();
}
else{
	msg = "주문에 실패했습니다.";
	url = "mall.jsp";
}
%>
<script type="text/javascript">
	alert("<%=msg%>"); 
	var answer = confirm('계속하시겠습니까?');
	if(answer){
		location.href="mall.jsp";
	}else{
		location.href="mall.jsp";
	}
	location.href="<%=url%>";
</script>
