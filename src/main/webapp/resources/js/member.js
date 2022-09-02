/**
 * 정현 2019-07-22 ver1
 * ============================================================
 * 
 * 
 */

/* join.jsp ========================================= */

/*
 * function focusInInput(){
 * 
 * 
 * $("#login_email img").on("click", function(){ $("#input_id").focus(); });
 * 
 * $("#login_pw img").on("click", function(){ $("#input_pw").focus(); });
 * 
 * $("#login_pw_chk img").on("click", function(){ $("#input_pw_chk").focus();
 * });
 * 
 * $("#login_name img").on("click", function(){ $("#input_name").focus(); });
 * 
 * $("#login_phonenum img").on("click", function(){
 * $("#input_phonenum").focus(); }); }
 * 
 */

// flag

var idFlag = false;
var pwFlag = false;
var pwChkFlag = false;
var nameFlag = false;
var pnumFlag = false;
var pnumChkFlag = true;
var emailFlag = true;
var numChkFlag = false;
var idck = 0;

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

function styleInputId() {
	$("#login_id").addClass("red_box");
	$("#login_id").removeClass("input_box");
	$("#txt_id").css("display", "block");
	idFlag = false;
}

function styleInputEmail() {
	$("#login_email").addClass("red_box");
	$("#login_email").removeClass("input_box");
	$("#txt_email").css("display", "block");
	emailFlag = false;

}
function styleInputPw() {
	$("#login_pw").addClass("red_box");
	$("#login_pw").removeClass("input_box");
	$("#txt_pw").css("display", "block");
	pwFlag = false;
}
function styleInputPwChk() {
	$("#login_pw_chk").addClass("red_box");
	$("#login_pw_chk").removeClass("input_box");
	$("#txt_pw_chk").css("display", "block");
	pwChkFlag = false;
}
function styleInputName() {
	$("#login_name").addClass("red_box");
	$("#login_name").removeClass("input_box");
	$("#txt_name").css("display", "block");
	nameFlag = false;
}
function styleInputPhonenum() {
	$("#login_phonenum").addClass("red_box");
	$("#login_phonenum").removeClass("input_box");
	$("#txt_phonenum").css("display", "block");
	$("#idnumber").attr("disabled", "disabled");
	pnumFlag = false;
}

function styleInputPhonenumChk() {
	$("#login_phonenum_chk").addClass("red_box");
	$("#login_phonenum_chk").removeClass("input_box");
	$("#txt_phonenum_chk").css("display", "block");
	pnumChkFlag = false;
}

function focusOutId() {
	if ($("#input_id").val() == "") {
		styleInputId();
		$("#txt_id").css("display", "block");

	} else if ($("#input_id").val() != "") {

		var idVal = $("#input_id").val();
		var regId = /^[A-Za-z]{1}[A-Za-z0-9]{3,19}$/; // 아이디정규식

		if (!regId.test(idVal) && idVal !== "") {
			styleInputId();
		} else if (regId.test(idVal)) {
			$("#login_id").addClass("input_box");
			$("#login_id").removeClass("red_box");
			$("#txt_id").css("display", "none");

			idFlag = true;
			console.log("idFlag: " + idFlag);

		}

	}

}

function focusOutEmail() {
	if ($("#input_email").val() == "") {
		$("#login_email").addClass("input_box");
		$("#login_email").removeClass("red_box");
		$("#txt_email").css("display", "none");
		emailFlag = true;
	} else if ($("#input_email").val() != "") {
		var emailVal = $("#input_email").val();
		var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
																											// 정규식

		if (!regEmail.test(emailVal) && emailVal != "") {
			styleInputEmail();
		} else if (regEmail.test(emailVal)) {
			$("#login_email").addClass("input_box");
			$("#login_email").removeClass("red_box");
			$("#txt_email").css("display", "none");

			emailFlag = true;
			console.log("emailFlag: " + emailFlag);

		}
	}
}

