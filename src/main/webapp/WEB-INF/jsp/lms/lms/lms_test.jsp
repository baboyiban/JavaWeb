<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<style type="text/css">
</style>

<head>
<meta charset="utf-8">
<title>시험 화면</title>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function() {
		$
				.ajax({
					url : '/JavaWeb/lms?cmd=getTest&lms_num=1.1',
					method : 'post',
					data : "",
					dataType : 'json',
					cache : false,
					success : function(res) {
						for (var i = 0; i < res.length; i++) {
							$('#Q' + i)
									.text(
											res[i].lms_tnum + '번 문제: '
													+ res[i].lms_question);
							$('#A' + i).text(res[i].lms_anum);

							// 추가
							$("#lms_qid-" + res[i].lms_tnum).val(res[i].lms_qid);
							$("#lms_question-" + res[i].lms_tnum).val(
									res[i].lms_question);
							document.getElementById("A" + i).previousElementSibling
									.setAttribute("onchange",
											"javascript:lms_anum("
													+ res[i].lms_tnum + ","
													+ res[i].lms_aid + ")");
							document.getElementById("A" + i).previousElementSibling.value = res[i].lms_anum;
							//
						}
					},
					error : function(xhs, status, err) {
						alert(err);
					}
				});
	});

	function sendForm() {
		var obj = $('#testForm').serialize();
		console.log($('#testForm').serialize());
		if (confirm('정말 제출하시겠습니까?'))
			$.ajax({
				url : '/JavaWeb/lms?cmd=addans',
				method : 'post',
				cache : false,
				data : obj,
				dataType : 'json',
				success : function(res) {
					alert(res.submitted ? '제출 성공' : '제출 실패');
					if (res.submitted)
						location.href = 'lms?cmd=main'; //메인페이지로 이동 
				},
				error : function(xhr, status, err) {
					alert('에러:' + err);
				}
			});
		return false;
	}
	// 추가 
	function lms_anum(lms_tnum, lms_aid) {
		document.getElementById("lms_aid-" + lms_tnum).value = lms_aid;
	}
</script>
</head>
<body>
	<h5>사용자 아이디: ${id}</h5>
	<h5>과목 번호: ${video.lvl_code}</h5>
	<h5>강의 번호: ${video.lms_num}</h5>
	<h3>시험 문제</h3>
	<form id="testForm" action="javascript:sendForm();">
		<input type="hidden" name="userid" value="${id}"> <input
			type="hidden" name="lvl_code" value="${video.lvl_code}"> <input
			type="hidden" name="lms_num" value="${video.lms_num}"> <input
			type="hidden" id="lms_qid-1" name="lms_qid-1"> <input
			type="hidden" id="lms_qid-2" name="lms_qid-2"> <input
			type="hidden" id="lms_qid-3" name="lms_qid-3"> <input
			type="hidden" id="lms_question-1" name="lms_question-1"> <input
			type="hidden" id="lms_question-2" name="lms_question-2"> <input
			type="hidden" id="lms_question-3" name="lms_question-3"> <input
			type="hidden" id="lms_aid-1" name="lms_aid-1"> <input
			type="hidden" id="lms_aid-2" name="lms_aid-2"> <input
			type="hidden" id="lms_aid-3" name="lms_aid-3">

		<p>
			<label><span id='Q0'></span></label>
		<p>
			<input type="radio" name="lms_anum-1"><span id='A0'></span><br>
			<input type="radio" name="lms_anum-1"><span id='A1'></span><br>
			<input type="radio" name="lms_anum-1"><span id='A2'></span><br>
			<input type="radio" name="lms_anum-1"><span id='A3'></span><br>
		<p>
			<label><span id='Q4'></span></label>
		<p>
			<input type="text" name="lms_anum-2"><span id='A4'></span><br>
		<p>
			<label><span id='Q5'></span></label> <br> <input type="radio"
				name="lms_anum-3"> <span id='A5'></span> <br> <input
				type="radio" name="lms_anum-3"> <span id='A6'></span> <br>
			<input type="radio" name="lms_anum-3"> <span id='A7'></span>
			<br> <input type="radio" name="lms_anum-3"> <span
				id='A8'></span> <br>
		<p>
		<div>
			<button type="reset">취소</button>
			<button type="submit">제출</button>
		</div>
	</form>
</body>
</html>