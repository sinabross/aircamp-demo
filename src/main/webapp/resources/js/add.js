$(document)
		.ready(
				function() {

					// datepicker
					$("#testDatepicker").datepicker(
							{
								dateFormat : 'yy-mm-dd',
								showMonthAfterYear : true,
								changeYear : true,
								changeMonth : true,
								monthNamesShort : [ '1', '2', '3', '4', '5',
										'6', '7', '8', '9', '10', '11', '12' ],
								monthNames : [ '1월', '2월', '3월', '4월', '5월',
										'6월', '7월', '8월', '9월', '10월', '11월',
										'12월' ],
								dayNamesMin : [ '일', '월', '화', '수', '목', '금',
										'토' ],
								dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
										'금요일', '토요일' ],
								minDate : 0
							});

					$("#testDatepicker2").datepicker(
							{
								dateFormat : 'yy-mm-dd',
								showMonthAfterYear : true,
								changeYear : true,
								changeMonth : true,
								monthNamesShort : [ '1', '2', '3', '4', '5',
										'6', '7', '8', '9', '10', '11', '12' ],
								monthNames : [ '1월', '2월', '3월', '4월', '5월',
										'6월', '7월', '8월', '9월', '10월', '11월',
										'12월' ],
								dayNamesMin : [ '일', '월', '화', '수', '목', '금',
										'토' ],
								dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
										'금요일', '토요일' ],
								minDate : 0
							});

					/* 대여일, 반납일 체크. date형식이 일치할 때만 가능 */
					var startDate; // 대여일
					var endDate; // 반납일

					// 대여일 체크
					$("#testDatepicker").on(
							"propertychange change keyup paste input",
							function() {
								startDate = $(this).val();
								if (startDate > endDate) {
									alert("종료일이 시작일 앞에 있습니다.");
									$(this).val("");
									startDate = null;
								}

							});

					// 반납일 체크
					$("#testDatepicker2").on(
							"propertychange change keyup paste input",
							function() {
								endDate = $(this).val();
								if (startDate > endDate) {
									alert("종료일이 시작일 앞에 있습니다.");
									$(this).val("");
									endDate = null;
								}
							});

					/* 시큐리티 포트스때필요 */
					var csrf = $("#csrf").attr('name');
					var csrf2 = $("#csrf").val();

					// 확장자 제한, 파일크기 제한
					var reg = /(.*?)\.(jpg|jpeg|png|gif|bmp)$/i;
					var maxSize = 5242880; // 5mb

					// 사이즈랑 확장자 체크
					function checkExtension(fileName, fileSize) {
						if (fileSize >= maxSize) {
							alert("파일 사이즈 초과");
							return false;
						}
						if (reg.test(fileName) == false) {
							alert("해당종류의 파일은 업로드할 수 없습니다.");
							return false;
						}
						return true;
					}

					// x버튼 클릭시 삭제
					$("#uploadResult").on("click", ".xBtn", function(e) {

						var targetFile = $(this).data("file");
						console.log(targetFile);
						var type = $(this).data("type");
						console.log("x버튼 클릭해서 삭제한다~" + targetFile + type);
						var file = $(this);

						console.log("file=" + file.val);

						$.ajax({
							url : '/item/deleteFile',
							beforeSend : function(xhr) {
								xhr.setRequestHeader(csrf, csrf2);
							},
							data : {
								fileName : targetFile,
								type : type
							},
							dataType : 'text',
							type : 'POST',
							success : function(result) {
								file.closest("li").remove();
								alert(result);
								console.log("li=" + file.closest("li"));

							}
						});

					});

					/* 전송 버튼 클릭 */
					var formObj = $("form[role='form']");

					$("button[type='submit']")
							.on(
									"click",
									function(e) {
										e.preventDefault();

										var str = "";

										$("#uploadResult li")
												.each(
														function(i, obj) {
															var jobj = $(obj);
															console.dir(jobj);

															str += "<input type='hidden' name='galleryList["
																	+ i
																	+ "].g_filename' value='"
																	+ jobj
																			.data("g_filename")
																	+ "'>";
															str += "<input type='hidden' name='galleryList["
																	+ i
																	+ "].g_uuid' value='"
																	+ jobj
																			.data("g_uuid")
																	+ "'>";
															str += "<input type='hidden' name='galleryList["
																	+ i
																	+ "].g_path' value='"
																	+ jobj
																			.data("g_path")
																	+ "'>";
														});

										console.log($("#btnItemAddFile").val());
										if ($("#btnItemAddFile").val() == "") {

											alert("파일을 첨부해주세요");
										} else if ($("#label_search").val() == "") {
											alert("주소를 입력해주세요");
										} else {
											formObj.append(str).submit();
										}

									});

					/* file을 선택하면 바로 업로드하기 */
					$("#btnItemAddFile").change(function(e) {

						var formData = new FormData();
						var inputFile = $("input[name='uploadFile']");

						var files = inputFile[0].files;
						// console.log(files);

						for (var i = 0; i < files.length; i++) {

							if (!checkExtension(files[i].name, files[i].size)) {
								return false;
							}

							formData.append("uploadFile", files[i]);
							console.log("업로드가자~~~~");

						}

						$.ajax({
							url : '/item/uploadAjax',
							processData : false,
							contentType : false,
							beforeSend : function(xhr) {
								xhr.setRequestHeader(csrf, csrf2);
							},
							data : formData,
							dataType : 'json',
							type : 'POST',
							success : function(result) {
								// alert("업로드성공");
								console.log(result);
								// 파일목록출력
								showUploadedFile(result);

							}
						});

					});

					// 섬네일 목록출력
					function showUploadedFile(uploadResultArr) {

						var uploadResult = $("#uploadResult>div");
						var str = "";
						var str2 = "";
						console.log(uploadResultArr)
						console.log(uploadResult)
						$(uploadResultArr)
								.each(
										function(i, obj) {

											var fileCallPath = encodeURIComponent(obj.g_path
													+ "/s_"
													+ obj.g_uuid
													+ "_"
													+ obj.g_filename);
											console.log(str)
											console.log(fileCallPath)
											str += "<li class='test' data-g_path='"
													+ obj.g_path + "'";
											str += " data-g_uuid='"
													+ obj.g_uuid
													+ "' data-g_filename='"
													+ obj.g_filename + "'";
											str += "><div>";
											str += "<button data-file=\'"
													+ fileCallPath
													+ "\' data-type='image' class='xBtn' type='button'><i class='fa fa-times'></i></button>"
													+ "<img  src='/item/display?fileName="
													+ fileCallPath + "'></div>";

											str += "</li>";

										});

						uploadResult.append(str);

					}

					// 이메일 검사 정규식
					var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
					// 위와 비슷하고 -_특수문자가 가능하며 중앙에 @ 필수 그리고 .뒤에 2~3글자가 필요하다
					var phoneJ = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
					var regExp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;

					// focusOut
					// 제목
					$("#title").focusout(
							function() {

								if ($(this).val() == null
										|| $(this).val().length == 0) {
									$("#i_title_check").text("제목을 입력해 주세요");
									$("#i_title_check").addClass("red");
									$("#i_title_check").addClass("mar");
								} else {
									$("#i_title_check").text("");
									$("#i_title_check").removeClass("red");
									$("#i_title_check").removeClass("mar");
								}
							});
					// 날짜
					$("#testDatepicker").on(
							"change focusout",
							function() {

								if ($(this).val() == null
										|| $(this).val().length == 0) {
									$("#i_date").text("날짜를 선택해 주세요");
									$("#i_date").addClass("red");
									$("#i_date").addClass("mar");
								} else {
									$("#i_date").text("");
									$("#i_date").removeClass("red");
									$("#i_date").removeClass("mar");
								}
							});

					$("#testDatepicker2").on(
							"change focusout",
							function() {

								if ($(this).val() == null
										|| $(this).val().length == 0) {
									$("#i_date").text("날짜를 선택해 주세요");
									$("#i_date").addClass("red");
									$("#i_date").addClass("mar");
								} else {
									$("#i_date").text("");
									$("#i_date").removeClass("red");
									$("#i_date").removeClass("mar");
								}
							});

					// 가격
					$("#price").focusout(
							function() {

								if ($(this).val() == null
										|| $(this).val().length == 0) {
									$("#i_price").text("가격을 입력해 주세요");
									$("#i_price").addClass("red");
									$("#i_price").addClass("mar");
								} else {
									$("#i_price").text("");
									$("#i_price").removeClass("red");
									$("#i_price").removeClass("mar");
								}
							});

					// 소개
					$("#info").focusout(
							function() {

								if ($(this).val() == null
										|| $(this).val().length == 0) {
									$("#i_info").text("글을 입력해 주세요");
									$("#i_info").addClass("red");
									$("#i_info").addClass("mar");
								} else {
									$("#i_info").text("");
									$("#i_info").removeClass("red");
									$("#i_info").removeClass("mar");
								}
							});
					// 이메일
					$("#mail").focusout(function() {
						var kk = $(this).val();
						if (kk == "") {
							$("#i_email").text("");
							$("#i_email").removeClass("red");

							$("#i_email").removeClass("mar");
						} else if (!mailJ.test(kk)) {
							$("#i_email").text("이메일을 형식에 맞게 입력해 주세요");
							$("#i_email").addClass("red");
							$("#i_email").addClass("mar");
						} else {
							$("#i_email").text("");

							$("#i_email").removeClass("mar");
						}
					});

					// 카톡아이디
					/*
					 * $("#katol").focusout(function() { if
					 * (!mailJ.test($("#katol").val())) { $("#i_katalk").text("을
					 * 형식에 맞게 입력해 주세요"); $("i_katalk").addClass("red");
					 * $("#i_katalk").addClass("mar"); } else {
					 * $("#i_katalk").text("");
					 * $("#i_katalk").removeClass("red");
					 * $("#i_katalk").removeClass("mar"); } });
					 */

					// 연락처
					$("#input_item_add_phone").focusout(function() {
						console.log("연락쳐클릭했다");
						if ($(this).val() == "") {
							$("#i_phone").text("전화번호를 입력해 주세요");
							$("#i_phone").addClass("red");
							$("#i_phone").addClass("mar");
						} 
						
						else if (!regExp.test($("#input_item_add_phone").val())) {
							$("#i_phone").text("형식에 맞게 입력해 주세요");
							$("#i_phone").addClass("red");
							$("#i_phone").addClass("mar");
						} else {
							$("#i_phone").text("");
							$("#i_phone").removeClass("red");
							$("#i_phone").removeClass("mar");
						}
					});

				});

