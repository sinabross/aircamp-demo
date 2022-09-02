<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- css footer.css -->
<form id="formAirLogin" class="form-horizontal" method="post"
	action="/login">
	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token}">

	<div class="form-group" id="wrapLoginId">
		<label class="control-label col-sm-3" for="username">아이디</label>
		<div class="col-sm-6">
			<input type="text" class="form-control" id="loginId"
				placeholder="아이디를 입력하세요" name="username">
		</div>
		<div class="text_error_login"></div>
	</div>
	<div class="form-group" id="wrapLoginPassword">
		<label class="control-label col-sm-3" for="password">비밀번호</label>
		<div class="col-sm-6">
			<input type="password" class="form-control" id="loginPassword"
				placeholder="Enter password" name="password">
		</div>
		<div class="text_error_login"></div>
	</div>

</form>