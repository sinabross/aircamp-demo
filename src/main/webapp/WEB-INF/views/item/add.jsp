<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/add.css" />


<div id="title_name">
	<h2>캠핑용품 등록하기</h2>
</div>

<div id="box">
	<div id="box_body">
		<form role="form" id="formItemAdd" action="/item/register"
			method="post">
			<!-- csrf -->
			<input type="hidden" id="csrf" name="${_csrf.headerName }"
				value="${_csrf.token }"> <input type="hidden" id="csrf2323"
				name="${_csrf.parameterName }" value="${_csrf.token }"> <input
				type="hidden" name="m_id"
				value=<sec:authentication property="principal.member.m_id"/>>

			<div>
				<label class="all_label">제목 </label> <input type="text"
					class="input_align" name="i_title" id="title">
			</div>
			<div id="i_title_check" class="input_align"></div>
			<div>
				<label class="all_label">시작날짜 </label> <input type="text"
					id="testDatepicker" class="input_datepic" name="i_sdate"
					readonly="readonly">
			</div>
			<div>
				<label class="all_label">종료날짜 </label> <input type="text"
					id="testDatepicker2" class="input_datepic" name="i_edate"
					readonly="readonly">
			</div>
			<div id="i_date"></div>
			<div>
				<label class="all_label">가격 </label> <input type="text"
					class="input_align" name="i_price" id="price">
			</div>
			<div id="i_price"></div>
			<div>
				<label class="all_label">소개 </label>
				<textarea rows="5" name="i_info" id="info"></textarea>
			</div>
			<div id="i_info"></div>
			<div>
				<label class="all_label">이메일</label> <input type="email"
					placeholder="선택" class="input_align" name="i_email" id="mail">
			</div>
			<div id="i_email"></div>
			<div>
				<label class="all_label">카톡아이디</label> <input type="email"
					class="input_align" placeholder="선택" name="i_katalk" id="katol">
			</div>
			<div id="i_katalk"></div>
			<div>
				<label class="all_label">연락처</label> 
				<input type="text"
					class="input_align" name="i_phone" id="input_item_add_phone">
			</div>
			<div id="i_phone"></div>
			<div>
				<label class="all_label">위치 </label> <input type="text"
					readonly="readonly" id="label_search" readonly name="i_addr"><input
					type="button" id="btnItemLocation" class="btn btn_air_white"
					onclick="addressGoogleAPI()" value="검색하기">
			</div>

			<!-- 파일첨부 -->
			<div class="filebox">
				<label class="all_label">사진 </label> <label id="btnItemPhoto"
					class="btn btn_air_white" for="btnItemAddFile">사진등록</label> <input
					type="file" id="btnItemAddFile" class="input_align" multiple
					name="uploadFile">
			</div>
			<!-- 파일업로드 할 목록 섬네일 -->
			<div class="">
				<div id="uploadResult">
					<div id="fileCheck"></div>
				</div>
			</div>
			<div id="uploadFile"></div>

			<div id="box_end">
				<a class="btn btn_air_white pull-left" href="/item/all">취소하기</a>
				<button type="submit" class="btn btn_air pull-right">등록하기</button>
			</div>
		</form>

	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<script src="/resources/js/add.js"></script>
