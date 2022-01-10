<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDao"%>
<%@page import="shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="mall_top.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
	String[] spec = {"EVENT", "NEW", "BEST" , "SALE"};
	ProductDao pdao = ProductDao.getInstance();

	for(int i=0;i<spec.length;i++){
		ArrayList<ProductBean> plists = pdao.selectByPspec(spec[i]); 
		System.out.println(spec[i] +":"+plists.size()); 
		
		String specimg=request.getContextPath()+"/mall/img/"+spec[i];
	%>
		<div align="center" >
		<hr color=green width="60%" >
		<img src="<%=specimg %>.jpg" width="200" height="50">
		<hr color=green width="60%">
		</div>
	<%		
		if(plists.size()==0){
			out.print("<b>현재 판매중인 상품이 없습니다.</b>");
		}
		else{
	%>
			<table width="100%" border="0" align="center">
				<tr>
				<%
					int count=0;
					for( ProductBean bean : plists){
						count++;
						String pimage = bean.getPimage();
						int pnum = bean.getPnum(); 
						String pname = bean.getPname();
						int price = bean.getPrice();
						int point = bean.getPoint();
						String imgPath = request.getContextPath()+"/mall/img/"+pimage;
						
						%>
						<td align="center" width="200">
						<a href="mall_prodView.jsp?pnum=<%=pnum%>">
							<img src="<%=imgPath %>" width="120" height="80"><br>
						</a>
							<%=pname %> <br>
							<font color="red"><%=price %></font>원 <br>
							구매시 <font color="blue"><%=point %></font>point 적립 <br>
						</td>
				<%
						if(count % 4 == 0){
							out.print("</tr><tr>");
						} //if
					} // for
				%>
				</tr>
			</table>		
				<%			
		}
	} //for
%>	

</body>
</html>