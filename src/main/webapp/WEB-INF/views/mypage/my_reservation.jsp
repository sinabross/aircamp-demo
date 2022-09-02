<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="/resources/js/mypage.js"></script>


<div class="container-fluid ">

	<sec:authorize access="isAuthenticated()">
		<input type="hidden" id="member" name="m_id"
			value=<sec:authentication property="principal.member.m_id"/>>
	</sec:authorize>
	<div class="row">

		<%@ include file="/WEB-INF/views/mypage/lnb.jsp"%>
		<div class="col-sm-9">
			<h1>나의 대여정보</h1>
			<c:choose>
				<c:when test="${empty list }">
					<h2>예약정보가 없습니다.</h2>
				</c:when>

			</c:choose>
			<c:forEach items="${list}" var="share">
				<div class="warp">

					<a href="/item/detail?i_id=${share.i_id }">
						<div class="box1">
							<input type="hidden" class="memberId" name="m_id"
								value="<sec:authentication property="principal.member.m_id" />">
							<input type="hidden" class="s_idVal" name="s_id"
								value="${share.s_id }"> <input type="hidden"
								class="i_idVal" name="i_id" value="${share.i_id }">
							<div id="title">${share.i_title }</div>
							<div id="sysdate">
								<fmt:formatDate pattern="yyyy-MM-dd" value="${share.s_regdate}" />
							</div>
						</div>
						<div class="mypage_box2">
							<input type="hidden" class="sdateVal" name="s_sdate"
								value="${share.s_sdate }">
							<div id="sdate">대여일: ${share.s_sdate }</div>
							~

							<div id="edate">${share.s_edate }</div>
						</div>
						<div id="price">가격: ${share.s_price}원</div>
					</a>

					<div class="box3">
						<div id="addr">
							<i class="fas fa-map-marker-alt"></i>${share.s_addr }</div>
						<div id="shareCancel" class="cancelBtn pull-right">
							<%-- <button type="button" class="btn btn-air btnCancel ">예약취소</button>
									<button type="button" class="btn btn-air btnReview">후기등록</button> --%>
						</div>

					</div>

					<hr>
				</div>

			</c:forEach>
			<%@ include file="/WEB-INF/views/mypage/review.jsp"%>

			<!-- 페이징처리  ------------------>
			<div class="mypagePaging">
				<ul class="pagination pull-right">

					<c:if test="${pageMaker.prev}">
						<li class=" sharepageBtn previous"><a
							href="${pageMaker.startPage -1}">이전으로</a></li>
					</c:if>

					<c:forEach var="num" begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }">
						<li
							class=" sharepageBtn ${pageMaker.paging.pageNum == num ? 'active':''} ">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>

					<c:if test="${pageMaker.next}">
						<li class=" sharepageBtn next"><a
							href="${pageMaker.endPage +1}">다음으로</a></li>
					</c:if>
				</ul>
			</div>

			<form id="sharepageForm" action="/mypage/my_reservation"
				method="post">
				<input type="hidden" name="myid"
					value=<sec:authentication property="principal.member.m_id" />>
				<input type="hidden" name="pageNum"
					value="${pageMaker.paging.pageNum }"> <input type="hidden"
					name="amount" value="${pageMaker.paging.amount }"> <input
					id="dataScurityHidden" type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}">
			</form>

			<!-- 페이징처리끝  -->


		</div>

	</div>
</div>

<script>
	$(document).ready(function() {

		$(".menu_mypage_reservation").addClass("active")
	})
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<script src="/resources/js/member.js"></script>
<script src="/resources/js/review.js"></script>
