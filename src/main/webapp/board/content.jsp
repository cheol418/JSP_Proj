<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardDao"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jsp" %>  
<%@ include file="../mall/mall_top.jsp" %>  

<%
	int num=Integer.parseInt(request.getParameter("num"));
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	System.out.print(num+"/"+pageNum);
	
	BoardDao dao = BoardDao.getInstance(); //싱글톤 객체

	BoardBean article = dao.getArticle(num);  

	String writer = article.getWriter();
	String subject = article.getSubject();
	String content = article.getContent();
	Timestamp reg_date = article.getReg_date();
	long readcount = article.getReadcount();
	
	SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	int ref = article.getRef();
	int re_step = article.getRe_step();
	int re_level = article.getRe_level();
			
%>
<Script>
function Go_list(pn){
	//alert(1);
	alert(pn);
	location.href="list.jsp?pageNum="+pn;
}


</Script>

<link rel="stylesheet" type="text/css" href=style.css> <!-- 외부css파일 적용 -->

<style type="text/css">
	body{
		align:center;
		text-align: center;
	}
</style>

<b>공지 사항</b>

<form>
<table border=1 width = 500 align=center bgcolor=<%=bodyback_c%>> 
  <tr>
    <td align=center bgcolor ="<%=value_c%>">글번호</td>
    <td align=center><%=num %></td>
    <td align=center bgcolor ="<%=value_c%>">조회수</td>
    <td align=center><%=readcount %></td>
  </tr>
  <tr>
    <td align=center bgcolor ="<%=value_c%>">작성자</td>
    <td align=center><%=writer %></td>
    <td align=center bgcolor ="<%=value_c%>">작성일</td>
    <td align=center><%=sdf.format(reg_date) %></td>
  </tr>
  <tr>
    <td align=center bgcolor ="<%=value_c%>">글 제목</td>
    <td align=center colspan=3><%=subject %></td>
  </tr>
  <tr>
    <td align=center height=50 bgcolor ="<%=value_c%>">글 내용</td>
    <td colspan=3 align=center><%=content %></td>
  </tr>
  <tr>
    <td colspan=4 align=center bgcolor ="<%=value_c%>">
   		<input type="button" value=글삭제 onClick="window.document.location.href='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
   		<input type="button" value=답글쓰기 onClick="document.location.href='replyForm.jsp?ref=<%=ref%>&re_step=<%= re_step %>&re_level=<%= re_level %>'">
		<input type="button" value=글목록 onClick="Go_list(<%=pageNum%>)">
    </td>
			
  </tr>
</table>
</form>


