<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<style type="text/css">
</style>

<head>
<meta charset="utf-8">
<title>시험 화면</title>
<style type="text/css">
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
  margin:0 auto;
}

body {
	padding-top: 75px;
    background: #f6f5f7;
    overflow: hidden;
}

body, html {
  height: 200%;
}

* {
  box-sizing: border-box;
}

span {
	  margin:0 auto;
	  text-align:center;
}

section {
	margin: 10px;
	padding:10px;
	heigth:500px;
	width:600px;
	margin-left: auto;
    margin-right: auto;
}


input[type=text] {
	outline: none;
    display: block;
    background: rgba($black, 0.1);
    width:500px;
    height:30px;
    border: 0;
    border-radius: 4px;
    box-sizing: border-box;
    padding: 12px 20px;
    color: $gray;
    font-family: inherit;
    font-size: inherit;
    font-weight: $semibold;
    line-height: inherit;
    transition: 0.3s ease;

      &:focus {
        color: $dark-gray;
      }

      .two & {
        color: $white;

        &:focus {
          color: $white;
        }
      }
    }
    
 div.btn {
	width: 100%;
	text-align: center;
	display: block; 
}
    
    
button[type=submit] { 
	width:130px;
	height:30px;
	border:0px;
	color: #fff;
	background-color: #C9BBCF;
	border-radius: 8px;
}
.button {
	width:130px;
	height:30px;
	border:0px;
	color: #fff;
	background-color: #CFD2CF;
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

</style>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function() {
		$
				.ajax({
					url : '/JavaWeb/lms?cmd=getTest',
					method : 'post',
					data : {"lms_num":"${video.lms_num}"},
					dataType : 'json',
					cache : false,
					success : function(res) {
						for (var i = 0; i < res.length; i++) {
							$('#Q' + i).text(res[i].lms_tnum + '번 문제: ' + res[i].lms_question);
							if (i != 4) {
							$('#A' + i).text(res[i].lms_anum);
							}

							// 추가
							$("#lms_qid-" + res[i].lms_tnum).val(res[i].lms_qid);
							$("#lms_question-" + res[i].lms_tnum).val(res[i].lms_question);
							
							document.getElementById("A" + i).previousElementSibling.setAttribute("onchange","javascript:lms_anum("+ res[i].lms_tnum + ","+ res[i].lms_aid + ")");
							if (i != 4)
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
				data : $('#testForm').serialize(),
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
<header>
	<h2>TEST</h2>
	<nav>
		<span>사용자아이디&nbsp;&nbsp;${id}</span>
		<span>&nbsp;&nbsp;&nbsp;과목번호&nbsp;&nbsp;${video.lvl_code}</span>
		<span>&nbsp;&nbsp;&nbsp;강의번호&nbsp;&nbsp;${video.lms_num}</span>
	</nav>
	<div id="include" style="float: right">
			<%@include file="lmsLoginStatus.jsp"%>
		</div>
</header>
<main>
	<form id="testForm" action="javascript:sendForm();">
	<section>
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

		</section>
		<br>
		<section>
			<label><span id='Q0'></span></label>
		<br>
			<input type="radio" name="lms_anum-1"><span id='A0'></span><br>
			<input type="radio" name="lms_anum-1"><span id='A1'></span><br>
			<input type="radio" name="lms_anum-1"><span id='A2'></span><br>
			<input type="radio" name="lms_anum-1"><span id='A3'></span><br>
		</section>
		<br>
		<section>
			<label><span id='Q4'></span></label>
		<br>
			<input type="text" name="lms_anum-2"><span id='A4'></span><br>
		<br>
		</section>
		<section>
			<label><span id='Q5'></span></label> <br> <input type="radio"
				name="lms_anum-3"> <span id='A5'></span> <br> <input
				type="radio" name="lms_anum-3"> <span id='A6'></span> <br>
			<input type="radio" name="lms_anum-3"> <span id='A7'></span>
			<br> <input type="radio" name="lms_anum-3"> <span
				id='A8'></span> <br>
				</section>
		<br>
		<div class="btn">
			<button class="button" type="reset">취소</button>
			<button class="button" type="submit">제출</button>
		</div>
	</form>
</main>
</body>
</html>