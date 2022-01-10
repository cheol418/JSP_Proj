<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/script.js"></script>
<Script type="text/javascript">
	$(document).ready(function(){
		//alert(1);
		var isCheck = false; //중복체크 확인용
		var use="";
		var isChange = false;
		var isBlank = false;
		
		$('input[name="id_check"]').click(function(){ // 중복체크
			//alert(1);
			isCheck = true;
			isChange = false;
			
			if($('input[name="id"]').val()==""){
				alert("아이디를 입력하세요");
				$('input[name=id]').focus();
				isBlank=true; //아이디에 입력값이 없으면 true
				return;
			}
			
			/* if(isCheck==false || isChange == true){
				alert("중복체크 하세요");
				isCheck==true;
				return false; //action로 못넘어가게 막음.
			} */
			
			$.ajax({
				url : "id_check_proc.jsp",
				data : ({
					userid : $('input[name="id"]').val()// userid=kim
				}),
				success:function(data){
					alert(data+","+$.trim(data).length);
					  
					if($.trim(data)=='YES'){
						$('#idmessage').html("<font color=blue>사용가능한 ID입니다.</font");
						$('#idmessage').show(); 
						use = "possible";
					}
					else{
						$('#idmessage').html("<font color=red>이미 사용중인 ID입니다.</font");
						$('#idmessage').show(); 
						use = "impossible";
					}
				}//success
			});//ajax
			
		});//중복체크
		
		 $('input[name="id"]').keydown(function(){
				$('#idmessage').css('display','none');
				isChange = true;
				use="";
		 });
		
		$('#sub').click(function(){//가입하기 클릭
			if(use=="impossible"){
				alert("이미 사용중인 아이디입니다.(submit)");
				return false;
			}
		
			else if(isCheck==false || isChange == true){
				alert("중복체크 하세요");
				isCheck==true;
				return false; //action로 못넘어가게 막음.
			}
			else if(isBlank==true){
				alert("아이디를 입력하세요");
				$('input[name=id]').focus();
				isBlank=true; //아이디에 입력값이 없으면 true
				return false;
			}
			
			if($('input[name="pw"]').size < 6) {
				alert("비밀번호는 6자 이상으로 하세요");
				$('input[name=pw]').focus();
				return false;
			}
		
		});	//sub
	
	
	});// ready
</script>

<%@ include file="login_top.jsp" %>

	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="regProc.jsp">
					<h3 style="text-align: center;">회원가입</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="id" maxlength="20">
						<span id = "idmessage" style="display:none;">123</span>
					</div>
					<div class="form-group" style="text-align: center;">
				
						<input type="button" class="btn btn-primary from-control" name="id_check" value="ID 중복 체크" onClick="">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호 (6자이상)" name="pw" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="name" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="생년월일 (6자리)" name="b_date" maxlength="6" size="6">
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input type="radio" name="gender" autocomplete="off" value="남자" checked>남자
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="gender" autocomplete="off" value="여자" checked>여자
							</label>
						</div> 
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="email" maxlength="50">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="전화번호 (-제외)" name="phone" maxlength="12">
					</div>
					<div class="form-group" style="text-align: center;">
					<input type="submit" class="btn btn-primary from-control" id="sub" value="회원가입" align=center>
					</div>
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
</body>
</html>