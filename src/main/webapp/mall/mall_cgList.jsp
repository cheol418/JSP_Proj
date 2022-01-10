<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="mall_top.jsp" %>  
    

<%@page import="java.util.ArrayList"%>


<%
	request.setCharacterEncoding("UTF-8");
	String code = request.getParameter("code");
	String cname = request.getParameter("cname");
	
	
	ProductDao pdao = ProductDao.getInstance();
	ArrayList<ProductBean> plists = pdao.getselectByCategory(code);  
	
%>

		<div align="center">
		<hr color=green width="80%">
		<font color=red size=3 align=center><strong><%=cname %></strong></font>
		<hr color=green width="80%">
		</div>
		
	<%		
		if(plists.size()==0){
			out.print("<b>" +cname+ " 상품 없습니다.</b>");
		}
		else{
	%>
			<table width="100%" border="0" align="center" valign=top>
				<tr>
				<%
					int count=0;
					for( ProductBean bean : plists){
						count++;
						String pimage = bean.getPimage();
						String pname = bean.getPname();
						int pnum = bean.getPnum();
						int price = bean.getPrice();
						int point = bean.getPoint();
						String imgPath = request.getContextPath()+"/mall/img/"+pimage;
						
						%>
						<td align="center">
							<a href="mall_prodView.jsp?pnum=<%=pnum%>">
							<img src="<%=imgPath %>" width="240" height="120"><br>
							</a>
							<%=pname %> <br>
							<font color="red"><%=price %></font>원 <br>
							<font color="blue"><%=point %></font>point <br>
						</td>
						<%
						if(count % 3 == 0){
							out.print("</tr><tr>");
						} //if
					} // for
				%>
				</tr>
			</table>			
	<%			
		}
%>
		
		

