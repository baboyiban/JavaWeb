<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[admin]시험결과 리스트</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function(){
		var pass = $('#pass').text();
		console.log(pass);
	});

</script>
<Style type="text/css">

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
    background: #f6f5f7;
}

body, html {
  height: 200%;
}

* {
  box-sizing: border-box;
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

a {
	text-decoration: none;
}
#logoutBtn {
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
</Style>
<body>
<header>
	<h2> [관리자 화면] 시험결과</h2>
	<div style="float: right">
	<label for="id">id</label>:<label id="id">${adminId}</label>
	<button id="logoutBtn" type="button" onclick="javascript:location.href='/JavaWeb/lmsLogin?cmd=adminLogout';">로그아웃</button>
	</div>
</header>
<main>
<table>
	<thead>
		<tr>
			<th width="80em" style="background-color:#eeeeee;">회원ID</th>
			<th width="40em" style="background-color:#eeeeee;">과목</th>
			<th width="80em" style="background-color:#eeeeee;">강의번호</th>
			<th width="240em" style="background-color:#eeeeee;">시험제출일</th>
			<th width="120em" style="background-color:#eeeeee;">채점</th>
			<th width="80em" style="background-color:#eeeeee;">통과여부</th>					
		</tr>	
	</thead>
	<tbody>
	<c:forEach var="s" items="${list}">
		<tr>
			<th>${s.userid}</th>
			<th>${s.lms_num}</th>
			<th>${s.lvl_code}</th>
			<th>${s.test_date}</th>
			<th><a href="/JavaWeb/lms?cmd=scoring&userid=${s.userid}&lms_num=${s.lms_num}&lvl_code=${s.lvl_code}">
				<c:choose>            
            <c:when test="${empty s.t_feedback}"> 피드백 작성
            </c:when>
            <c:otherwise>수정
            </c:otherwise>
            </c:choose>
			</th>
			<th id="pass">${s.pass}</th>					
		</tr>	
	</c:forEach>
	</tbody>
</table>

</main>

</body>
</html>