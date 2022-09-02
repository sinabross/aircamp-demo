<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/community.css" />
<style>
</style>

<div class="wrap_communtiy_title">
	<h2>Community List</h2>
	
	<!-- 등록하기 버튼 -->
	<sec:authorize access="isAuthenticated()">
	<button id="regCommunityBtn" class="btn btn_air btn_comm_regbtn">등록하기</button>
	</sec:authorize>
	<sec:authorize access="isAnonymous()">
	<button data-toggle="modal" data-target="#modalAir" onclick="haveToLogin()" class="btn btn_air btn_comm_regbtn">등록하기</button>
	</sec:authorize>
</div>

<!-- 커뮤니티 리스트 출력테이블-->
<table>
	<thead>
		<tr class="commTr">
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list}" var="comm">
			<tr class="commTr">
				<td><c:out value="${comm.c_id}"></c:out></td>
				<td><a class="move" href="${comm.c_id }">${comm.c_title }</a></td>
				<td><c:out value="${comm.m_id}"></c:out></td>
				<td><fmt:formatDate pattern="yy-MM-dd"
						value="${comm.c_regdate}"></fmt:formatDate></td>
				<td><c:out value="${comm.c_read_cnt}"></c:out></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<!-- 검색 바 -->
<div class="row">
	<div class="col-lg-12">
		<form id="searchForm" action="/community/list" method="get">
			<select name='type'>
				<option value=""
					<c:out value = "${pageMaker.paging.type == null ? 'selected':''}"/>>--</option>
				<option value="T"
					<c:out value = "${pageMaker.paging.type eq 'T' ? 'selected':''}"/>>제목</option>
				<option value="C"
					<c:out value = "${pageMaker.paging.type eq 'C' ? 'selected':''}"/>>내용</option>
				<option value="W"
					<c:out value = "${pageMaker.paging.type eq 'W' ? 'selected':''}"/>>작성자</option>
				<option value="TC"
					<c:out value = "${pageMaker.paging.type eq 'TC' ? 'selected':''}"/>>제목
					or 내용</option>
				<option value="TW"
					<c:out value = "${pageMaker.paging.type eq 'TW' ? 'selected':''}"/>>제목
					or 작성자</option>
				<option value="TCW"
					<c:out value = "${pageMaker.paging.type eq 'TCW' ? 'selected':''}"/>>제목
					or 내용 or 작성자</option>
			</select> <input type="text" name="keyword"
				value='<c:out value ="${pageMaker.paging.keyword }"/>' /> <input
				type="hidden" name="pageNum"
				value='<c:out value ="${pageMaker.paging.pageNum }"/>' /> <input
				type="hidden" name="amount"
				value='<c:out value ="${pageMaker.paging.amount }"/>' /> <input
				type="hidden" name="type"
				value='<c:out value ="${pageMaker.paging.type }"/>' />
			<button class="btn btn_air btn_comm_search">검색</button>
		</form>
	</div>
</div>

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

<!-- 결과 모달창 -->
<div class="modal fade" id="commResultModal" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">등록완료</h4>
			</div>
			<div class="modal-body">
				<p>처리가 완료되었습니다.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- 페이지번호랑 전체 페이지 수 히든 태그로 넘기기 -->
<form id="actionForm" action="/community/list" method="get">
	<input type="hidden" name="pageNum"
		value="${pageMaker.paging.pageNum }"> <input type="hidden"
		name="amount" value="${pageMaker.paging.amount }"> <input
		type="hidden" name="keyword"
		value='<c:out value ="${pageMaker.paging.keyword }"/>' /> <input
		type="hidden" name="type"
		value='<c:out value ="${pageMaker.paging.type }"/>' />
</form>


<!-- 모달 및 히스토리 막기 및 등록버튼 사용 -->
<script>
	$(document)
			.ready(
					function() {
						var a = "${comm.c_id}";
						console.log(a);

						var result = '<c:out value = "${result}"/>';

						checkModal(result);

						// 히스토리 제거
						history.replaceState({}, null, null);

						// 모달창 띄우기
						function checkModal(result) {
							if (result === '' || history.state) {
								return;
							}
							if (parseInt(result) > 0) {
								$(".modal-body").html(
										"게시글 " + parseInt(result)
												+ "번이 등록되었습니다.");
							}
							$("#commResultModal").modal("show");
						}

						// 등록버튼
						$("#regCommunityBtn").on("click", function() {
							self.location = "/community/register";
						});

						// 페이지번호랑 전체 글 수 번호 
						var actionForm = $("#actionForm");

						$(".paginate_button a").on(
								"click",
								function(e) {
									e.preventDefault();

									console.log("click");

									actionForm.find("input[name = 'pageNum']")
											.val($(this).attr("href"));
									actionForm.submit();
								});

						// 상세보기 갔다가 리스트로 올때 페이지번호 유지
						$(".move")
								.on(
										"click",
										function(e) {

											e.preventDefault();

											actionForm
													.append("<input type = 'hidden' name = 'c_id' value = '"
															+ $(this).attr(
																	"href")
															+ "'>");
											actionForm.attr("action",
													"/community/get");
											actionForm.submit();
										});

						// 검색 버튼
						var searchForm = $("#searchForm");

						$("#searchForm button").on(
								"click",
								function(e) {

									if (!searchForm.find("option:selected")
											.val()) {
										alert("검색 종류를 선택하세요");
										return false;
									}
									if (!searchForm.find(
											"input[name='keyword']").val()) {
										alert("키워드를 입력하세요");
										return false;
									}
									searchForm.find("input[name='pageNum']")
											.val("1");
									e.preventDefault();

									searchForm.submit();
								});
					});
</script>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>