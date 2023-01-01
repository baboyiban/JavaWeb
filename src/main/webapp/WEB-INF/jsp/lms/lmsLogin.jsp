<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>lmsLogin</title>
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

div.btn {
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
function login() {
	$.ajax({
		url : "/JavaWeb/lmsLogin?cmd=login",
		method : "post",
		data : $("#loginForm").serialize(),
		dataType : "json",
		cache : false,
		success : function(res) {
			alert(res.result);
			location.href="/JavaWeb/lms";
		},
		error : function(xhs, status, err) {
			alert(err);
		}
	});
}
</script>
</head>
<body>
<main>
	<h1>Login</h1>
	<p>
	<form id="loginForm">
			<div>
				아이디<input name="id" type="text">
			</div>
			<div>
				비밀번호<input name="pwd" type="password">
			</div>
				<div style="display:inline-block;width:fit-content;">
				<label for="user">사용자</label><input id="user" type="radio"
					name="who" value="user" checked>
				</div>
				<div style="display:inline-block;width:fit-content;">
					<label for="admin">관리자</label><input
					id="admin" type="radio" name="who" value="admin">
					<a href="/JavaWeb/lms?cmd=join">아직 회원이 아니신가요?</a>
				</div>
	</form>
	<p>
	<div class="btn">
		<button id="loginButton" type="button" onclick="javascript:login();">로그인</button>
	</div>
</main>
</body>
</html>