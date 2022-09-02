<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/item.css" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>


<ul>
	<c:choose>
		<c:when test="${empty searchList}">
		<br><div style="text-align:center;">검색결과가 없습니다.<div></c:when>
		<c:otherwise>
			<c:forEach items="${searchList}" var="search">
				<div class="box_item col-sm-4 col-md-4 col-lg-4">
					<c:choose>
						<c:when test="${search.g_id==0 ||empty search.g_id}">
							<img class="img_item_thumnail"
								src='/resources/images/item/no_image.png'>
						</c:when>
						<c:otherwise>
							<img class="img_item_thumnail"
								src="/showThumbnail?galleryId=${search.g_id}">
						</c:otherwise>
					</c:choose>

				</div>
				<div class="box_item col-sm-8 col-md-8 col-lg-8">
					<li><a class="wrap_item_info"
						href="/item/detail?i_id=${search.i_id}">
							<div class="item_title">${search.i_title}</div>
							<div class="item_date">
								<!-- 대여가능날짜 -->
								<div class="item_sdate">${search.i_sdate}</div>
								<div class="com">~</div>
								<div class="item_edate">${search.i_edate}</div>
							</div>
							<div class="item_path_text">
								<i class='fas fa-map-marker-alt'></i>${search.i_addr}
							</div>
							<div class="item_star">



								<!-- 별점 평가자 수가 0인 경우 -->
								<c:if test="${search.i_eval eq 0}">
									<i class="far fa-star color_yellow"></i>
									<i class="far fa-star color_yellow"></i>
									<i class="far fa-star color_yellow"></i>
									<i class="far fa-star color_yellow"></i>
									<i class="far fa-star color_yellow"></i>
								</c:if>

								<!-- 별점 평가자 수가 0이 아닌 경우 -->
								<c:if test="${search.i_eval ne 0}">
									<c:set var="score" value="${search.i_score/search.i_eval}" />
									<c:choose>
										<c:when test="${empty score}">
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
										</c:when>
										<c:when test="${score eq 0}">
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
										</c:when>
										<c:when test="${score gt 4.5}">
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
										</c:when>
										<c:when test="${score gt 4.0}">
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fas fa-star-half-alt color_yellow"></i>
										</c:when>
										<c:when test="${score gt 3.5}">
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
										</c:when>
										<c:when test="${score gt 3.0}">
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fas fa-star-half-alt color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
										</c:when>
										<c:when test="${score gt 2.5}">
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
										</c:when>
										<c:when test="${score gt 2.0}">
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="fas fa-star-half-alt color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
										</c:when>
										<c:when test="${score gt 1.5}">
											<i class="fa fa-star color_yellow"></i>
											<i class="fa fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
										</c:when>
										<c:when test="${score gt 1.0}">
											<i class="fa fa-star color_yellow"></i>
											<i class="fas fa-star-half-alt color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
										</c:when>
										<c:when test="${score gt 0.5}">
											<i class="fa fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
										</c:when>
										<c:when test="${score le 0.5}">
											<i class="fas fa-star-half-alt color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
										</c:when>
										<c:otherwise>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
											<i class="far fa-star color_yellow"></i>
										</c:otherwise>
									</c:choose>
								</c:if>
								<i class='fas fa-user'></i> ${search.i_eval}

							</div>
							<div class="item_price">&#8361;${search.i_price}</div>

					</a></li>
				</div>
				<hr class="itemHr">
			</c:forEach>
		</c:otherwise>
	</c:choose>
</ul>

<!-- 페이징 번호 히단출력 -->
<div class="pull-right">
	<ul class="pagination">

		<c:if test="${pageMaker.prev}">
			<li class="paginate_button previous"><a
				href="${pageMaker.startPage -1}">이전으로</a></li>
		</c:if>

		<c:forEach var="num" begin="${pageMaker.startPage }"
			end="${pageMaker.endPage }">
			<li
				class="paginate_button ${pageMaker.paging.pageNum == num ? 'active':''} ">
				<a href="${num}">${num}</a>
			</li>
		</c:forEach>

		<c:if test="${pageMaker.next}">
			<li class="paginate_button next"><a
				href="${pageMaker.endPage +1}">다음으로</a></li>
		</c:if>
	</ul>
</div>

<!-- 페이지번호랑 전체 페이지 수 히든 태그로 넘기기 -->
<form id="actionForm" action="/item/search" method="get">
	<input type="hidden" name="pageNum"
		value="${pageMaker.paging.pageNum }"> <input type="hidden"
		name="amount" value="${pageMaker.paging.amount }"> <input
		id="iaddr" type="hidden" name="iAddr" value="${iaddr}"> <input
		id="isdate" type="hidden" name="iSdate" value="${isdate }"> <input
		id="iedate" type="hidden" name="iEdate" value="${iedate }"> <input
		id="ititle" type="hidden" name="iTitle" value="${ititle }">
</form>
<script>
	//페이지번호랑 전체 글 수 번호 

	var actionForm = $("#actionForm");

	$(".paginate_button a").on("click", function(e) {
		e.preventDefault();

		console.log("click");
		console.log($("#searchLocation").val());

		actionForm.find("input[name = 'pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	//상세보기 갔다가 리스트로 올때 페이지번호 유지
	/* $(".wrap_item_info").on("click", function(e){
		
		e.preventDefault();
		
		actionForm.append("<input type = 'hidden' name = 'i_id' value = '"+$(this).attr("href")+"'>");
		actionForm.attr("action", "/item/detail?i_id="+${search.i_id});
		actionForm.submit();
	}); */
</script>
<script>
	$(document).ready(function() {
		//가격에 콤마 찍기
		function numberWithCommas(price) {
			return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		$(".item_price").each(function() {
			var price = $(this).text()
			var detailPrice = numberWithCommas(price)
			$(this).text(detailPrice)

		})

	})
</script>
<script src="/resources/js/item.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>


