<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- mall_prodView.jsp(장바구니담기 버튼) => mall_cartAdd.jsp -->

<%
String pnum = request.getParameter("pnum");
String oqty = request.getParameter("oqty");
System.out.println(pnum+","+oqty);

ProductDao dao = ProductDao.getInstance();
ProductBean bean=dao.selectByPnum(Integer.parseInt(pnum));

if( Integer.parseInt(oqty) > bean.getPqty()){ 
%>
	<script type="text/javascript">
		alert('수량 초과');
		location.href="mall.jsp";
	</script>
<%
	
} // if
%>

<!-- 장바구니담기 -->

<!-- jsp 객체생성 세션설정 -->
<jsp:useBean id="mallCart" class="order.CartBean" scope="session"/>

<%
	mallCart.addProduct(pnum, oqty);  
	System.out.println("장바구니 담긴 상품 수:"+mallCart.clist.size());  
	response.sendRedirect("mall_cartList.jsp");
%>