function focusOutPw() {
	if ($("#input_pw").val() == "") {
		styleInputPw();
	} else if ($("#input_pw").val() != "") {
		var pwVal = $("#input_pw").val();
		var regPw = /^[A-Za-z0-9]{6,15}$/;// 숫자와 문자 포함 형태의 6~15자리 이내의 암호 정규식

		if (!regPw.test(pwVal)) {
			styleInputPw();
		} else if (regPw.test(pwVal)) {
			$("#login_pw").addClass("input_box");
			$("#login_pw").removeClass("red_box");
			$("#txt_pw").css("display", "none");
			pwFlag = true;
			console.log("pwFlag: " + pwFlag);
		}
	}
}

function focusOutPwChk() {
	var pwChkVal = $("#input_pw_chk").val();

	if (pwChkVal == "" || ($("#input_pw").val() != pwChkVal)) {
		styleInputPwChk();
	} else {
		$("#login_pw_chk").addClass("input_box");
		$("#login_pw_chk").removeClass("red_box");
		$("#txt_pw_chk").css("display", "none");
		pwChkFlag = true;
		console.log("pwChkFlag: " + pwChkFlag);
	}
}

function focusOutName() {
	if ($("#input_name").val() == "") {
		styleInputName();
	} else {
		$("#login_name").addClass("input_box");
		$("#login_name").removeClass("red_box");
		$("#txt_name").css("display", "none");
		nameFlag = true;
		console.log("nameFlag: " + nameFlag);
	}
}

function focusOutPnum() {
	var pnumVal = $("#input_phonenum").val();
	var regPnum = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;

	if (pnumVal == "" || !regPnum.test(pnumVal)) {
		styleInputPhonenum();
	} else {
		$("#login_phonenum").addClass("input_box");
		$("#login_phonenum").removeClass("red_box");
		$("#txt_phonenum").css("display", "none");
		$("#idnumber").removeAttr("disabled");
		pnumFlag = true;
		console.log("pnumFlag: " + pnumFlag);
	}
}

function focusOutPnumChk() {
	var pnumChkVal = $("#input_phonenum_chk").val();

	if (pnumChkVal == "") {
		styleInputPhonenumChk();
	} else {
		$("#login_phonenum_chk").addClass("input_box");
		$("#login_phonenum_chk").removeClass("red_box");
		$("#txt_phonenum_chk").css("display", "none");

		pnumChkFlag = true;
		console.log("pnumChkFlag: " + pnumChkFlag);
	}
}

function focusOutInput() {
	$("#input_id").on("blur", focusOutId);
	$("#input_email").on("blur", focusOutEmail);
	$("#input_pw").on("blur", focusOutPw);
	$("#input_pw_chk").on("blur", focusOutPwChk);
	$("#input_name").on("blur", focusOutName);
	$("#input_phonenum").on("blur", focusOutPnum);
	$("#input_phonenum_chk").on("blur", focusOutPnumChk);
}

/* join.jsp === */

