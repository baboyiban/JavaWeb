<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>lmsJoin</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Montserrat:400,800');
* {
  box-sizing: border-box;
}

body {
  background: #f6f5f7;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  font-family: 'Montserrat', sans-serif;
  height: 100vh;
  margin: -20px 0 50px;
}

h1 {
  font-weight: bold;
  margin: 0;
  text-align: center;
}

span {
  font-size: 12px;
}

button {
  border-radius: 20px;
  border: 1px solid #C9BBCF;
  background-color: #C9BBCF;
  color: #FFFFFF;
  font-size: 12px;
  font-weight: bold;
  padding: 12px 45px;
  letter-spacing: 1px;
  text-transform: uppercase;
  transition: transform 80ms ease-in;
}

div.btn{
	width: 100%;
	text-align: center;
	display: block; 
}


form {
  background-color: #FFFFFF;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 0 50px;
  height: 100%;
  text-align: center;
}

input {
  background-color: #eee;
  border: none;
  padding: 12px 15px;
  margin: 8px 0;
  width: 100%;
}

a {
	text-decoration: none;
}


</style>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<script type="text/javascript">
function check(){
	let j_form = document.joinForm;
	let id = j_form.id;
	let pw = j_form.pwd;
	let phone = j_form.phone;

	if(id.value == "" || id.value == null){
		alert("아이디는 필수 항목입니다.")
		id.focus();
		return false;
	}

	if(pw.value == "" || pw.value == null){
		alert("비밀번호는 필수 항목입니다.")
		pw.focus();
		return false;
	}
	if (pw.value.search(' ') != -1) {
		alert("비밀번호는 공백을 포함할 수 없습니다");
		pw.focus();
		return false;
	}
	
	let reg_pw = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~!@#$%^&*_-]).{7,}$/;
	if (!reg_pw.test(pw.value)) {
		alert("비밀번호는 7자 이상이여야 하며, 숫자와 대문자, 소문자, 특수문자 모두를 포함해야 합니다.");
		pw.focus();
		return false;
	}
	if (phone.value == "" || phone.value == null) {
		alert("핸드폰번호를 입력하세요!");
		phone.focus();
		return false;
	}
	let reg_Phone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
    if (!reg_Phone.test(phone.value)) {
        alert("핸드폰 번호를 확인해주세요.");
        phone.focus();
        return false;
    }
    
    if(phone.value.search('-') != -1){
    	alert("핸드폰 번호에는 -가 들어갈 수 없습니다.")
    	phone.focus();
    	return false;
    }  
    join();
}


	function join() {
		$.ajax({
			url:"/JavaWeb/lmsLogin?cmd=joinUser",
			method:"post",
			data:$("#joinForm").serialize(),
			cache:false,
			dataType:"json",
			success:function(res){
				alert(res.result);
				if(res.result=="회원가입 성공")
					location.href = "/JavaWeb/lms";
			},
			error:function(xhs,status,err){
				alert(err);
			}
		});
	}
</script>
</head>
<body>
	<main>
		<form id="joinForm" name="joinForm">
			<h3>회원가입</h3>
			<div>
				아이디<input name="id" type="text" placeholder='아이디'>
			</div>
			<div>
				비밀번호<input name="pwd" type="password" placeholder='비밀번호'>
			</div>
			<div>
				비밀번호 확인<input name="pwd_re" type="password" placeholder='비밀번호재확인'>
			</div>
			<div>
				전화번호<input type="tel" name="phone"  placeholder='(-)제외입력'>
			</div>
			<div>
				이메일<input type="email" name="email" placeholder='이메일주소'>
			</div>
		</form>
		<p>
		<div class="btn">
			<button type="button" onclick="javascript:check();">회원가입</button>
		</div>
	</main>
</body>
</html>