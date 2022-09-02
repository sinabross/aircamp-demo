<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/community.css" />


<title>Community Get</title>


<div class="panel-body">
	<input type="hidden" name="${_csrf.parameterName }"
		value="${_csrf.token }">
		
	<div class="form-group">
		<label>제목</label><input class="form-control" name="c_title"
			value="${comm.c_title}" readonly="readonly">
	</div>
	<div class="form-group">
		<label>글 내용</label>
		<textarea class="form-control" rows="3" name="c_content"
			readonly="readonly">${comm.c_content}</textarea>
	</div>
	<div class="form-group">
		<label>글 쓴이</label><input class="form-control" name="m_id"
			value="${comm.m_id}" readonly="readonly"></input>
	</div>
	
	
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.member" var = "pinfo" />
		<c:if test ="${pinfo.m_id eq comm.m_id}">
			<button data-oper="modify" class="btn btn_air btn_comm_modify">수정</button>
		</c:if>
	</sec:authorize>
		
	<button data-oper="list" class="btn btn_air btn_comm_list">목록</button>
</div>

<!-- 수정 및 목록 버튼 누를 시 작용-->
<form id ="operForm" action = "community/modfiy" method = "get">
	<input type="hidden" name="pageNum" value="${paging.pageNum }">
	<input type="hidden" name="amount" value="${paging.amount }"> <input
		type="hidden" name="keyword" value="${paging.keyword }"> <input
		type="hidden" name="type" value="${paging.type }"> <input
		type="hidden" id="c_id" name="c_id" value='<c:out value = "${comm.c_id }"></c:out>'>
</form>



<!-- 페이지번호랑 전체 페이지 수 히든 태그로 넘기기 -->
<form id="actionForm" action="/community/modify" method="get">
	<input type="hidden" name="pageNum" value="${paging.pageNum }">
	<input type="hidden" name="amount" value="${paging.amount }"> <input
		type="hidden" name="keyword" value="${paging.keyword }"> <input
		type="hidden" name="type" value="${paging.type }"> <input
		type="hidden" id="c_id" name="c_id" value='<c:out value = "${comm.c_id }"></c:out>'>
</form>

<!-- 댓글 -->
<div class='row'>
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> 댓글
				<sec:authorize access="isAuthenticated()">
					<button id='replyBtnAdd' class='btn btn_air btn-xs pull-right'>댓글 작성</button>
				</sec:authorize>
			</div>
			<div class="panel-body">
				<ul class="reply_chat">

				</ul>
			</div>
			<div class="panel-footer">
			
			</div>
		</div>
		
	</div>
</div>

<!-- 댓글 Modal -->
<div class="modal fade" id="replyModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글 모달</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>댓글 내용</label> <input class="form-control" name='r_content'>
				</div>
				<div class="form-group">
					<label>작성자</label> <input class="form-control" name='m_id' readonly="readonly">
				</div>
				<div class="form-group">
					<label>게시일</label> <input class="form-control"
						name='r_regdate'>
				</div>
			</div>
			<div class="modal-footer">
				<button id='replyBtnModify' type="button" class="btn btn_comm_reply">수정</button>
				<button id='replyBtnRemove' type="button" class="btn btn_comm_reply">삭제</button>
				<button id='replyBtnRegister' type="button" class="btn btn_comm_reply">등록</button>
				<button id='replyBtnClose' type="button" class="btn btn_air_white" data-dismiss = "modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<script src="/resources/js/reply.js"></script>


