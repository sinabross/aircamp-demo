<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/contactus.css" />

<div id="boxContactusResult">
	<h2>전송되었습니다.</h2>
	<input type="text" value="${qna.m_id}" disabled>
	<input type="text" value="${qna.q_title}"disabled>
	 <input type="text" name="q_title" value="${qna.q_email}"	disabled>
	<textarea rows="9" disabled>${qna.q_content}</textarea>

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
