<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/member.css" />
<input id="loginInJoin" type="hidden" value="${message}">
<div class="container">
	<div class="container-fluid ">
		<div id="content_join">
			<div id="login_wrap">
				<br>
				<h3>회원가입</h3>
				<br>
				<form action="/member/join" method="post" id="joinForm">
					<div class="pull-right"></div>
					<!-- 아이디 -->
					<div id="login_id" class="input-group input_login input_box">
						<img src="/resources/images/member/icon_coupang_04.png"> <input
							type="text" name="m_id" placeholder="아이디(필수)" id="input_id">

						<button class="btn btn_air btn_chk" id="btn_Idcheck">중복확인</button>
					</div>

					<div id="txt_id" class="txt_explain">아이디는 영문 4글자 이상입니다.</div>
					<div id="txt_id_2" class="txt_explain">중복된 아이디입니다.</div>

					<!-- 이름 -->
					<div id="login_name" class="input-group input_login input_box">
						<img src="/resources/images/member/icon_coupang_04.png"> <input
							type="text" name="m_name" placeholder="이름(필수)" id="input_name">

					</div>

					<div id="txt_name" class="txt_explain">이름을 입력하세요.</div>

					<!-- 카카오톡 -->
					<div id="login_kakao" class="input-group input_login input_box">
						<img src="/resources/images/member/icon_coupang_04.png"> <input
							type="text" name="m_katalk" placeholder="카카오톡아이디(선택)">
					</div>


					<!-- 이메일 -->
					<div id="login_email" class="input-group input_login input_box">
						<img src="/resources/images/member/icon_coupang_01.png"> <input
							type="text" name="m_email" placeholder="이메일(선택)" id="input_email">
					</div>

					<!--<div id="txt_id_1" class="txt_explain">이메일을 입력하세요.</div>-->
					<div id="txt_email" class="txt_explain">이메일 형식이 올바르지 않습니다.</div>

					<!--비밀번호  -->
					<div id="login_pw" class="input-group input_login input_box">
						<img src="/resources/images/member/icon_coupang_02.png"> <input
							type="password" name="m_pw"
							placeholder="비밀번호(영문 숫자 특수문자 2가지 이상 6~15자 이내)" id="input_pw">

					</div>

					<div id="txt_pw" class="txt_explain">비밀번호는 6~15자 이내로 입력하셔야
						합니다.</div>

					<!-- 비밀번호확인 -->
					<div id="login_pw_chk" class="input-group input_login input_box">
						<img src="/resources/images/member/icon_coupang_03.png"> <input
							type="password" placeholder="비밀번호 확인" id="input_pw_chk">

					</div>

					<div id="txt_pw_chk" class="txt_explain">비밀번호가 일치하지 않습니다.</div>

					<br> <br> <br>

					<!-- 휴대폰번호 -->
					<div id="login_phonenum" class="input-group input_login input_box">
						<img src="/resources/images/member/icon_coupang_05.png"> <input
							type="text" name="m_phone" placeholder="휴대폰 번호 010-0000-0000(필수)"
							id="input_phonenum">

						<button id="idnumber" class="btn btn_chk btn_air" disabled>인증번호
							전송</button>
					</div>

					<div id="txt_phonenum" class="txt_explain">휴대폰 번호를 정확하게
						입력하세요.</div>

					<!-- 인증번호 -->
					<div id="login_phone_chk" class="input-group input_login input_box">
						<img src="/resources/images/member/icon_coupang_05.png"> <input
							type="text" placeholder="인증번호" id="input_phonenum_chk">
						<button id="idnumber_chk" class="btn btn_chk btn_air">확인</button>
					</div>

					<div id="txt_phonenum_chk" class="txt_explain">인증번호확인.</div>

					<!-- 토큰 -->
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token }">

					<button type="submit" class="btn btn_air" id="btn_join">가입하기</button>
				</form>
			</div>
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<script src="/resources/js/member.js"></script>
