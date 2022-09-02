/**
 * 공통으로 사용되는 js
 */
// 로그인 메뉴 버튼(btn_air_login) 클릭시 로그인 모달의 내용을 바꾸고 모달창을 키는 함수
function clickLoginMenu() {
	$("#modalAir .modal-header")
			.html(
					'<button type="button" class="close" data-dismiss="modal">&times;</button><h3>로그인</h3>')
	$("#modalAir .modal-body").load('/loginGet')
	$("#modalAir .modal-footer")
			.html(
					'<button type="button" class="btn btn_air pull-left" onclick="clickFindIdBtn()"  data-dismiss="modal">아이디 찾기</button><button type="button" class="btn btn_air pull-left" onclick="clickFindPwBtn()" data-dismiss="modal">비밀번호 찾기</button><button id="btn_login_submit" onclick="submitLogin()" type="submit" class="btn btn_air flaot-right">로그인</button>')
}
// 로그인해야 사용할 수 있는 기능인데 로그인이 안되어있을경우에 쓰는 함수
function haveToLogin() {
	$("#modalAir .modal-header")
			.html(
					'<button type="button" class="close" data-dismiss="modal">&times;</button><h3>로그인하세요</h3>')
	$("#modalAir .modal-body").load('/loginGet')
	$("#modalAir .modal-footer")
			.html(
					'<button type="button" class="btn btn_air pull-left" onclick="clickFindIdBtn()"  data-dismiss="modal">아이디 찾기</button><button type="button" class="btn btn_air pull-left" onclick="clickFindPwBtn()" data-dismiss="modal">비밀번호 찾기</button><button id="btn_login_submit" onclick="'
							+ "location.href='/member/joinagree'"
							+ '" type="button" class="btn btn_air flaot-right">회원가입</button><button id="btn_login_submit" onclick="submitLogin()" type="submit" class="btn btn_air flaot-right">로그인</button>')
	return false
}
function clickBtnHosting() {
	console.log("btnHosting Clicked")
	location.replace('/item/add')
}
// 로그인하기 버튼(btn_login_submit)을 누름
function submitLogin() {
	console.log("login")

	$.ajax({
		url : '/login',
		data : $('#formAirLogin input').serialize(),
		type : 'POST',
		dataType : 'json',

		success : function(result) {
			$("#modalAir").modal("hide")
			if (result.message === "success") {
				// $("#modal_air").modal("hide")
				location.reload()
			}
			if (result.message === "fail" && result.reason === "nomember") {
				$("#wrapLoginPassword .text_error_login").html(" ")
				$("#modalAir").modal("show")

				$("#loginId ").focus()
				$("#wrapLoginId .text_error_login").text("존재하지 않는 아이디입니다.")

			}
			if (result.message === "fail" && result.reason === "wrongpass") {
				$("#wrapLoginId .text_error_login").html(" ")

				$("#modalAir").modal("show")
				$("#loginPassword").focus()

				$("#wrapLoginPassword .text_error_login").text("비밀번호가 틀렸습니다.")
			}
			console.log(result.reason)

		},
		error : function(re) {

			$("#modalAir").modal("hide")
			location.reload()

			console.log("==================")
			console.log(re)

		}
	})

	// $("#form_air_login").submit()
	return false
}
// logout btn 로그아웃 버튼눌렀을 때
function clickLogoutBtn() {
	console.log("logout")
	$.ajax({
		url : '/logout',
		data : $('#formSecurityHidden input').serialize(),
		type : 'POST',
		dataType : 'json',
		success : function(result) {
			alert("로그아웃 되었습니다.")
			console.log(result)
			location.reload()

		},
		error : function(re) {

			console.log("==================")
			console.log(re)
			location.reload()

		}
	})

	/* $("#form_security_hidden").attr("method","post").attr("action","/logout").submit() */
	//	
}
function clickMenuBtn() {
	console.log("Menu On")
	$("#gnbAir").toggleClass("on")
}

function clickFindIdBtn() {
	$("#modalAir .modal-header")
			.html(
					'<button type="button" class="close" data-dismiss="modal">&times;</button><h3>아이디 찾기</h3>')
	$("#modalAir .modal-body")
			.html(
					'<form id="formFindId" class="form-horizontal" method="post" action="/findId"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><div class="form-group" id="findNameWrap"><label class="control-label col-sm-3" for="findName">이름</label><div class="col-sm-6"><input type="text" class="form-control" placeholder="이름을 입력하세요" id="findName" name="findName"><div class=" col-sm-12 text_error_findId "></div></div></div><div class="form-group" id="findPhoneWrap"><label class="control-label col-sm-3" for="findPhone">전화번호</label><div class="col-sm-6"><input type="text" class="form-control" placeholder="전화번호를 입력하세요" id="findPhone" name="findPhone"><div class=" col-sm-12 text_error_findId "></div></div></div></form>')
	$("#modalAir .modal-footer")
			.html(
					'<button type="button" id="btnFindId" class="btn btn_air pull-left" onclick="clickFindPwBtn()" data-dismiss="modal">비밀번호 찾기</button><button id="btn_login_submit" onclick="submitFindId()" type="submit" class="btn btn_air flaot-right">찾기</button>')

}

