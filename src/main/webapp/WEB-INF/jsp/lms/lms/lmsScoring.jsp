<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<script type="text/javascript">
function formCheck(){
	var result = $('#result').val();
	console.log('formcheck');
	
	if(result=='')
	{
		alert('통과 여부를 입력해주세요');
		return false;
	}
	check();
	return false;
}

function check()
{
	console.log('check');
	if(!confirm('피드백을 종료하시겠습니까?')) return;
	var obj = $('#resultform').serialize();
	$.ajax({
		url:'lms',
		method:'post',
		cache:false,
		data:obj,
		dataType:'json',
		success:function(res){
			console.log(res.Status);
			alert(res.Status ? '저장 성공!':'저장 실패!');
			if(res.Status){
				location.href='lms?cmd=main';
			}
		},
		error:function(xhr,status,err){
			alert("에러:" + err);
		}
	});
	return false;
}
</script>
<style>
	header {
	position:fixed;
	top:0;
	left:0;
	right:0;
	
	height:75px;
	padding:1rem;
	color:white;
	background:#C9BBCF;
	font-weight:bold;
	display:flex;
	justify-content:space-between;
	align-items:center;
}

h2, p {
  margin: 0;
}

main {
  padding: 1rem;
  height: 100%;  
}

body {
	padding-top: 75px;
    background: #EEE;
    overflow: hidden;
}

body, html {
  height: 200%;
}

* {
  box-sizing: border-box;
}
textarea{
	resize: none;
}
table {
     border-collapse: collapse;
     width: 100%;
     background-color: #F5F5F5;
}
 th, td {
     padding: 10px;
     border-bottom: 1px solid #C9BBCF ;
}
tr:hover { background-color: #C9BBCF; }
button{
	width:130px;
	height:30px;
	border:0px;
	color: #fff;
	background-color: #C9BBCF;
	border-radius: 8px;
}
</style>
<title>채점</title>
</head>
<body>
<header>
	<h2>TEST</h2>
	<nav>
		<span>사용자아이디&nbsp;&nbsp;${vo.userid}</span>
		<span>&nbsp;&nbsp;&nbsp;과목번호&nbsp;&nbsp;${vo.lms_num}</span>
		<span>&nbsp;&nbsp;&nbsp;강의번호&nbsp;&nbsp;${vo.lvl_code}</span>
		<span>&nbsp;&nbsp;&nbsp;제출시간&nbsp;&nbsp;${vo.test_date}</span>
	</nav>
</header>
<main style="text-align:center; backgrount-color:#aaaaaa" >
<table>
</table>
	<h1>채점 페이지</h1>
		<form id="resultform" method="post" onsubmit="return formCheck();">
			<input type="hidden" name="cmd" value="result">
				<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd; margin:auto">
					<thead>
						<tr>
							<th style="background-color:#eeeeee; text-align: center;">번호</th>
							<th style="background-color:#eeeeee; text-align: center;">문제</th>
							<th style="background-color:#eeeeee; text-align: center;">답안</th>
							<th style="background-color:#eeeeee; text-align: center;">피드백</th>
						</tr>
					</thead>
				<tbody id="list">
				<c:forEach var="Status" items="${Status}" varStatus="i">
				<input type="hidden" name="lms_tnum${i.index}" value="${Status.lms_tnum}">
				<input type="hidden" name="lms_anum" value="${Status.userid}">
				<input type="hidden" name="lvl_code" value="${Status.lvl_code}">
				<input type="hidden" name="lms_num" value="${Status.lms_num}">
					<tr>
						<td>${Status.lms_tnum}번 답안</td>
						<td>${Status.lms_question}</td>
						<td>${Status.lms_anum}</td>
						<td><textarea rows="3" cols="20" name="feedback${i.index}">피드백</textarea></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>	
			<div></div><div></div>
			<div class="btn-group" data-toggle="buttons">
				<label class="btn btn-primary active" for="result">
					<input type="radio" name="result" autocomplete="off" value="1" checked>합격
				</label>
				<label class="btn btn-primary">
					<input type="radio" name="result" autocomplete="off" value="0">불합격
				</label>
			</div>
			<p>
			<button type="submit">제출</button>
			<a href="lms?cmd=list">목록 보기</a>
		</form>
	</main>
</body>
</html>