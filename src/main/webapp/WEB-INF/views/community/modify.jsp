<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/community.css" />
<title>Community Modify</title>

<form role="form" action="/community/modify" method="post">
	<input type="hidden" name="${_csrf.parameterName }"
		value="${_csrf.token }"> <input type="hidden" name="pageNum"
		value="${paging.pageNum }"> <input type="hidden" name="amount"
		value="${paging.amount }"> <input type="hidden" name="keyword"
		value="${paging.keyword }"> <input type="hidden" name="type"
		value="${paging.type }">

	<div class="form-group">
		<label>글번호</label><input class="form-control" name="c_id"
			value="<c:out value ='${comm.c_id }'/>" readonly="readonly">
	</div>
	<div class="form-group">
		<label>제목</label><input class="form-control" name="c_title"
			value="<c:out value ='${comm.c_title }'/>">
	</div>
	<div class="form-group">
		<label>글 내용</label>
		<textarea class="form-control" rows="3" name="c_content"><c:out
				value='${comm.c_content }' /></textarea>
	</div>
	<div class="form-group">
		<label>글 쓴이</label><input class="form-control" name="m_id"
			value="${comm.m_id }" readonly="readonly"></input>
	</div>
	<div class="form-group">
		<label>작성일</label><input class="form-control" name="c_regdate"
			value="<fmt:formatDate pattern = "yy/MM/dd" value="${comm.c_regdate}"/>"
			readonly="readonly"></input>
	</div>

	<sec:authentication property="principal.member" var="pinfo" />

	<sec:authorize access="isAuthenticated()">
		<c:if test="${pinfo.m_id eq comm.m_id}">
			<button type = "submit" data-oper="modify" class="btn btn_comm">수정</button>
			<button type = "submit"  data-oper="remove" class="btn btn_comm">삭제</button>
		</c:if>
	</sec:authorize>
	<button type="submit" data-oper="list" class="btn btn_comm">목록</button>
</form>


<script>
	$(document).ready(
			function() {

				var formObj = $('form');
				 $('button')
						.on(
								"click",
								function(e) {

									e.preventDefault();

									var operation = $(this).data("oper");

									console.log(operation);

									/* 삭제버튼 누를 시 바로 삭제 후 리스트로 이동 */
									if (operation === 'remove') {
										formObj.attr("action",
												"/community/remove");
										
									/* 리스트버튼 누를 시 리스트로 이동 */	
									} else if (operation === 'list') {
										formObj.attr("action",
												"/community/list").attr(
												"method", "get");
										var pageNumTag = $(
												"input[name = 'pageNum']")
												.clone();
										var amountTag = $(
												"input[name = 'amount']")
												.clone();
										var keywordTag = $(
												"input[name = 'keyword']")
												.clone();
										var typeTag = $("input[name = 'type']")
												.clone();
										
										formObj.empty();
										
										formObj.append(pageNumTag);
										formObj.append(amountTag);
										formObj.append(keywordTag);
										formObj.append(typeTag);
									}
									formObj.submit();
									
								});
			});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>