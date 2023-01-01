<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>lmsLogin</title>
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
		<h3>로그인</h3>
		<form id="loginForm">
			<div>
				아이디<input name="id" type="text">
			</div>
			<div>
				비밀번호<input name="pwd" type="password">
			</div>
			<div>
				<label for="user">사용자</label><input id="user" type="radio"
					name="who" value="user" checked><label for="admin">관리자</label><input
					id="admin" type="radio" name="who" value="admin">
			</div>
		</form>
		<button id="loginButton" type="button" onclick="javascript:login();">로그인</button>
		<button id="joinButton" type="button"
			onclick="javascript:location.href='/JavaWeb/lms?cmd=join';">회원가입</button>
	</main>
</body>
</html>