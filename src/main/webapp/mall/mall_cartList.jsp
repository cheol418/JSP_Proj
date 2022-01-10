<%@page import="shop.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- mall_cartList.jsp -->

<jsp:useBean id="mallCart" class="order.CartBean" scope="session"/>
<% 
String oqty = request.getParameter("oqty");
ArrayList<ProductBean> cAllList = mallCart.getAllProducts();
int cartTotalPrice = 0;
int cartTotalPoint = 0;
DecimalFormat df = new DecimalFormat("###,###");
%>

<%@include file="mall_top.jsp"%>

<table width="100%" border="1" align="center">
	<tr class="m2">
		<td colspan="6" align="center">
			<h4>장바구니 보기</h4>
		</td>
	</tr>
	<tr class="m1">
		<th width="10%">번호</th>
		<th width="20%">상품명</th>
		<th width="20%">수량</th>
		<th width="20%">단가</th>
		<th width="20%">금액</th>
		<th width="10%">삭제</th>
	</tr>
	<%
		if(cAllList.size()==0){
	%>
			<tr>
				<td colspan="6" align="center">장바구니에 담은 상품이 없습니다.</td>
			</tr>
	<%			
		}else{
			for( ProductBean pd : cAllList){
				String pimage = pd.getPimage();
				String imgPath = request.getContextPath()+"/mall/img/"+pimage;
	%>
				<tr>
					<td align="center"><%=pd.getPnum()%></td>
					<td align="center">
						<img src="<%=imgPath%>" width=100 height=50>
						<br><b><%=pd.getPname()%></b>
					</td>
					<td align="center">
						<form action="mall_cartEdit.jsp">
							<input type="text" name="oqty" size="1" value="<%=pd.getPqty()%>">개
							<input type="hidden" name="pnum" value="<%=pd.getPnum()%>">
							<input type="submit" value="수정">
						</form>
					</td>
					<td align="right">
						<%=pd.getPrice()%>원<br>
						[<%=pd.getPoint()%>]point<br>
					</td>
					<td align="center">
						<%=pd.getTotalPrice()%>원<br>
						[<%=pd.getTotalPoint()%>]point<br>
					</td>
					<td align="center">
						<a href="mall_cartDel.jsp?pnum=<%=pd.getPnum()%>">
						삭제
						</a>
					</td>
				</tr>			
	<%			
				cartTotalPrice += pd.getTotalPrice();
				cartTotalPoint += pd.getTotalPoint();
			} // for
	%>
			<tr>
				<td colspan="4">
					장바구니 총액: <%=df.format(cartTotalPrice) %>원<br>
					총 적립 포인트: [<%=df.format(cartTotalPoint) %>] point
				</td>
				<td colspan="2">
					<a href="mall_order.jsp">
						[주문하기] 
					</a>
				
				</td>
			</tr>			
	<%	
		}//else
	%>
</table>