function clickFindPwBtn() {
	$("#modalAir .modal-header")
			.html(
					'<button type="button" class="close" data-dismiss="modal">&times;</button><h3>비밀번호 찾기</h3>')
	$("#modalAir .modal-body")
			.html(
					'<form id="formFindPw" class="form-horizontal" method="post" action="/findPw"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><div id="findIdWrap" class="form-group"><label class="control-label col-sm-3" for="findId">아이디</label><div class="col-sm-6"><input id="findId" type="text" class="form-control" placeholder="아이디를 입력하세요" name="findId"><div class="text_error_findPw"></div></div></div><div id="findPhoneWrap" class="form-group"><label class="control-label col-sm-3" for="findPhone">전화번호</label><div class="col-sm-6"><input id="findPhone" type="text" class="form-control" placeholder="전화번호를 입력하세요" name="findPhone"><div class="text_error_findPw"></div></div></div></form>')
	$("#modalAir .modal-footer")
			.html(
					'<button type="button" id="btnFindPassword" class="btn btn_air pull-left" onclick="clickFindIdBtn()" data-dismiss="modal">아이디 찾기</button><button id="btn_login_submit" onclick="submitFindPw()" type="submit" class="btn btn_air flaot-right">찾기</button>')

}

function submitFindId() {
	console.log("findId")
	console.log($("#findIdName").val())
	console.log($("#findPhone").val())

	var csrfHeaderName = "X-CSRF-TOKEN"
	var csrfTokenValue = $("#dataScurityHidden").val()
	console.log(csrfHeaderName)
	console.log(csrfTokenValue)

	var requestURL = encodeURIComponent('/findId?findName='
			+ $("#findName").val() + '&findPhone=' + $("#findPhone").val())
	console.log(requestURL)
	$.ajax({
		url : '/findId',
		type : 'POST',
		data : $("#formFindId input").serialize(),
		dataType : 'json',
		beforeSend : function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
		},
		success : function(data) {
			// $("#modalAir").modal("hide")
			console.log(data)
			if (data.result === "success") {

				$("#findPhoneWrap .text_error_findId").html(
						"아이디는 " + data.resultId + "입니다.")
			}
			if (data.result === "fail" && result.reason === "nomember") {
				$("#wrapLoginPassword .text_error_login").html(" ")
				$("#modalAir").modal("show")

				$("#loginId ").focus()
				$("#formFindId ").append("아이디는 " + data.resultId + "입니다.")
				// $("#wrapLoginId .text_error_login").text("존재하지 않는
				// 회원입니다.")

			}
			if (data.result === "fail" && result.reason === "wrongpass") {
				$("#wrapLoginId .text_error_login").html(" ")

				$("#modalAir").modal("show")
				$("#loginPassword").focus()

				// $("#wrapLoginPassword .text_error_login").text("비밀번호가
				// 틀렸습니다.")
			}
			// console.log(result.reason)

		},
		error : function(re) {

			$("#modalAir").modal("hide")
			location.reload()

			console.log("==================")
			console.log(re)

		}
	})

	// $("#form_air_login").submit()
	return false
}
function submitFindPw() {
	console.log("findPw")
	console.log($("#findId").val())
	console.log($("#findPhone").val())

	var csrfHeaderName = "X-CSRF-TOKEN"
	var csrfTokenValue = $("#dataScurityHidden").val()
	console.log(csrfHeaderName)
	console.log(csrfTokenValue)

	$.ajax({
		url : '/findPw',
		type : 'POST',
		data : $("#formFindPw input").serialize(),
		dataType : 'json',
		beforeSend : function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
		},
		success : function(data) {
			// $("#modalAir").modal("hide")
			console.log(data)
			if (data.result === "success") {

				$("#findPhoneWrap .text_error_findPw").html(
						"비밀번호를 '" + $("#findPhone").val() + "'로 전송하였습니다.")
			}
			if (data.result === "fail") {
				$("#wrapLoginPassword .text_error_login").html(" ")
				$("#modalAir").modal("show")

				$("#formFindId ").append("아이디는 " + data.resultId + "입니다.")
				// $("#wrapLoginId .text_error_login").text("존재하지 않는
				// 회원입니다.")

			}
			if (data.result === "fail") {
				$("#wrapLoginId .text_error_login").html(" ")

				$("#modalAir").modal("show")
				$("#loginPassword").focus()

				// $("#wrapLoginPassword .text_error_login").text("비밀번호가
				// 틀렸습니다.")
			}
			// console.log(result.reason)

		},
		error : function(re) {

			$("#modalAir").modal("hide")
			location.reload()

			console.log("==================")
			console.log(re)

		}
	})

	// $("#form_air_login").submit()
	return false
}

