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

<!-- 폴더다운받은거 추가 하기-->

<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

<!-- fotorama.css & fotorama.js. -->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.css"
	rel="stylesheet">
<!-- 3 KB -->
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.js"></script>
<!-- 16 KB -->



<!-- 아이콘/font awesome -->
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link rel='stylesheet'
	href='https://use.fontawesome.com/releases/v5.7.0/css/all.css'>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- 날짜선택 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!--공통css -->
<link rel="stylesheet" href="/resources/css/header.css" />
<link rel="stylesheet" href="/resources/css/footer.css" />
<link rel="stylesheet" href="/resources/css/searchbar.css" />
<link rel="stylesheet" href="/resources/css/login.css" />

<script src="/resources/js/common.js"></script>
<script src="/resources/js/search.js"></script>

<!-- 검색 -->
<!-- 카카오api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<!-- fonts -->
<link href="https://fonts.googleapis.com/css?family=Oswald&display=swap"
	rel="stylesheet">
</head>
<body>
	<!-- 토큰!! -->
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
	<!--배경  -->
	<img id="bgAirMain" src="/resources/images/common/bg_air_main.jpg">

	<!-- 회원탈퇴했을때로그아웃시킬꺼 -->
	<div id="messageSignout">${message}</div>

	<!-- <div class="container-fluid"> -->
	<div id="sectionHeader" class="container-fluid">
		<div id="gnbAirTopright" class="container center-block bg_color_white">

			<sec:authorize access="isAnonymous()">
				<a href="/member/joinagree" class="pull-right color_air_deepgreen">SIGN
					IN</a>
				<a href="#" id="btnLogin" class="pull-right color_air_deepgreen"
					data-toggle="modal" onclick="clickLoginMenu()"
					data-target="#modalAir">LOGIN</a>
			</sec:authorize>

			<sec:authorize access="isAuthenticated()">
				<a href="/logout" onclick="clickLogoutBtn()"
					class="pull-right color_air_deepgreen">LOGOUT</a>
			</sec:authorize>
		</div>

		<div id="wrapLogo" class="container center-block bg_color_white">
			<input type="image" id="logoAir" class="center-block"
				onclick='location.replace("/main")'
				src="/resources/images/common/logo_aircamp_home.png"> <i
				id="iconMenu" onclick="clickMenuBtn()" class='fas fa-bars'></i>


		</div>



		<div id="gnbAir" class="container center-block bg_color_white">
			<div id="gnbAirToprightMobile">

				<sec:authorize access="isAnonymous()">

					<a href="#" id="btnLogin" class="gnb_air_menu" data-toggle="modal"
						onclick="clickLoginMenu()" data-target="#modalAir">LOGIN</a>
					<a href="#" class="gnb_air_menu">|</a>
					<a href="/member/joinagree" class="gnb_air_menu ">SIGN IN</a>
				</sec:authorize>
				<form id="formSecurityHidden">
					<input id="dataScurityHidden" type="hidden"
						name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>
				<sec:authorize access="isAuthenticated()">
					<a href="#" onclick="clickLogoutBtn()" class="gnb_air_menu">LOGOUT</a>
				</sec:authorize>
			</div>
			<a href="/home" class="gnb_air_menu color_air_deepgreen">HOME</a> <a
				href="/aboutus" class="gnb_air_menu color_air_deepgreen">ABOUT
				US</a> <a href="/item/all" class="gnb_air_menu color_air_deepgreen">ITEM</a>
			<a href="/community/list" class="gnb_air_menu color_air_deepgreen">COMMUNUTY</a>
			<a href="/contactus" class="gnb_air_menu color_air_deepgreen">CONTACT
				US</a>
			<!-- my page&LOGIN  -->
			<sec:authorize access="isAuthenticated()">
				<!-- mypage post로 가기위한거 -->
				<a id="menuMypage" class="gnb_air_menu color_air_deepgreen">MY
					PAGE</a>
				<form id="formMyPage" method="POST" action="#">
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token }"> <input type="hidden" name="myid"
						value=<sec:authentication property="principal.member.m_id" />>
					<input type="hidden" name="pageNum" value=1>
					<input type="hidden" name="amount" value=10>
				</form>
			</sec:authorize>
			<sec:authorize access="isAnonymous()">
				<a class="gnb_air_menu color_air_deepgreen"
					onclick="clickLoginMenu()" data-toggle="modal" href="#"
					data-target="#modalAir">MY PAGE</a>
			</sec:authorize>

		</div>
	</div>


	<div id="sectionSearchBar" class="container-fluid">
		<div id="barSearchMobile" class="container center-block">
			<i class='fas fa-search'></i> 위치, 날짜, 품목으로 검색하세요
		</div>
		<div id="wrapSearchBar" class="container center-block">
			<form id="formSearchBar" action="/item/search" method="get">
				<input type="hidden" name="pageNum" value="1"> 
				<input	type="hidden" name="amount" value="10"> 
				<div class="form-group col-sm-3 col-xs-12" id="wrapLocation">
					<i class='fas fa-map-marker-alt'></i> <input type="text"
						class="form-control" id="searchLocation" autocomplete="off"
						onclick="zipcodeSearchBar()" placeholder="위치를 입력하세요" name="iAddr">
				</div>
				<div class="form-group col-sm-2 col-xs-12" id="wrapSdate">
					<i class='far fa-calendar-alt'></i> <input type="text"
						class="form-control searchBarDate" id="searchStartDatepicker"
						autocomplete="off" name="iSdate">
				</div>

				<div class="form-group col-sm-2 col-xs-12" id="wrapEdate">
					<i class='far fa-calendar-alt'></i> <input type="text"
						class="form-control searchBarDate" id="searchEndDatepicker"
						autocomplete="off" name="iEdate">
				</div>

				<div class="form-group col-sm-2 col-xs-12" id="wrapKeyword">
					<i class="icon_empty fas fa-search"></i> <input type="text"
						class="form-control" id="searchKeyword" autocomplete="off"
						placeholder="검색어를 입력하세요" name="iTitle">
				</div>
				<div class="form-group col-sm-2 col-xs-12" id="wrapKeyword">
					<i class="icon_empty"></i>
					<button id="btnSearchbarSubmitMobile" class="btn btn_air">검색하기</button>
				</div>
			</form>
			<button id="btnSearchbarSubmit" class="">
				<i class='fas fa-search'></i>
			</button>
			<sec:authorize access="isAnonymous()">
				<a class="btn btn_air_red" id="btnHosting" data-toggle="modal"
					data-target="#modalAir" onclick="haveToLogin()">호스팅하기</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<a class="btn btn_air_red" id="btnHosting"
					onclick="clickBtnHosting()">호스팅하기</a>
			</sec:authorize>
		</div>
	</div>
	<sec:authorize access="isAnonymous()">
		<button id="btnHostingMobile" class="color_bg_red" data-toggle="modal"
			data-target="#modalAir" onclick="haveToLogin()">
			<i class="fa fa-plus"></i>
		</button>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
		<button id="btnHostingMobile" class="color_bg_red"
			onclick="clickBtnHosting()">
			<i class="fa fa-plus"></i>
		</button>
	</sec:authorize>
	<div id="sectionBody" class="container-fluid">
		<div id="wrapBody" class="container  center-block bg_color_white">