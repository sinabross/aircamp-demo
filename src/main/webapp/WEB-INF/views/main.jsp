<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>AIRCAMP</title>

<!-- Latest compiled and minified CSS -->
<!-- 폴더다운받은거 추가 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">


<!-- font awesome -->
<link rel='stylesheet'
	href='https://use.fontawesome.com/releases/v5.7.0/css/all.css'
	integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ'
	crossorigin='anonymous'>

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>




<!-- css header.css -->
<link rel="stylesheet" href="/resources/css/main.css" />

<!-- 공통 js common.js -->
<script src="/resources/js/common.js"></script>
<!-- fonts -->
<link href="https://fonts.googleapis.com/css?family=Oswald&display=swap"
	rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>AIRCAMP</title>
</head>
<body>
	<!-- 공용 modal 부분 -->
	<div class="modal " id="modalAir" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Modal Header</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>


	<div class="wrap_bg_main">
		<div class="bg_main">
			<div id="txtMain">
				<div>The Best Way</div>
				<div>To Find</div>
				<div>Camping Item</div>
			</div>
			<a href="/aboutus" id="btnGoHome">둘러보기</a>

			<sec:authorize access="isAnonymous()">
				<a id="btnGoHosting" href="#" data-toggle="modal" data-target="#modalAir"
					onclick="haveToLogin()">등록하기</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<a id="btnGoHosting" href="/item/add">등록하기</a>
			</sec:authorize>
<!-- 			<img id="logoMain" src="/resources/images/common/logo_aircamp.png">
 -->		
 			<img id="logoMain" src="/resources/images/common/logo_aircamp_main.png">
 
 </div>
	</div>

</body>
</html>