function addressGoogleAPI() {
	new daum.Postcode({
		oncomplete : function(data) {
			// var addr = data.address; // 최종 주소 변수
			/*
			 * if (searchForm.find("input[name='iAddr']").val() == '' &&
			 * searchForm.find("input[name='iSdate']") .val() == '' &&
			 * searchForm.find("input[name='iEdate']") .val() == '' &&
			 * searchForm.find("input[name='iTitle']") .val() == '') {
			 * alert("검색창을 입력해주세요");
			 * 
			 * return false; }
			 */

			/* 주소 자르기(시/군/구 까지 자르기) */
			var additem_addr = data.address.split(" ");

			var s = additem_addr[0];// 시
			var g = additem_addr[1];// 구군
			var d = additem_addr[2];// 동
			var additemAddress = ""

			if (s != null) {
				additemAddress += s
			}

			if (g != null) {
				additemAddress += " " + g
			}

			if (d != null) {
				additemAddress += " " + d
			}

			console.log(additemAddress);

			$("#label_search").val(additemAddress);

			/*
			 * $.ajax({
			 * 
			 * url : "/item/search", type : "post", data : params, async :
			 * false, contentType : 'Json', success : function(data, textStatus) {
			 * if (data.code == '00') { console.log('success') } else {
			 * console.log('error') } }
			 * 
			 * });
			 */

			// 주소 정보를 해당 필드에 넣는다.
			/* document.getElementById("label_search").value = addr; */
		}
	}).open();

}