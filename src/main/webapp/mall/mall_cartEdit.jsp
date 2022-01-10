<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_cartList.jsp->mall_cartEdit.jsp 장바구니 주문수량 수정<br> -->
<%
	request.setCharacterEncoding("UTF-8");
	String pnum = request.getParameter("pnum");
	String oqty = request.getParameter("oqty");
	
	ProductDao pdao = ProductDao.getInstance();
	ProductBean bean = pdao.selectByPnum(Integer.parseInt(pnum));
	
	if(bean.getPqty() < Integer.parseInt(oqty)){
		%>
		<script type="text/javascript">
		alert("주문가능한 수량 초과");
		//history.go(-1); //잘못쓴 숫자가 남아있음. 입력값위치에
		location.href="mall_cartList.jsp";
		</script>		
		<%
		return;
	}//if
	
%>

<jsp:useBean id="mallCart" class="order.CartBean" scope="session"/>
<%
	mallCart.setEdit(pnum,oqty); 
	
%>
<script type="text/javascript">
	alert("수정되었습니다.")
	location.href="mall_cartList.jsp";
</script>


