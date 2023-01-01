<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>lmsMain</title>
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

header {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	height: 20px;
	padding: 1rem;
	color: white;
	background: #C9BBCF;
	font-weight: bold;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

h1, p {
	margin: 0;
	text-align: center;
	padding: 20px;
	font-family: 'Montserrat', sans-serif;
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

li {
	list-style-type: none;
	float: left;
	display: inline-block;
	padding: 10px;
	font-size: 20px;
}

#include {
	padding: 10px;
	font-size: 15px;
}

#mainnav {
	list-style-type: none;
	margin: 0 0 1em;
	padding: 8px 0 0 10px;
	white-space: nowrap;
	width: 100%;
}

a {
	display: block;
	text-align: center;
	margin: .25rem;
	padding: .5rem 1rem;
	text-decoration: none;
	font-weight: bold;
	color: black;
}

table {
	border-collapse: collapse;
	width: 100%;
	background-color: #F5F5F5;
}

th, td {
	padding: 10px;
	border-bottom: 1px solid #C9BBCF;
}

tr:hover {
	background-color: #C9BBCF;
}

#lms_status {
	width: fit-content;
	margin: 0px auto;
}

#lms_subject {
	width: fit-content;
	margin: 100px auto;
}

button {
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

div.btn{
	width: 100%;
	text-align: center;
	display: block; 
}
</style>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	function start(lms_num) {
		$.ajax({
					url : "/JavaWeb/lms?cmd=learning&lms_num=" + lms_num,
					method : "post",
					cache : false,
					data : "",
					dataType : "json",
					success : function(res) {
						alert(res.result);
						if (res.result == "학습을 시작합니다.")
							location.href = "/JavaWeb/lms?cmd=video&lms_num="+ lms_num;
					},
					error : function(xhs, status, err) {
						alert(err);
					}
				});
	}
</script>
</head>
<body>
	<header>
		<div id="include" style="float: right">
			<%@include file="lmsLoginStatus.jsp"%>
		</div>
	</header>
	<main>
		<c:if test="${not empty listStatus}">
			<h3 style="text-align: center">이용자 실습현황</h3>
			<div id="lms_status">
				<table>
					<tr>
						<th colspan='5' style="background-color:#eeeeee;">최근 제출 답안</tr>
					<tr>
						<th style="background-color:#eeeeee;">강의</th>
						<th style="background-color:#eeeeee;">문제</th>
						<th style="background-color:#eeeeee;">답</th>
						<th style="background-color:#eeeeee;">피드백</th>
						<th style="background-color:#eeeeee;">통과</th>
					</tr>
					<c:forEach var="status" items="${listStatus}">
						<tr>
							<td><label id="lms_num">${status.lms_num}</label></td>
							<td><label id="lms_question">${status.lms_question}</label>
							<td><label id="lms_anum">${status.lms_anum}</label>
							<td><label id="t_feedback">${status.t_feedback}</label></td>
							<td><label id="pass">${status.pass?'o':'x'}</label></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</c:if>
		<c:if test="${not empty listSubject}">
			<div id="lms_subject">
			<h3 style="text-align:center;">강의 목록</h3>
				<table>
					<tr>
						<th style="background-color:#eeeeee;">과목</th>
						<th colspan='3' style="background-color:#eeeeee;">강의</th>
					</tr>
					<c:forEach var="subject" items="${listSubject}" varStatus="i">
						<tr>
							<td><label id="subject_name${i.index}">${subject.subject_name}</label></td>
							<td><label id="description${i.index}">${subject.subject_description}</label></td>
							<td><c:if test="${not empty mapListLecture}">
									<div id="lms_lecture${i.index}">
										<table>
											<c:forEach var="item" items="${mapListLecture[i.index]}"
												varStatus="j">
												<tr>
													<td><label id="lms_num${j.index}">${item.lms_num}</label></td>
													<td><label id="description${j.index}"><a id="fname${j.index}" href="javascript:start(${item.lms_num});">${item.description}</a></label></td>
													<td><label id="duration${j.index}">${item.duration}</label></td>
												</tr>
											</c:forEach>
										</table>
									</div>
								</c:if></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</c:if>
	</main>
</body>
</html>