<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>Community Register</title>

<form role="form" action="/community/register" method="post">
<input type = "hidden" name = "${_csrf.parameterName }" value = "${_csrf.token }">
	<div class="form-group">
		<label>제목</label><input class="form-control" name="c_title">
	</div>
	<div class="form-group">
		<label>글 내용</label>
		<textarea class="form-control" rows="3" name="c_content"></textarea>
	</div>
	<div class="form-group">
		<label>글 쓴이</label><input class="form-control" name="m_id" value='<sec:authentication property="principal.member.m_id"/>' readonly = "readonly"></input>
	</div>
	<button type="submit" class="btn_comm_submit btn btn_air">등록</button>
	<button type="reset" class="btn_comm_reset btn btn_air_white">초기화</button>
</form>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>