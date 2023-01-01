<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<script type="text/javascript">
	function logout() {
		$.ajax({
			url:"/JavaWeb/lmsLogin?cmd=logout",
			method:"post",
			data:"",
			cache:false,
			dataType:"json",
			success:function(res){
				alert(res.result);
				location.href="/JavaWeb/lms";
			},error:function(xhs,status,err){
				alert(err);
			}
		});
	}
</script>
<div>
<label for="id">id</label>:<label id="id">${id}</label>
<button class="logoutBtn" type="button" onclick="javascript:logout();">로그아웃</button>
</div>