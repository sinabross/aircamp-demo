<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="container-fluid">
	<div class="row ">

		<%@ include file="/WEB-INF/views/mypage/lnb.jsp"%>
		<input id="myid" type="hidden"
			value=<sec:authentication property="principal.member.m_id" />>
		<div class="col-sm-9">
			<h1>나의 공유정보</h1>
			<!-- 정보가 없으면 뜨는 값! -->
			<c:choose>
				<c:when test="${empty list }">
					<h2>등록정보가 없습니다. 호스팅해주세요.</h2>
				</c:when>

			</c:choose>
			<c:forEach items="${list}" var="Item">

				<div class="warp">
					<a href="/item/detail?i_id=${Item.i_id }">
						<div class="box1">
							<div id="title">${Item.i_title }</div>
							<div id="sysdate">
								<fmt:formatDate pattern="yyyy/MM/dd" value="${Item.i_regdate}" />
							</div>
						</div>
						<div class="mypage_box2">
							<div id="sdate">대여가능날짜: ${Item.i_sdate }</div>
							~
							<div id="edate">${Item.i_edate }</div>
						</div>
						<div id="price">가격: ${Item.i_price}원</div>
						<div class="box3">
							<div id="addr">
								<i class="fas fa-map-marker-alt"></i>${Item.i_addr }</div>
							<!-- 	<div id="ItemCancel" class="cancelBtn"> -->
							<button id="ItemCancel" type="button"
								class="btn btn_air pull-right ">등록취소</button>
							<!-- 	</div> -->
						</div>
					</a>
					<hr>
					<div class="box_item_share col-md-12 col-sm-12 col-xs-12">
						<li>
							<div class="item_share_hr col-md-2 col-sm-2 col-xs-2">대여자</div>
							<div class="item_share_hr col-md-3 col-sm-3 col-xs-3">대여일</div>
							<div class="item_share_hr col-md-3 col-sm-3 col-xs-3">반납일</div>
							<div class="item_share_hr col-md-2 col-sm-2 col-xs-2">대여상태</div> <!-- (취소버튼/대여중/반납/(취소되었음?일단하고추가)) -->
							<div class="item_share_hr col-md-2 col-sm-2 col-xs-2">취소</div>
						</li>
						<hr>
						<!-- for each -->

						<c:forEach items="${Item.shareList}" var="reservation">
							<li class="list_item_share col-md-12 col-sm-12">
								<form method="post" action="/mypage/sharecanclehost">
									<input type="hidden" name="${_csrf.parameterName }"
										value="${_csrf.token }"> <input type="hidden"
										name="myid"
										value='<sec:authentication property="principal.member.m_id" />'>
									<input type="hidden" name="i_id" type="hidden"
										value="${reservation.i_id}"> <input
										class="item_share_sid" name="s_id" type="hidden"
										value="${reservation.s_id}"> <input name="m_id"
										class="item_share_mid col-md-2 col-sm-2 col-xs-2" readonly
										value="${reservation.m_id}"> <input name="s_sdate"
										class="item_share_sdate col-md-3 col-sm-3 col-xs-3" readonly
										value="${reservation.s_sdate}"> <input name="s_edate"
										class="item_share_edate col-md-3 col-sm-3 col-xs-3" readonly
										value="${reservation.s_edate}"> <input
										class="item_share_status col-md-2 col-sm-2 col-xs-2"  readonly>
									<div class="item_share_cancle col-md-2 col-sm-2 col-xs-2"></div>
								</form>
							</li>
							<!-- 대여내역끝 -->
						</c:forEach>
					</div>

				</div>



			</c:forEach>
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

			<form id="sharepageForm" action="/mypage/my_share"
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

		$(".menu_mypage_post").addClass("active")
	})
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<script src="/resources/js/member.js"></script>
<script src="/resources/js/mypage.js"></script>


