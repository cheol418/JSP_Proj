<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../mall/mall_top.jsp" %> 
<%@ include file="color.jsp" %> <!-- color.jsp 포함시키는 include지시어 -->    

<link rel="stylesheet" type="text/css" href=style.css> <!-- 외부css파일 적용 -->

<script type="text/javascript" src=script.js></script>
<!--   외부 js파일 적용 -> src -->
<script type="text/javascript" src='./js/jquery.js'></script>
<!-- jquery 사용 -->

<script type="text/javascript">
function deleteSave(){
	if((document.delForm.passwd).value==""){
		alert("비밀번호를 입력하세요.");
		document.delForm.passwd.focus();
		return false;
	}
	else{
		
	}
}
</script>

<%
	int num=Integer.parseInt(request.getParameter("num"));
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	System.out.println("updateForm"+num);
	
	BoardDao dao = BoardDao.getInstance(); //싱글톤 객체

	
	SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<form method="post" name=delForm action=deleteProc.jsp?num=<%=num %> onSubmit="return deleteSave()">
	<input type="hidden" name="num" value="<%=num %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<table align=center width=350>
		<tr>
			<td align=center bgcolor=<%=value_c%>><b>비밀번호를 입력하세요.</b></td> 
		</tr>
		<tr>
			<td align="center">
				비밀번호:<input type="password" name=passwd maxlength=12 size=8>
			</td>
		</tr>
		<tr>
			<td align="center" bgcolor=<%=value_c%>>
				<input type="submit" value=글삭제 >
				<input type="button" value=글목록>
			</td>
		</tr>
	</table>
</form>
