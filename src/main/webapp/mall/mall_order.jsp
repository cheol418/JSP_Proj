<%@page import="shop.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	tr{
		text-align: center;
	}
</style>    
<!-- 장바구니 목록보기(주문하기 클릭)=>mall_order.jsp -->
<%@include file="mall_top.jsp"%>

<jsp:useBean id="mallCart" class="order.CartBean" scope="session"/>
<%
DecimalFormat df = new DecimalFormat("###,###");  // 1,234,567,890,123 
ArrayList<ProductBean> orderLists = mallCart.getAllProducts();
%>
<table width="70%" align="center" border="1" class="outline">
	<tr align="center">
		<td colspan="3" align="center"><font size="5">주문 내역 보기</font></td>
	</tr>
	<tr align="center">
		<th width="40%">상품명</th>
		<th width="20%">수량</th>
		<th width="40%">금액</th>
	</tr>
	<%
		int cartTotalPrice = 0;
		for(ProductBean pd : orderLists){
	%>
			<tr>
				<td align="center"><%=pd.getPname() %></td>
				<td align="right"><%=pd.getPqty() %></td>
				<td align="right"><%=pd.getTotalPrice() %></td>
			</tr>
	<%			
			cartTotalPrice += pd.getTotalPrice();
		} // for
	%>
	<tr>
		<td colspan="3"  align="center">
			주문하신 금액은 <font color=red><%=df.format(cartTotalPrice) %>원</font>
		</td>
	</tr>
</table>
<br>
<div align="center">
<input type="button" value="결재하기" onClick="location.href='mall_calculate.jsp'">
</div>
