<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<h1>Sample Page</h1>
<h3>1. ojdbc6 익스터널 자르 확인!!</h3>
<sec:authorize access="isAuthenticated()">
	<h3>2. 로그인했음</h3>
	m_id: <sec:authentication property="principal.member.m_id" />
	<value=<sec:authentication property="principal.member.m_id" />>
</sec:authorize>
<sec:authorize access="isAnonymous()">
	<h3>2. 로그인안했음</h3>

	<h3>2.1. 로그인했을 때만 사용할 수 있는 기능을 사용하려고 할 때 로그인하는 모달을 여는 방법</h3>
	<h4>
		- <a href="#" data-toggle="modal" data-target="#modalAir"
			onclick="haveToLogin()">a태그로</a>
	</h4>
	<h4>
		-
		<button type="button" data-toggle="modal" data-target="#modalAir"
			onclick="haveToLogin()">버튼으로</button>
	</h4>
</sec:authorize>


<h3>3. Modal 사용할 때</h3>
$("#modal_air .modal-header").html('
<button type="button" class="close" data-dismiss="modal">&times;</button>
모달제목')
</br>
$("#modal_air .modal-body").html("modal-body부분")
</br>
$("#modal_air .modal-footer").html(`모달 버튼들
<button type="button" class="btn btn_air" data-dismiss="modal">닫기</button>
<button id="btn_login_submit" onclick="클릭하면 쓸 함수()" type="submit"
	class="btn btn_air flaot-right">버튼이름</button>
`)

<%@ include file="/WEB-INF/views/common/footer.jsp"%>

