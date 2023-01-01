<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>lmsJoin</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	function join() {
		$.ajax({
			url:"/JavaWeb/lms?cmd=joinUser",
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
		<form id="joinForm">
			<h3>회원가입</h3>
			<div>
				아이디<input name="id" type="text">
			</div>
			<div>
				비밀번호<input name="pwd" type="text">
			</div>
			<div>
				전화번호<input type="tel" name="phone">
			</div>
			<div>
				이메일<input type="email" name="email">
			</div>
		</form>
		<button type="button" onclick="javascript:join();">회원가입</button>
	</main>
</body>
</html>