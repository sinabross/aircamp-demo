<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/mypage.css" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>


<div class="container-fluid">
	<div class="row ">
		<%@ include file="/WEB-INF/views/mypage/lnb.jsp"%>
		<div class="col-sm-9 cut">
			<h1 class="title_mypage_sub">이곳은 나의 게시글입니다.</h1>
			<c:choose>
				<c:when test="${empty list }">
					<h2>올린 게시글이 없습니다.</h2>
				</c:when>

				<c:otherwise>

					<div class="container">
						<div class="container-fluid">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>글번호</th>
										<th>글내용</th>
										<th>등록일</th>
									</tr>
								</thead>
								</c:otherwise>

								</c:choose>

								<tbody>
									<c:forEach items="${list}" var="Comm">
										<tr>
											<td class="col-md-2 col-sm-2 col-xs-2">${Comm.c_id }</td>
											<td class="col-md-5 col-sm-5 col-xs-5"><a
												href="/community/get?c_id=${Comm.c_id}&pageNum=1&amount=10">${Comm.c_title }</a></td>
											<td><fmt:formatDate pattern="yyyy-MM-dd"
													value="${Comm.c_regdate}" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>

							<!-- 페이징처리  ------------------>
							<div class="mypagePaging">
								<ul class="pagination pull-right">

									<c:if test="${pageMaker.prev}">
										<li class="commpageBtn previous"><a
											href="${pageMaker.startPage -1}">이전으로</a></li>
									</c:if>

									<c:forEach var="num" begin="${pageMaker.startPage }"
										end="${pageMaker.endPage }">
										<li
											class="commpageBtn ${pageMaker.paging.pageNum == num ? 'active':''} ">
											<a href="${num}">${num}</a>
										</li>
									</c:forEach>

									<c:if test="${pageMaker.next}">
										<li class="commpageBtn next"><a
											href="${pageMaker.endPage +1}">다음으로</a></li>
									</c:if>
								</ul>
							</div>

							<form id="commpageForm" action="/mypage/my_community"
								method="post">
								<input type="hidden" name="myid"
									value=<sec:authentication property="principal.member.m_id" />>
								<input type="hidden" name="pageNum"
									value="${pageMaker.paging.pageNum }"> <input
									type="hidden" name="amount" value="${pageMaker.paging.amount }">
								<input id="dataScurityHidden" type="hidden"
									name="${_csrf.parameterName}" value="${_csrf.token}">
							</form>

							<!-- 페이징처리끝  -->
						</div>
					</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {

		$(".menu_mypage_community").addClass("active")

	})
</script>
<script src="/resources/js/member.js"></script>
<script src="/resources/js/mypage.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

