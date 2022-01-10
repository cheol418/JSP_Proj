<%@page import="board.BoardDao"%>
<%@page import="board.BoardBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../mall/mall_top.jsp" %> 
<!DOCTYPE html>
<%
	int pageSize = 10; 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:");
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum); 
	int startRow = (currentPage - 1) * pageSize + 1; 
	int endRow = currentPage * pageSize; 
	
	int count = 0;
	int number = 0;
	
	ArrayList<BoardBean> blists = null;
	
	int width=0;
	
	
	BoardDao dao = BoardDao.getInstance();
	count = dao.getArticleCount();
	
	if(count>0){
		blists = dao.getArticles(startRow,endRow);
		
	}
	number= count-(currentPage-1) * pageSize;
%>


<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
<h3>공지사항</h3>
</div>
<table border=1 width=700 align=center>
	<tr>
		<td align = right> 
			<a href="writeForm.jsp">글쓰기</a>
		</td>
	</tr>


</table>

<%
	if (count == 0){
		%>
		<table border=1 width=700 align=center>
			<tr >
				<td align=right>
				게시판에 저장된 글이 없습니다.
				</td>
			</tr>
		</table>
	<% }//if
	else{
	%>
		<table border=1 width=700 align=center>
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회</td>
				<td>IP</td>
			</tr>
		<%
				for(int i=0;i<blists.size();i++){
					BoardBean article = blists.get(i);
					
		%>
			
			<tr>
				<td><%=number-- %></td>
				<td>
					<%
						if(article.getRe_level()>0){
							width=20*article.getRe_level(); //답 20 답답 40 답답답 60
					%>
						<img src="images/level.gif" width=<%=width %> height=15/>
						<img src="images/re.gif" />
					
					<% 		
						}//if
						else{
					%>
						<img src="images/level.gif" width=5 height=15/>
						
					<%
							}//else
						
					%>
				
				<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum %>"><%=article.getSubject() %></a>
				<%
					if(article.getReadcount()>=10){
						%>
							<img src="images/hot.gif" height="15">
						<%
					}//if
				%>
				</td>
				<td><%=article.getWriter() %></td>
				<td><%=article.getReg_date() %></td>
				<td><%=article.getReadcount() %></td>
				<td><%=article.getIp() %></td>
			</tr>
		<%
				}//for
			
		%>
			
		</table>
		<div align="center">
		<% 
	}//else
		
	if(count>0){ // 37/
		int pageCount = count/pageSize + (count % pageSize == 0 ? 0:1); //3항연산자 
		int pageBlock = 10;
		
		int startPage = ((currentPage-1) / pageBlock*pageBlock)+1;
		int endPage = startPage + pageBlock -1 ;
		if (endPage>pageCount){
			endPage=pageCount;
		}
		
		if(startPage>10){
		%>
			<a href="list.jsp?pageNum=<%=startPage -10 %>">[이전]</a>
			
		<% 
		}//if
	
		for(int i=startPage;i<=endPage;i++){
		%>
			<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a>
		<% 
		}//for
		
		if(endPage<pageCount){
		%>
			<a href="list.jsp?pageNum=<%=startPage +10 %>" >[다음]</a>
		<% 
		}//if
		
	}
%>
</div>

</body>
</html>