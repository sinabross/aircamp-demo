<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<script src="/resources/js/member.js"></script>

<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
</script>
<div class="container-fluid">
	<div class="row ">
		<%@ include file="/WEB-INF/views/mypage/lnb.jsp"%>

		<div class="col-sm-9 ">
			<div id="content_join">
				<div id="login_wrap">
					<header></header>

					<!-- 프로필사진 -->

					<div id="uploadDiv">
						<div id="uploadimg">
							<c:choose>
								<c:when test="${empty member.m_path}">
									<img data-m_path="${member.m_path}"
										data-m_uuid="${member.m_uuid}"
										data-m_filename="${member.m_filename }"
										class="profile newfile"
										src="/resources/images/member/img_member_default.png">

								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${member.m_path!=null }">
									<img data-m_path="${member.m_path }"
										data-m_uuid="${member.m_uuid}"
										data-m_filename="${member.m_filename }"
										class="profile newfile" id="test1"
										src="/member/display?fileName=/s_${member.m_uuid}_${member.m_filename}">

								</c:when>
							</c:choose>
						</div>
						<label id="uploadLabel" class="btn btn_air">프로필사진 변경 <input
							id="uploadFile" type="file" name="uploadFile">
						</label>
					</div>

					<form action="/member/modify" method="post" id="joinForm">
						<div class="pull-right"></div>
						<!-- 아이디 -->
						<div id="login_id" class="input-group input_login input_box">
							<img src="/resources/images/member/icon_coupang_04.png"> <input
								type="text" name="m_id" placeholder="아이디" id="input_id" readonly
								value="${member.m_id }">


						</div>

						<div id="txt_id" class="txt_explain">아이디를 입력하세요.</div>


						<!-- 이름 -->
						<div id="login_name" class="input-group input_login input_box">
							<img src="/resources/images/member/icon_coupang_04.png"> <input
								type="text" name="m_name" placeholder="이름(필수)" id="input_name"
								value="${member.m_name }">

						</div>

						<div id="txt_name" class="txt_explain">이름을 입력하세요.</div>


						<!-- 카카오톡 -->
						<div id="login_kakao" class="input-group input_login input_box">
							<img src="/resources/images/member/icon_coupang_04.png"> <input
								type="text" name="m_katalk" placeholder="카카오톡아이디"
								value="${member.m_katalk }">
						</div>


						<!-- 이메일 -->
						<div id="login_email" class="input-group input_login input_box">
							<img src="/resources/images/member/icon_coupang_01.png"> <input
								type="text" name="m_email" placeholder="이메일" id="input_email"
								value="${member.m_email }">
						</div>

						<!--<div id="txt_id_1" class="txt_explain">이메일을 입력하세요.</div>-->
						<div id="txt_email" class="txt_explain">이메일 형식이 올바르지 않습니다.</div>

						<!--비밀번호  -->
						<div id="login_pw" class="input-group input_login input_box">
							<img src="/resources/images/member/icon_coupang_02.png"> <input
								type="password" name="m_pw"
								placeholder="비밀번호(영문 숫자 특수문자 2가지 이상 6~15자 이내)" id="input_pw"
								value="">

						</div>

						<div id="txt_pw" class="txt_explain">비밀번호는 6~15자 이내로 입력하셔야
							합니다.</div>

						<!-- 비밀번호확인 -->
						<div id="login_pw_chk" class="input-group input_login input_box">
							<img src="/resources/images/member/icon_coupang_03.png"> <input
								type="password" placeholder="비밀번호 확인" id="input_pw_chk">

						</div>

						<div id="txt_pw_chk" class="txt_explain">비밀번호가 일치하지 않습니다.</div>

						<!-- 휴대폰번호 -->
						<div id="login_phonenum" class="input-group input_login input_box">
							<img src="/resources/images/member/icon_coupang_05.png"> <input
								type="text" name="m_phone"
								placeholder="휴대폰 번호 010-0000-0000(필수)" id="input_phonenum"
								value="${member.m_phone}">

						</div>

						<div id="txt_phonenum" class="txt_explain">휴대폰 번호를 정확하게
							입력하세요.</div>

						<!-- 토큰 -->
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }">
						<button type="submit" class="btn btn_air" id="btn_modify">수정하기</button>
					</form>
				</div>
			</div>



		</div>
	</div>
</div>
<script>
	$(document).ready(function() {

		$(".menu_mypage_modify").addClass("active")
	})
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<script src="/resources/js/mypage.js"></script>
