<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학습하기</title>
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
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


#test { 
	margin:0 auto; 
	width: 100%;
	text-align: center;
	display: block; 
	width:200px;
	height:30px;
	border:0px;
	color: #fff;
	background-color: #898AA6;
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

$(function(){
	
    $('#test').hide();
    
    var duration = "${video.duration}";
      const min_sec = duration.split(":");
      
      var min = parseInt(min_sec[0]);
      var sec = parseInt(min_sec[1]);
      
      var finaldur = (min*60 + sec)*1000;

      setTimeout(showbttn, 5000);
	});

	function showbttn(){
   	$('#test').show();
	} 

	function test() {
		location.href = "/JavaWeb/lms?cmd=test&lms_num=${video.lms_num}";
	}
</script>
</head>
<body>
<header>
	<h1>학습 하기</h1>
	<div id="include" style="float: right">
			<%@include file="lmsLoginStatus.jsp"%>
	</div>
</header>
	<div>
		<table>
			<tr>
				<td width="130px"><label><b>강의번호</b></label>&nbsp;&nbsp;&nbsp;
					${video.lms_num}</td>
				<td width="100px"><label><b>과목레벨</b></label>&nbsp;&nbsp;&nbsp;${video.lvl_code}
				</td>
				<td><label style="font-size: 1.5em;"><b>${video.description}</b></label>
				</td>
				<td width="140px"><label><b>강의시간</b></label>&nbsp;&nbsp;&nbsp;${video.duration}
				</td>
			</tr>
		</table>
	</div>
	<p>
	<div id="player">
		<p align="middle">
			<iframe width="1000" height="700" src="${video.fname}" title="player"
				name="player" frameborder="0"
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"allowfullscreen">
				<p>
			</iframe>
	</div>
	<div>
		<button id="test" type="button" onclick="javascript:test();">수강완료</button>
	</div>

</body>
</html>