$(document)
		.ready(
				function() {
					if($("#loginInJoin").val()==="login"){
						console.log($("#loginInJoin").val())
						location.replace("/home")
					}
					/*
					 * joinagree.jsp
					 * ==================================================
					 */

					$("#chk_one").change(function() {

						if ($("#chk_one").is(":checked")) {
							if ($("#chk_two").is(":checked")) {
								$("#btnJoin").removeAttr("disabled");
							}

						} else {
							$("#btnJoin").attr("disabled", "disabled");
						}

					})

					$("#chk_two").change(function() {

						$("#btnJoin").attr("disabled", "disabled");

						if ($("#chk_one").is(":checked")) {
							$("#btnJoin").removeAttr("disabled");

						}

						if ($("#chk_two").is(":checked")) {

						} else {
							$("#btnJoin").attr("disabled", "disabeld");
						}

					})

					$("#btnJoin").click(function() {
						location.href = "/member/join";
					})

					$("#btnReturn").click(function() {
						location.href = "/main";
					})

					/* joinagree.jsp 끝 */

					/* 중복아이디 체크 js ========================================= */

					var joinForm = $("#joinForm");

					$("#btn_Idcheck").on("click", function(e) {

						e.preventDefault();

						console.log("중복확인 btn_Idcheck 작동중...");

						var m_id = $("#input_id").val();

						if (idFlag == false) {
							alert("잘못된 아이디입니다.(첫글자 영문+숫자4글자 이상)");
							return;
						}

						$.ajax({
							type : 'get',
							url : '/member/idcheck?id=' + m_id,
							dataType : 'json',
							contentType : "application/json; charset=utf-8",
							success : function(data) {

								console.log("data:" + data);

								if (data > 0) {

									alert("중복된 아이디 입니다.");
									$("#login_id").addClass("red_box");
									$("#login_id").removeClass("input_box");
									$("#txt_id_2").css("display", "block");
									idck = 0;

								} else {
									alert("사용가능한 아이디 입니다.")
									$("#login_id").removeClass("red_box");
									$("#login_id").addClass("input_box");
									$("#txt_id_2").css("display", "none");
									idck = 1;
									console.log("idck:" + idck);

								}
							},
							error : function(error) {
								if (error) {
									error(er);
								}
							}
						})

					});

					/* join.jsp ===================================== */

					focusOutInput();

					$("#btn_join").on(
							"click",
							function(e) {

								e.preventDefault();

								if ($("#input_phonenum_chk").val() == "") {
									styleInputPhonenumChk();
									$("#input_phonenum_chk").focus();
								}

								if ($("#input_phonenum").val() == "") {
									styleInputPhonenum();
									$("#input_phonenum").focus();
								}
								if ($("#input_name").val() == "") {
									styleInputName();
									$("#input_name").focus();
								}
								if ($("#input_pw_chk").val() == "") {
									styleInputPwChk();
									$("#input_pw_chk").focus();
								}
								if ($("#input_pw").val() == "") {
									styleInputPw();
									$("#input_pw").focus();
								}
								if ($("#input_id").val() == "") {
									styleInputId();
									$("#input_id").focus();
								}

								if (idck == 1 && idFlag == true
										&& emailFlag == true && pwFlag == true
										&& pwChkFlag == true
										&& nameFlag == true && pnumFlag == true
										&& pnumChkFlag == true
										&& numChkFlag == true) {
									$("#joinForm").submit();
									alert("완료되었습니다.");
								} else if (idck == 0) {
									alert("아이디 중복 체크를 해주세요");
									return;
								} else if (numChkFlag == false) {
									alert("인증번호 확인을 해주세요.");
									return;
								} else {
									alert("필수입력항목을 적어주세요.");
									return;
								}

							});

					// idnumber button

					$("#idnumber").on("click", function(e) {

						e.preventDefault();

						alert("인증번호가 전송되었습니다.");
						$("#input_phonenum_chk").val("12345");

					});

					// idnumber_chk button

					$("#idnumber_chk")
							.on(
									"click",
									function(e) {

										e.preventDefault();

										if ($("#input_phonenum_chk").val() == "12345") {
											alert("인증번호 확인");
											numChkFlag = true;
											$("#input_phonenum_chk").attr(
													"readonly", "readonly");
											console.log("numChkFlag:"
													+ numChkFlag);
											console
													.log($(
															"#input_phonenum_chk")
															.val());
										} else {
											alert("잘못된 번호입니다.");
											console.log("Wrong"
													+ $("#input_phonenum_chk")
															.val());
											numChkFlag = false;
										}
									})

					/* join.jsp 끝 */

					// modify.jsp=========================================================//
					// 2019-07-25 ver1
					$("#btn_modify")
							.on(
									"click",
									function(e) {

										e.preventDefault();

										idck = 1;
										idFlag = true;
										emailFlag = true;
										pwFlag = true;
										nameFlag = true;
										pnumFlag = true;
										pnumChkFlag = true;
										numChkFlag = true;

										if ($("#input_phonenum").val() == "") {
											styleInputPhonenum();
											$("#input_phonenum").focus();
										}
										if ($("#input_name").val() == "") {
											styleInputName();
											$("#input_name").focus();
										}
										if ($("#input_pw_chk").val() == "") {
											styleInputPwChk();
											$("#input_pw_chk").focus();
										}
										if ($("#input_pw").val() == "") {
											styleInputPw();
											$("#input_pw").focus();
										}

										var str = "";

										$(".newfile")
												.each(
														function(i, obj) {

															var jobj = $(obj);
															console.log(obj);
															console.log(jobj);

															console
																	.log(jobj
																			.data("m_path"));
															str += "<input type='hidden' name='m_path' value='"
																	+ jobj
																			.data("m_path")
																	+ "'>";
															str += "<input type='hidden' name='m_uuid' value='"
																	+ jobj
																			.data("m_uuid")
																	+ "'>";
															str += "<input type='hidden' name='m_filename' value='"
																	+ jobj
																			.data("m_filename")
																	+ "'>";

														})

										console.log(str);

										if (idck == 1 && idFlag == true
												&& emailFlag == true
												&& pwFlag == true
												&& pwChkFlag == true
												&& nameFlag == true
												&& pnumFlag == true
												&& pnumChkFlag == true
												&& numChkFlag == true) {

											$("#joinForm").append(str).submit();

											alert("완료되었습니다.");
										} else {
											alert("필수입력항목을 적어주세요.");
											return;
										}

									})

					// uploadAjax 2019-07-25 ver1

					var reg = /(.*?)\.(jpg|jpeg|png|gif|bmp)$/i;

					// var regex = new
					// RegExp("(.*?)\.(exe|sh|zip|alz|js|dll|jar)$");
					var maxSize = 5242880;

					function checkExtension(fileName, fileSize) {
						if (fileSize >= maxSize) {
							alert("사이즈초과");
							return false;
						}

						if (reg.test(fileName) == false) {
							alert("해당종류의 파일은 업로드할 수 없습니다.");
							return false;
						}
						/*
						 * if(regex.test(fileName)){ alert("해당종류의 파일은 업로드할 수
						 * 없습니다."); return false; }
						 */
						return true;
					}

					$("#uploadFile").change(
							function(e) {

								var formData = new FormData();

								var inputFile = $("#uploadFile");

								var files = inputFile[0].files;

								for (var i = 0; i < files.length; i++) {

									if (!checkExtension(files[i].name,
											files[i].size)) {
										return false;
									}

									formData.append("uploadFile", files[i]);

								}

								console.log("OK");

								$.ajax({
									url : '/member/uploadimg',
									processData : false,
									contentType : false,
									data : formData,
									type : 'POST',
									dataType : 'json',
									beforeSend : function(xhr) {
										xhr.setRequestHeader(csrfHeaderName,
												csrfTokenValue);
									},
									success : function(result) {

										// 프사출력
										showUploadedFile(result[0]);

										console.log(result[0]);

										// 파일 찾아보기 초기화
										// $(".uploadDiv").html(cloneObj.html());

									}
								});

							});

					var uploadResult = $("#uploadimg");

					function showUploadedFile(obj) {

						$("#uploadDiv img").removeClass("newfile");
						$("#uploadDiv img").removeClass("profile");
						$("#uploadDiv img").addClass("oldfile");

						console.log("프사보여주세요");

						var str = "";

						console.log(obj.m_uuid);
						console.log(obj.m_filename);
						console.log(obj.m_path);

						var fileCallPath = encodeURIComponent("/s_"
								+ obj.m_uuid + "_" + obj.m_filename);

						str += "<img  data-m_path='"
								+ obj.m_path
								+ "'	 	"
								+ "  data-m_uuid='"
								+ obj.m_uuid
								+ "' 			"
								+ "  data-m_filename='"
								+ obj.m_filename
								+ "'	"
								+ "  class='profile newfile' src='/member/display?fileName="
								+ fileCallPath + "'>";

						console.log(str);

						uploadResult.append(str);

					}

					// modify.jsp 끝//

				})