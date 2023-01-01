<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
main {
	padding: 2em;
	float: left;
	width: 100%;
}

body {
	font-family: 'Open Sans', sans-serif;
	line-height: 1.42em;
}

h1 {
	font-family: 'Open Sans', sans-serif;
	text-align: center;
	position: relative;
	padding: 1rem 0.5rem;
}

h1::after {
	position: absolute;
	bottom: 0px;
	left: 0px;
	content: '';
	width: 100%;
	height: 6px;
	border-radius: 3px;
	background-image: -webkit-linear-gradient(right, #D6EFED 0%, #C9BBCF 100%);
	background-image: linear-gradient(to left, #C9BBCF 0%, #D6EFED 100%);
}

table {
	width: 1000px;
	text-align: center;
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 1.5;
	margin: 0 auto;
}

th {
	text-align: center;
	padding: 10px;
	font-weight: bold;
	vertical-align: bottom;
}

td {
	text-align: center;
	padding: 10px;
	vertical-align: bottom;
}

button {
	margin: 0 auto;
	width: 100%;
	text-align: center;
	display: block;
	width: 200px;
	height: 30px;
	border: 0px;
	color: #fff;
	background-color: #898AA6;
	border-radius: 8px;
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

      setTimeout(showbttn, 1000);
	});

	function showbttn(){
   	$('#test').show();
	} 

	function test() {
		location.href = "/JavaWeb/lms?cmd=test&lms_num=1.1";
	}
</script>
</head>
<body>
	<h1>학습 하기</h1>
	<div>
		<table>
			<tr>
				<td width="100px"><label><b>강의번호</b></label>&nbsp;&nbsp;&nbsp;
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