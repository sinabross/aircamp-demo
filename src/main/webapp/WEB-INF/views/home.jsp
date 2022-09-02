<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/home.css" />

<!-- <script src="/resources/js/home.js"></script> -->
<!-- 검색기능 창 ---------------------------------------------------------------------------------------------------------------->
<br>
<br>
<div class="col-md-12 col-sm-11">
	<img id="backgroundImage" src="/resources/images/home/bg_aircamp.png">

	<div id="searchBox">
		<div class="search_box_title">
			<h3>원하는 장소 날짜 및 장비를 검색해주세요</h3>
		</div>
		<div class="search_box_body">
			<form id="searchForm" action="/item/search" method="get">
				<input type="hidden" name="pageNum" value="1"> <input
					type="hidden" name="amount" value="10">

				<h5>
					<i class='fas fa-map-marker-alt'></i>
					<!-- <img id="pathImage" src="resources/images/home/icon_location.png"> -->
					위치검색
				</h5>
				<div>
					<input class="form" type="text" id="searchAddr" placeholder="클릭하시오"
						onclick="zipcodeSearch()" name="iAddr" autocomplete="off" />
				</div>

				<h5>
					<i class='far fa-calendar-alt'></i>대여일
				</h5>
				<input class="date_form" id="sdateHome" type="text" name="iSdate"
					placeholder="클릭하시오" autocomplete="off" />


				<h5>
					<i class='far fa-calendar-alt'></i>반납일
				</h5>
				<input class="date_form" id="edateHome" type="text" name="iEdate"
					placeholder="클릭하시오" autocomplete="off" />


				<div>
					<h5>
						<i class="fas fa-search"></i> 장비검색
					</h5>
					<input class="form" id="searchItem" type="text" name="iTitle"
						placeholder="ex) 텐트, 그릴  등등" />
				</div>

				<input type="button" class="btn btn_air" id="searchBtn" value="검색" />
			</form>
		</div>
	</div>
</div>
<!-- 검색 기능 창 끝 -->

<script>
	/* 검색 시 값이 있는지 없는지 확인 및 주소를 검색을 헀을 때 주소 자르기 */
	$(function() {
		$(".date_form").datepicker({
			dateFormat : "yy-mm-dd"
		});

		$(".searchBarDate").datepicker({
			dateFormat : "yy-mm-dd"
		});

		// 페이지번호랑 전체 글 수 번호
		var actionForm = $("#actionForm");

		$(".paginate_button a").on(
				"click",
				function(e) {
					e.preventDefault();

					console.log("click");

					actionForm.find("input[name = 'pageNum']").val(
							$(this).attr("href"));
					actionForm.submit();
				});

	});
	$(document).ready(function() {
		$("#barSearchMobile").remove()
	})
	var searchForm = $("#searchForm");
	$("#formSearchBar").remove()
	$("#btnSearchbarSubmit").remove()
	$("#wrapSearchBar").append("<div id='txtSearchBar'>지금 공유를 시작하세요!<div>")
	//	$("#wrapSearchBar").prepend("지금 공유를 시작하세요!")

	//$("#wrapSearchBarMobile").remove()
	$("#wrapBody").prepend("<br>")

	$("#searchBtn")
			.on(
					"click",
					function(e) {

						if (searchForm.find("input[name='iAddr']").val() == ''
								&& searchForm.find("input[name='iSdate']")
										.val() == ''
								&& searchForm.find("input[name='iEdate']")
										.val() == ''
								&& searchForm.find("input[name='iTitle']")
										.val() == '') {
							alert("검색창을 입력해주세요");

							return false;
						} else {

							/* 주소 자르기(시/군/구 까지 자르기)  */
							var search_addr = $("#searchAddr").val().split(" ");

							var s = search_addr[0];//시
							var g = search_addr[1];//구군
							var d = search_addr[2];//동
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

							console.log(searchAddr);

							$("#searchAddr").val(searchAddress);

							/* form 데이터 전송 */
							var params = $("#searchForm").serialize();

							/* $.ajax({

								url : "/item/search",
								type : "post",
								data : params,
								async : false,
								contentType : 'Json',
								success : function(data, textStatus) {
									if (data.code == '00') {
										console.log('success')
									} else {
										console.log('error')
									}
								}

							}); */

						}
						searchForm.submit();

					});
</script>

<div id="sectionThumbnail" class="col-md-12">
	<h2>
		Camping with AIRCAMP<br>
	</h2>
	<i class='fas fa-chevron-left'></i>
	<div>
		<div id="homeThumnailWrap">
			<!--  color_txt_green -->

			<c:forEach items="${itemThumbnailList}" var="thumnail">

				<div class="box_home_thumnail">
					<c:choose>
						<c:when test="${thumnail.g_id==0 ||empty thumnail.g_id}">
							<img class="img_home_thumnail"
								src='/resources/images/item/no_image.png'>
						</c:when>
						<c:otherwise>
							<img class="img_home_thumnail"
								src="/showThumbnail?galleryId=${thumnail.g_id}">
						</c:otherwise>
					</c:choose>
					<div class="block_home_thumnail">
						<div class="text_home_thumnail"
							onClick="location.href='/item/detail?i_id=${thumnail.i_id}'">
							${thumnail.i_title}</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<i class='fas fa-chevron-right'></i>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<script src="/resources/js/home.js"></script>


