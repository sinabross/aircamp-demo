<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="container-fluid">
	<div class="row">
		<%@ include file="/WEB-INF/views/mypage/lnb.jsp"%>
		<div class="col-sm-9 ">
			<div id="titleMemberModifyCheck" class="title_mypage_sub">회원정보 수정 비밀번호 확인</div>

			<form id="formMemberModifyCheck" action="/mypage/pwcheck"
				method="post">

				<input type="hidden" name="myid"
					value="<sec:authentication property="principal.member.m_id" />">
				<input type="password" name="m_pw" placeholder="비밀번호 확인">
				<button  type="submit" class="btn btn_air">확인</button>


				<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token }">

			</form>
			<h2>${message }</h2>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {

		$(".menu_mypage_modify").addClass("active")
	})
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<script src="/resources/js/member.js"></script>
<script src="/resources/js/mypage.js"></script>
