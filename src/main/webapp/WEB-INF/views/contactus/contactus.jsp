<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/contactus.css" />

<div id="boxContactus">
	<h2>Contact Us</h2>

	<form method="post" action="/contactus">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}">
		<sec:authorize access="isAuthenticated()">
			<c:set var="email" value="principal.member.m_email" />
			<c:set var="name" value="principal.member.m_id" />
			<input type="text" name="m_id" placeholder="Name"
				value=<sec:authentication property="principal.member.m_id" />>

			<c:choose>

				<c:when test="${empty principal.member.m_email}">
					<input type="text" name="q_email" placeholder="Email">
					<div class="text_contactus_err"></div>
					<input type="text" name="q_email_confirm"
						placeholder="Confirm Email">
					<div class="text_contactus_err"></div>
				</c:when>
				<c:otherwise>
					<input type="text" name="q_email" placeholder="Email"
						value=<sec:authentication property="principal.member.m_email" />>
					<input type="text" name="q_email_confirm"
						placeholder="Confirm Email"
						value=<sec:authentication property="principal.member.m_email" />>

				</c:otherwise>
			</c:choose>
		</sec:authorize>

		<sec:authorize access="isAnonymous()">
			<input type="text" name="m_id" placeholder="Name">
			<div class="text_contactus_err">이름을 입력하세요.</div>
			<input type="text" name="q_email" placeholder="Email">
			<div class="text_contactus_err"></div>
			<input type="text" name="q_email_confirm" placeholder="Confirm Email">
			<div class="text_contactus_err"></div>
		</sec:authorize>
		<input type="text" name="q_title" placeholder="Title">
		<div class="text_contactus_err"></div>
		<textarea rows="9" name="q_content" placeholder="Content"></textarea>
		<div class="text_contactus_err"></div>

		<button type="submit" class="btn btn_air pull-right">보내기</button>
	</form>

</div>
<div id="boxContactInfo">


	<div>
		<i class="material-icons">email</i>
		<div class="text_contact_info">contactaircamp@gmail.com</div>
	</div>
	<div>
		<i class="fa fa-phone"></i>
		<div class="text_contact_info">070-1234-1234</div>
	</div>
	<div>
		<i class='fas fa-clock'></i>
		<div class="text_contact_info">am 10:00</div>
		<div class="fromto">~</div>
		<div class="text_contact_info">pm 04:00</div>
	</div>



</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<script src="/resources/js/contactus.js"></script>
