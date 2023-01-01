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
main {
	width: fit-content;
	margin: 0px auto;
	text-align: center;
}

td {
	width: 50px;
	height: 10px;
	border: 1px solid black;
}

#lms_status {
	width: fit-content;
}

#lms_subject {
	width: fit-content;
}

#lms_lectur {
	width: fit-content;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	function start(lms_num) {
		$.ajax({
			url : "/JavaWeb/lms?cmd=learning&lms_num="+lms_num,
			method : "post",
			cache : false,
			data : "",
			dataType : "json",
			success : function(res) {
				alert(res.result);
				if (res.result == "학습을 시작합니다.")
					location.href = "/JavaWeb/lms?cmd=video&lms_num="+lms_num;
			},
			error : function(xhs, status, err) {
				alert(err);
			}
		});
	}
</script>
</head>
<body>
	<%@include file="lmsLoginStatus.jsp"%>
	<main>
		<h3>Welcome!</h3>
		<c:if test="${not empty listStatus}">
			<div id="lms_status">
				<h4>이용자 실습현황</h4>
				<table>
					<tr>
						<th>userid</th>
						<th>lvl_code</th>
						<th>lms_num</th>
						<th>test_date</th>
						<th>lms_tnum</th>
						<th>lms_qid</th>
						<th>lms_question</th>
						<th>lms_aid</th>
						<th>lms_anum</th>
						<th>t_feedback</th>
						<th>lms_scoring</th>
						<th>pass</th>
					</tr>
					<c:forEach var="status" items="${listStatus}">
					<tr>
						<td><label id="userid">${status.userid}</label></td>
						<td><label id="lvl_code">${status.lvl_code}</label></td>
						<td><label id="lms_num">${status.lms_num}</label></td>
						<td><label id="test_date">${status.test_date}</label></td>
						<td><label id="lvl_tnum">${status.lms_tnum}</label></td>
						<td><label id="lms_qid">${status.lms_qid}</label>
						<td><label id="lms_question">${status.lms_question}</label>
						<td><label id="lms_aid">${status.lms_aid}</label>
						<td><label id="lms_anum">${status.lms_anum}</label>
						<td><label id="t_feedback">${status.t_feedback}</label></td>
						<td><label id="lms_scoring">${status.lms_scoring}</label></td>
						<td><label id="pass">${status.pass}</label></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</c:if>
		<c:if test="${not empty listSubject}">
			<div id="lms_subject">
				<h4>lms_subject</h4>
				<table>
					<tr>
						<th>lvl_code</th>
						<th>subject_name</th>
						<th>description</th>
						<th>lms_lecture</th>
					</tr>
					<c:forEach var="subject" items="${listSubject}" varStatus="i">
						<tr>
							<td><label id="lvl_code${i.index}">${subject.lvl_code}</label></td>
							<td><label id="subject_name${i.index}">${subject.subject_name}</label></td>
							<td><label id="description${i.index}">${subject.subject_description}</label></td>
							<td><c:if test="${not empty mapListLecture}">
									<div id="lms_lecture${i.index}">
										<h5>lms_lecture</h5>
										<table>
											<tr>
												<th>lms_num</th>
												<th>lvl_code</th>
												<th>fname</th>
												<th>duration</th>
												<th>description</th>
											</tr>
											<c:forEach var="item" items="${mapListLecture[i.index]}"
												varStatus="j">
												<tr>
													<td><label id="lms_num${j.index}">${item.lms_num}</label></td>
													<td><label id="lvl_code${j.index}">${item.lvl_code}</label></td>
													<td><a id="fname${j.index}"
														href="javascript:start(${item.lms_num});">${item.fname}</a></td>
													<td><label id="duration${j.index}">${item.duration}</label></td>
													<td><label id="drscription${j.index}">${item.description}</label></td>
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