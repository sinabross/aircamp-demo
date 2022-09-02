//ver2 정현 2019-08-01 

$(document)
		.ready(
				function() {
					
					$("#btnDeleteMember").on("click", function(e) {

						e.preventDefault();

						if (confirm("탈퇴하시겠습니까?")) {

							$("#formMemberDeleteCheck").submit();

						} else {
							return;
						}
					})
					$(".icon_mypagemobile_lnb").on("click", function() {
						$("#lnbMypageMobile").toggleClass("on")
						$(".icon_mypagemobile_lnb").toggleClass("on")
					})

					// lnb
					$(".menu_mypage_reservation").click(
							function(e) {
								e.preventDefault();
								$("#formMyPage").attr("action",
										"/mypage/my_reservation")
								$("#formMyPage").submit()

							})
					$(".menu_mypage_post").click(function(e) {
						e.preventDefault()
						$("#formMyPage").attr("action", "/mypage/my_share")
						$("#formMyPage").submit()

					})
					$(".menu_mypage_community").click(function(e) {
						e.preventDefault()
						$("#formMyPage").attr("action", "/mypage/my_community")
						$("#formMyPage").submit()

					})
					$(".menu_mypage_contactus").click(function(e) {
						e.preventDefault()
						$("#formMyPage").attr("action", "/mypage/my_contactus")
						$("#formMyPage").submit()

					})
					$(".menu_mypage_modify").click(function(e) {
						e.preventDefault()
					location.replace("/mypage/my_modify_check?myid="+$('#formMyPage input[name="myid"]').val())

					})
					$(".menu_mypage_delete").click(function(e) {
						e.preventDefault()
						$("#formMyPage").attr("action", "/mypage/my_delete")
						$("#formMyPage").submit()

					})
					// mypage_reservation
					// ==========================================

					var d = new Date();
					var month = d.getMonth() + 1;
					var day = d.getDate();

					var output = d.getFullYear() + '-'
							+ (month < 10 ? '0' : '') + month + '-'
							+ (day < 10 ? '0' : '') + day;

					$(".sdateVal")
							.each(
									function(i) {

										var sdateVal = $(this).val();
										Memberid = $(".memberId").eq(i).val();
										/*
										 * ItemidVal =
										 * $(".i_idVal").eq(i).val();
										 */
										ShareidVal = $(".s_idVal").eq(i).val();

										console.log(i);
										console.log(sdateVal);

										var str = "";
										cancelBtn = $(".cancelBtn").eq(i);

										if (sdateVal > output) {
											console.log("오늘날짜가 큼");
											str = "<button type='button' data-m_id='"
													+ Memberid
													/*
													 * + "' data-i_id='" +
													 * ItemidVal
													 */
													+ "' data-s_id='"
													+ ShareidVal
													+ "' class='btn btn_air btnCancel'>예약취소</button>";
											cancelBtn.html(str);

										} else if (sdateVal <= output) {
											console.log("오늘날짜가 작음");
											str = "";

											str = '<button class="btn btn_air btnReviewModal" data-toggle="modal" data-target="#reviewModal" >후기작성</button>'

											cancelBtn.html(str);

										}

									})

					console.log("준비완료");

					// 예약취소버튼
					$(".i_idVal")
							.each(
									function(i) {

										btnCancel = $(".btnCancel").eq(i);

										$(btnCancel)
												.on(
														"click",
														function(e) {
															console.log("used");
															e.preventDefault();

															if (confirm("예약 취소하시겠습니까?")) {
																location.href = "/mypage/shareDelete?myid="
																		+ $(
																				this)
																				.data(
																						"m_id")
																		+ "&s_id="
																		+ $(
																				this)
																				.data(
																						"s_id");
															} else {
																return;
															}

														});

									})

					// 예약페이지처리
					var sharepageForm = $("#sharepageForm");

					$(".sharepageBtn a").on(
							"click",
							function(e) {
								e.preventDefault();

								console.log("click");

								sharepageForm.find("input[name = 'pageNum']")
										.val($(this).attr("href"));
								sharepageForm.submit();
							});

					// mypageReservation 끝======

					// mypage_share=======================================

					// var myId = $("#myid").val()
					$(".list_item_share")
							.each(
									function(i) {

										var sdateVal = $(".item_share_sdate")
												.eq(i).val();
										var edateVal = $(".item_share_edate")
												.eq(i).val();
										/*
										 * ItemidVal =
										 * $(".i_idVal").eq(i).val();
										 */
										var s_sid = $(".s_sid").eq(i).val();

										console.log(i);
										console.log(sdateVal);

										var str = "";
										var itemShareStatus = $(
												".item_share_status").eq(i);

										if (sdateVal > output) {

											str = "예약대기";
											itemShareStatus.val(str);
											var str2 = "<a class='btn btn_itemshare_cancle'>예약거부</a>";
											$(".item_share_cancle").eq(i).html(
													str2);

										} else if ((sdateVal <= output)
												&& (edateVal > output)) {

											str = "대여중"
											itemShareStatus.val(str);

										} else {
											str = "반납완료"
											itemShareStatus.val(str);
										}

									})

					console.log("준비완료");

					$(".btn_itemshare_cancle").click(function(e) {
						e.preventDefault();
						$(this).parents("form").submit()

					})
					// 예약페이지처리
					var itempageForm = $("#itempageForm");

					$(".itempageBtn a").on(
							"click",
							function(e) {
								e.preventDefault();

								console.log("click");

								itempageForm.find("input[name = 'pageNum']")
										.val($(this).attr("href"));
								itempageForm.submit();
							});

					// mypage_share 끝

					// mypage_community=====================================

					var commpageForm = $("#commpageForm");

					$(".commpageBtn a").on(
							"click",
							function(e) {
								e.preventDefault();

								console.log("click");

								commpageForm.find("input[name = 'pageNum']")
										.val($(this).attr("href"));
								commpageForm.submit();
							});

					// mypage_comm 끝

					// my_page_contactus==================================

					var qnapageForm = $("#qnapageForm");

					$(".qnapageBtn a").on(
							"click",
							function(e) {
								e.preventDefault();

								console.log("click");

								qnapageForm.find("input[name = 'pageNum']")
										.val($(this).attr("href"));
								qnapageForm.submit();
							});

					// my_page_comtactus 끝

					// my_page_share에서 reservationList

					/*
					 * $(".box_item_share") .each( function(i) {
					 */

					/*
					 * var str='<li class="list_item_share"><div
					 * class="item_share_mid col-md-2">' str+=share.m_id
					 *//*
						 * $(this).append('<li class="list_item_share"><div
						 * class="item_share_mid col-md-2">{share.m_id}</div><div
						 * class="item_share_sdate col-md-4">{share.s_sdate}</div><div
						 * class="item_share_edate col-md-4">{share.s_edate}</div><div
						 * class="item_share_status col-md-2">{share.s_status}</div>
						 * </li>') })
						 */

				})