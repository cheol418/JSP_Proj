<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="mall_top.jsp" %>  

<script type="text/javascript">
	function goCart(pnum){ // 장바구니 담기
		oqty = document.f.oqty.value;
		if(oqty == "" || oqty<1){
			alert('수량 입력 누락 또는 1보다 작은 수 입력');
			location.href="mall.jsp";
			return;
		}

		location.href="mall_cartAdd.jsp?pnum="+pnum+"&oqty="+oqty;

	}
	
	function goOrder(pnum){ // 구매
		oqty = document.f.oqty.value;
		if(oqty == "" || oqty<1){
			alert('수량 입력 누락 또는 1보다 작은 수 입력');
			location.href="mall.jsp";
			return;
		}

		location.href="mall_directOrder.jsp?pnum="+pnum+"&oqty="+oqty;

	}
</script>
    
<%
	String pnum = request.getParameter("pnum");
	ProductDao pdao = ProductDao.getInstance();
	ProductBean bean = pdao.selectByPnum(Integer.parseInt(pnum)); 
	String pimage = bean.getPimage();
	String imgPath = request.getContextPath()+"/mall/img/"+pimage;
	
	
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border=0 width="80%" class="outline" >
	<tr align="left"> 
		<td colspan="2" align="left">
			<font color=blue size=5><b>[<%=bean.getPname() %>] 상품 정보</b></font>
	<br><br>
		</td>
	</tr>
	<tr> <!-- 두번째줄 -->
		<td align="center" width="40%">
			<img src="<%=imgPath %>" width="240" height="120">
		</td>
		<td width="60%" align="left" >
			<form name="f">
				상품번호:<%=pnum %><br>
				상품이름:<%=bean.getPname() %><br>
				상품가격:<font color=red><%=bean.getPrice() %></font><br>
				상품포인트:<font color=blue><%=bean.getPoint() %></font><br>
				상품갯수: <input type="text" name="oqty" size="2" value="1">개<br>
				<br>
				<table border="0" align="center" width="90%">
					<tr>
						<td width=160>
						<!-- <a href="" onclick="goCart()"> -->
						<a href="javascript:goCart(<%=pnum %>)">
							<img src="<%=request.getContextPath() %>/img/cart.png"
							 width="120" height="40">
						</a>
						</td>
						<td>
						<a href="javascript:goOrder(<%=pnum %>)">
							<img src="<%=request.getContextPath() %>/img/order.png"
							 width="120" height="40">
							 </a>
						</td>
					</tr>
				</table>
			</form>
		</td>
	</tr> <!-- 2번째 줄 끝 -->
	<tr height="200" valign="top">
		<td colspan="2" align="left">
			<b align="center" size=4>상품 상세 설명</b><br>
			<%=bean.getPcontents() %>
		</td>
	</tr>
</table>
</body>
</html>