<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
	if(!confirm('피드백을 완료 하시겠습니까?')) return;
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
#submitBtn {
	width:130px;
	height:30px;
	border:0px;
	color: #fff;
	background-color: #C9BBCF;
	border-radius: 8px;
}
.logoutBtn {
  border-radius: 20px;
  border: 1px solid #FFFFFF;
  background-color: #C9BBCF;
  color: #FFFFFF;
  font-size: 12px;
  font-weight: bold;
  padding: 5px 10px;
  letter-spacing: 1px;
  text-transform: uppercase;
  transition: transform 80ms ease-in;
  
}

a {
	text-decoration: none;
}

</style>
<title>채점</title>
</head>
<body>
<header>
	<h2>[관리자 화면] 채점페이지</h2>
	<div style="float: right">
<label for="id">id</label>:<label id="id">${adminId}</label>
<button class="logoutBtn" type="button" onclick="javascript:location.href='/JavaWeb/lmsLogin?cmd=adminLogout';">로그아웃</button>
</div>
</header>
<main style="text-align:center; backgrount-color:#aaaaaa" >
<table>
	<tr>
		<td width="130px"><label><b>사용자아이디</b></label>&nbsp;&nbsp;${vo.userid}</td>
		<td width="100px"><label><b>과목번호</b></label>${vo.lms_num}</td>
		<td width="100px"><label><b>강의번호</b></label>${vo.lvl_code}</td>
		<td width="100px"><label><b>제출시간</b></label>${vo.test_date}</td>
	</tr>
</table>
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
				<input type="hidden" name="userid" value="${Status.userid}">
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
			<button id="submitBtn" type="submit">제출</button>
		</form>
		<p>
			<a href="lms">목록 보기</a>
	</main>
</body>
</html>