function zipcodeSearchBar() {
	new daum.Postcode({
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName
							: data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraAddr !== '') {
					extraAddr = ' (' + extraAddr + ')';
				}
				// 조합된 참고항목을 해당 필드에 넣는다.
				// document.getElementById("sample6_extraAddress").value =
				// extraAddr;

			} else {
				// document.getElementById("sample6_extraAddress").value = '';
			}

			var searchbar_addr = addr.split(" ");

			var s = searchbar_addr[0];// 시
			var g = searchbar_addr[1];// 구군
			var d = searchbar_addr[2];// 동
			var searchbar_addr = ""

			if (s != null) {
				searchbar_addr += s
			}

			if (g != null) {
				searchbar_addr += " " + g
			}

			if (d != null) {
				searchbar_addr += " " + d
			}

			console.log(searchbar_addr);

			$("#searchLocation").val(searchbar_addr);

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			// document.getElementById('sample6_postcode').value =
			// data.zonecode;
			// document.getElementById("searchLocation").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			// document.getElementById("sample6_detailAddress").focus();
		}
	}).open();
}
$(document)
		.ready(
				function() {
					var deviceWidth = $(document).width()
					console.log(deviceWidth)

					if ($("#messageSignout").text() === "logout") {
						clickLogoutBtn()
					}

					$("#btnSearchbarSubmitMobile").hide()
					$("#barSearchMobile").hide()

					$("#wrapSearchBar").show()
					$("#wrapSearchBarMobile").show()
					if (deviceWidth <= 768) {

						$("#btnSearchbarSubmit").hide()

						$("#barSearchMobile").show()
						$("#wrapSearchBar").addClass("off")
						$("#barSearchMobile").click(function() {
							$("#wrapSearchBar").toggleClass("off")
						})
						$("#btnSearchbarSubmitMobile").show()
					}
					// mypage메뉴클릭

					$("#menuMypage").click(
							function(e) {
								e.preventDefault();
								$("#formMyPage").attr("action",
										"/mypage/my_reservation")
								$("#formMyPage").submit()

							})
					var formSearchBar = $("#formSearchBar")
					$("#btnSearchbarSubmit")
							.on(
									"click",
									function(e) {
										if (formSearchBar.find(
												"input[name='iAddr']").val() == ''
												&& formSearchBar.find(
														"input[name='iSdate']")
														.val() == ''
												&& formSearchBar.find(
														"input[name='iEdate']")
														.val() == ''
												&& formSearchBar.find(
														"input[name='iTitle']")
														.val() == '') {
											alert("검색창을 입력해주세요");

											return false;
										} else {

											/* 주소 자르기(시/군/구 까지 자르기) */
											var search_addr = $(
													"#searchLocation").val()
													.split(" ");

											var s = search_addr[0];// 시
											var g = search_addr[1];// 구군
											var d = search_addr[2];// 동
											var searchAddress = ""

											if (s != null) {
												searchAddress += s
											}

											if (g != null) {
												searchAddress += " " + g
											}

											if (d != null) {
												searchAddress += " " + d
											}

											console.log(searchLocation);

											$("#searchLocation").val(
													searchAddress);

											/* form 데이터 전송 */
											var params = $("#formSearchBar")
													.serialize();
											
											
											// 페이지번호랑 전체 글 수 번호
											var actionForm = $("#formSearchBar");

											$(".paginate_button a").on("click", function(e) {
												e.preventDefault();

												console.log("click");

												actionForm.find("input[name = 'pageNum']").val($(this).attr("href"));
												actionForm.submit();
											});


											/*
											 * $.ajax({
											 * 
											 * url : "/item/search", type :
											 * "post", data : params, async :
											 * false, contentType : 'Json',
											 * success : function(data,
											 * textStatus) { if (data.code ==
											 * '00') { console.log('success') }
											 * else { console.log('error') } }
											 * 
											 * });
											 */

										}
										formSearchBar.submit();

									});

					// $("#btnLogin").click(clickLoginMenu())

					//
					// $("#btnFindId").click(clickFindIdBtn())
					// $("#btnFindPassword").click(clickFindPwBtn())
				})