<script>
	$(document)
			.ready(
					function() {

						// 댓글출력
						var c_idValue = '<c:out value = "${comm.c_id}"/>';
						var replyUL = $(".reply_chat");

						showList(1);

						function showList(page) {

							replyService
									.getList(
											{
												c_id : c_idValue,
												page : page || 1
											},
											function(replyCnt, list) {
												
												console.log("replyCnt============================="+replyCnt);
												
												if(page == -1){
													pageNum = Math.ceil(replyCnt/10.0);
													showList(pageNum);
													return;
												}

												var str = "";
												if (list == null
														|| list.length == 0) {
													replyUL.html("");

													return;
												}
												for (var i = 0, len = list.length || 0; i < len; i++) {
													str += "<li class = 'left clearfix' data-r_id ='"+list[i].r_id+"'>";
													str += " <div><div class = 'header'><strong class = 'primary-font'>"
															+ list[i].m_id
															+ "</strong>";
													str += "  <small class = 'pull-right text-muted'>"
															+ replyService
																	.displayTime(list[i].r_regdate)
															+ "</small></div>";
													str += "   <p>"
															+ list[i].r_content
															+ "</p></div></li>";
												}
												replyUL.html(str);
												
												showReplyPage(replyCnt);
											});
						}
						

						// 댓글 모달창
						var modal = $("#replyModal");
						
						var modalInputR_content = modal.find("input[name='r_content']");
						var modalInputM_id = modal.find("input[name = 'm_id']");
						var modalInputR_regdate = modal.find("input[name = 'r_regdate']");
	
						var modalModBtn = $("#replyBtnModify");
						var modalRemoveBtn = $("#replyBtnRemove");
						var modalRegisterBtn = $("#replyBtnRegister");
						
						// 댓글 등록시 사용자가 맞는지 안맞는지 확인
						var m_id = null;
						
						<sec:authorize access = "isAuthenticated()">
							m_id = '<sec:authentication property="principal.member.m_id"/>';
						</sec:authorize>
						
						var csrfHeaderName = "${_csrf.headerName}";
						var csrfTokenValue = "${_csrf.token}";
						
						// 새로운 댓글 등록
						$("#replyBtnAdd").on("click", function(e){
							
							modal.find("input").val("");
							modal.find("input[name = 'm_id']").val(m_id);
							modalInputR_regdate.closest("div").hide();
							modal.find("button[id != 'replyBtnClose']").hide();
							
							modalRegisterBtn.show();
							
							modal.modal("show");
						});
						
						$(document).ajaxSend(function(e, xhr, options){
							xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
						});
						
					
						// 댓글 등록 버튼
						modalRegisterBtn.on("click", function(e){
							
							console.log("==============================btn");
							
							var reply = {
									r_content : modal.find("input[name='r_content']").val(),
									m_id : modal.find("input[name = 'm_id']").val(),
									c_id : "${comm.c_id}"
							};
							replyService.add(reply, function(result){
								
								alert(result);
								console.log("-================================="+result);
								
								modal.find("input").val("");
								modal.modal("hide");
								
								//showList(1);
								showList(-1);
								console.log("==============================ajax");
								
							});
						});
						
						// 댓글 클릭 이벤트
						$(".reply_chat").on("click", "li", function(e){
							
							var r_id = $(this).data("r_id");
							
							replyService.get(r_id, function(reply){
								
								modalInputR_content.val(reply.r_content);
								console.log("========================================================"+reply.r_content);
								modalInputM_id.val(reply.m_id);
								modalInputR_regdate.val(replyService.displayTime(reply.r_regdate)).attr("readonly", "readonly");
								modal.data("r_id", reply.r_id);
								
								modal.find("button[id != 'replyBtnClose']").hide();
								modalModBtn.show();
								modalRemoveBtn.show();
								
								modal.modal("show");
								
							});
						});
						
						// 댓글 수정버튼
						modalModBtn.on("click", function(e){
							
							var reply = {r_id:modal.data("r_id"), r_content:modalInputR_content.val(), m_id:modalInputM_id.val()};
							
							replyService.update(reply, function(result) {
								
								console.log("=================================succes");
								
								alert(result);
								modal.modal("hide");
								showList(pageNum);
							});
						});
						
						// 댓글 삭제버튼
						modalRemoveBtn.on("click", function(e){
							
							var r_id = modal.data("r_id");
							
							console.log("r_id" + r_id);
							console.log("m_id" + m_id);
							
							if(!m_id){
								alert("로그인 후 삭제가 가능합니다.");
								modal.modal("hide");
								return;
							}
							
							var originalMid = modalInputM_id.val();
							
							console.log("originalM_id : " + originalMid);
							
							if(m_id != originalMid) {
							
								alert("자신이 작성한 댓글만 삭제가 가능합니다.");
								modal.modal("hide");
								return;
							}
							
							replyService.remove(r_id, originalMid, function(result){
								
								console.log("-------------------------------------------")
								alert(result);
								modal.modal("hide");
								showList(pageNum);
							});
						});
						
						// 댓글 페이지 번호 출력
						
						var pageNum = 1;
						var replyPageFooter = $(".panel-footer");
						
						function showReplyPage(replyCnt) {
							
							var endNum = Math.ceil(pageNum / 10.0) * 10;
							var startNum = endNum -9;
							
							var prev = startNum != 1;
							var next = false;
							
							if(endNum * 10 >= replyCnt){
								endNum = Math.ceil(replyCnt/10.0);
							}
							if(endNum * 10 < replyCnt){
								next = true;
							}
							
							var str = "<ul class ='pagination pull-right'>";
							
							if(prev){
								str += "<li class = 'page-item>'<a class = 'page-link' href='"+(startNum -1)+"'>Previous</a></li>";
							}
							
							for(var i = startNum ; i <= endNum; i++){
								
								var active = pageNum == i? "active":"";
								
								str += "<li class = 'page-item "+active+" '><a class = 'page-link' href='"+i+"'>"+i+"</a></li>";
							}
							
							if(next){
								str += "<li class = 'page-item'><a class= 'page-link' href ='"+(endNum + 1)+"'>Next</a></li>";
							}
							
							str += "</ul></div>";
							
							console.log(str);
							
							replyPageFooter.html(str);
						}
						
						// 댓글 페이지번호 클릭시 새로운 댓글 가져오기
						replyPageFooter.on("click", "li a", function(e){
							e.preventDefault();
							
							console.log("page click");
							
							var targetPageNum = $(this).attr("href");
							
							console.log("targetPageNum : " + targetPageNum);
							
							pageNum = targetPageNum;
							
							showList(pageNum);
						});
						

						// 게시판 수정 버튼 및 목록 버튼
						var operForm = $("#operForm");

						$("button[data-oper ='modify']").on("click",function(e) {
							
							operForm.attr("action","/community/modify").submit();
										});

						$("button[data-oper ='list']").on("click", function(e) {
							operForm.find("#c_id").remove();
							operForm.attr("action", "/community/list");
							operForm.submit();
						});
						
				});
					
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
