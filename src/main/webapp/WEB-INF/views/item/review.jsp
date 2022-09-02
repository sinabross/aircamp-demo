<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	$(function(){
		
		var csrfHeaderName="${_csrf.headerName}";
		var csrfTokenValue="${_csrf.token}";
		
		//Ajax spring security header
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
				
		//별점 처리
		$(".review_star").on("click", function(){
			$(this).parent().children("span").removeClass("on");
			$(this).addClass("on").prevAll("span").addClass("on");
		});
		
		
		var i_id='${item.i_id}';
		var m_id=null;
		
		var ccc = '<sec:authorize access="isAnonymous()">';
			m_id=null;
	    var ddd = '</sec:authorize>';
	    var eee = '<sec:authorize access="isAuthenticated()">';
			m_id= '<sec:authentication property="principal.member.m_id"/>'; //로그인한 사용자의 아이디
	    var fff = '</sec:authorize>';
		
		
		//후기 등록 모달창 열기
		$(document.body).on("click", "#btnReviewModal", function(e){
			//모달창 초기화
			$("#reviewModal textarea").val("");
			$(".review_star").removeClass("on");
			$(".review_star:first-child").addClass("on");
			$("#btnReviewReg").show();
			$("#btnReviewUpdate").hide();
			$("#btnReviewDelete").hide();
			
			//로그인 여부 체크
			console.log($("#member").val());
			
			if($("#member").val()==null){
				console.log("noMember");
			}else{
				//작성자 체크
				console.log(m_id); //로그인한 사용자
				 		
				var aaa='<c:forEach items="${share}" var="share">';
				
				var shareMember = '${share.m_id}';
				console.log(shareMember);
				
				if(shareMember.includes(m_id)){
					console.log("OK");
					$(this).attr("data-target", "#reviewModal");
					
					return;
				}				
				var bbb='</c:forEach>';  
				
				alert("대여한 사용자만 후기를 등록할 수 있습니다.");
				$(this).removeAttr("data-toggle");
				$("#reviewModal").modal("hide");
				 
			}
						
		});
		
		
		//후기 등록
		$("#btnReviewReg").on("click", function(){
			var reviewScoreItem = $("#reviewScoreItem .on").length;
			var reviewScoreHost = $("#reviewScoreHost .on").length;
			
			$("input[name='s_score_i']").val(reviewScoreItem);
			$("input[name='s_score_m']").val(reviewScoreHost);
			
			
			if($("textarea").val()==null || $("textarea").val()==""){
				alert("후기를 입력해주세요");
			}else{
				if(confirm("후기를 등록하시겠습니까?")){
					
					var review={
							i_id: i_id,
							m_id: m_id,
							s_opi: $("textarea").val(),
							s_score_m: $("input[name='s_score_m']").val(),
							s_score_i: $("input[name='s_score_i']").val()
					};
					
					console.log(review);
					
					reviewService.add(review, function(result){
						if(result=="success"){
							alert("후기가 등록되었습니다.");
						}else{
							alert("후기를 등록할 수 없습니다.");
						}
						
						$("textarea").val("");
						$(".review_star").removeClass("on");
						$(".review_star:first-child").addClass("on");
						
						$("#reviewModal").modal("hide");
						
						showStarScore(i_id);
						showList(-1);
					});
					
				}
				
				
			}
			
		});
		
		
		//후기 목록
		var reviewList = $("#detailReviewList");
		var detailStarScore = $("#detailStarScore");
		
		showStarScore(i_id);
		showList(1);
		
		function showStarScore(i_id){
			
			reviewService.getStarScore({i_id:i_id},
					function(item){
												
						var strReview="";
						
						//별점 보여주기						
						strReview += '<b>별점&nbsp;</b>';
						
						//별점 평가자 수가 0인 경우
						if(item.i_eval==null || item.i_eval==0){
							strReview += '<i class="far fa-star color_yellow"></i>';
							strReview += '<i class="far fa-star color_yellow"></i>';
							strReview += '<i class="far fa-star color_yellow"></i>';
							strReview += '<i class="far fa-star color_yellow"></i>';
							strReview += '<i class="far fa-star color_yellow"></i>';
						}
						//별점 평가자 수가 0이 아닌 경우
						else if(item.i_eval!=null && item.i_eval!=0){
							
							var score = item.i_score/item.i_eval;
							
							if(score==null || score==0){
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
							}else if(score > 4.5){
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
							}else if(score > 4.0){
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fas fa-star-half-alt color_yellow"></i>';
							}else if(score > 3.5){
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
							}else if(score > 3.0){
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fas fa-star-half-alt color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
							}else if(score > 2.5){
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
							}else if(score > 2.0){
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fas fa-star-half-alt color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
							}else if(score > 1.5){
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
							}else if(score > 1.0){
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="fas fa-star-half-alt color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
							}else if(score > 0.5){
								strReview += '<i class="fa fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
							}else if(score <= 0.5){
								strReview += '<i class="fas fa-star-half-alt color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
							}else{
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
								strReview += '<i class="far fa-star color_yellow"></i>';
							}
						}
						strReview += '&nbsp;<span>(' + item.i_eval + '명 참여)</span>';
						
						detailStarScore.html(strReview);
					});
		}
		
		function showList(page){
			
			reviewService.getList({i_id:i_id, page:page||1}, 
					function(reviewCnt, list){
						//console.log("reviewCnt: " + reviewCnt);
						//console.log("reviewList: " + list);
						
						if(page==-1){
							pageNum = Math.ceil(reviewCnt/10.0);
							showList(pageNum);
							return;
						}
						
						var str="";
						
						if(list==null || list.length==0){
							reviewList.html("");
							return;
						}
						
						for(var i=0;i<list.length;i++){
							//console.log(list[i]);
							
							var obj = list[i];
							var objDate = new Date(obj.s_opidate).toISOString().slice(0, 10);
							
							str += '<li data-sid="' + obj.s_id +'" data-opi="' + obj.s_opi +'" data-opichk="' + obj.s_opi_chk + '" data-scorei="' + obj.s_score_i + '" data-scorem="' + obj.s_score_m + '">';
							str += '<div class="wrap_review_photo">';
							
							if(obj.m_path==null || obj.m_uuid==null || obj.m_filename==null){
								str += '<img class="img_member_photo" src="/resources/images/detail/img_member_default.png">';
							}else{
								str += '<span class="img_member_photo">';
								str += '<img class="img_member_profile" src="/item/displayMember?fileName=' + obj.m_path +'/s_' + obj.m_uuid + '_'+ obj.m_filename + '">';
								str += '</span>';
							}
							
							str += '<span class="review_member_name">' + obj.m_id + '</span>';
							str += '</div>';
							str += '<div class="wrap_review_content">';
							str += '<div class="review_content">' + obj.s_opi + '</div>';
							str += '<div class="review_regdate">';
							str += '<span>' + objDate + '</span>';
							str += '</div>';
							str += '</div>';
							
							
							//로그인 사용자와 후기 작성자가 일치할 때
							//후기 수정, 삭제 아이콘 보여주기
							if($("#member").val()==null){
								console.log("noMember");
							}else{
								
								if(m_id==obj.m_id){
									
									str += '<div class="wrap_review_btn">';
									str += '<button class="btn_review_update"><i class="fas fa-edit"></i></button>';
									str += '<button class="btn_review_delete"><i class="fas fa-trash-alt"></i></button>';
									str += '</div>';
									
								}
								
							}
							
							str += '</li>';
							str += '<hr class="line_detail">';
						}
						reviewList.html(str);
						
						showReplyPage(reviewCnt);
						
					}//end function		
			);
		}//end function showList
		
		
		//후기 페이징
		var pageNum=1;
		var reviewPageFooter=$("#reviewPaging");
		
		function showReplyPage(reviewCnt){
			var endNum=Math.ceil(pageNum/10.0)*10;
			var startNum=endNum-9;
			
			var prev=startNum!=1;// startNum가 1이 아니면 true.
			var next=false;
			
			if(endNum*10>=reviewCnt){
				endNum=Math.ceil(reviewCnt/10.0);        				
			}
			
			//다음페이지가 있으면
			if(endNum*10<reviewCnt){
				next=true;
			}
			
			var str="<ul class='pagination'>";
			
			if(prev){
				str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
			}
			
			for(var i=startNum;i<=endNum;i++){
				//현재페이지이면 active 클래스 적용
				var active=pageNum==i? "active":"";
				str+="<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
				
			}
			
			if(next){
				str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
			}
			
			str+="</ul>";
			
			reviewPageFooter.html(str);
		}
		
		//후기페이징 페이지번호 이벤트처리
		reviewPageFooter.on("click","li a",function(e){
			//링크를 클릭해서 다른 페이지로 이동하는 것을 막음.
			e.preventDefault();
			console.log("page click");
			
			var targetPageNum=$(this).attr("href");
			console.log("targetPageNum: "+targetPageNum);
			pageNum=targetPageNum;
			showList(pageNum);
		});
		
		
		//후기 불러오기
		$(document.body).on("click", ".btn_review_update", function(e) {
			var s_id = $(this).parent().parent().data("sid");
			console.log(s_id);
			
			reviewService.get(s_id, function(review){
				
				var scoreItem = review.s_score_i;
				var scoreHost = review.s_score_m;
				
				$("input[name='s_id']").val(review.s_id);
				$("#reviewModal textarea").val(review.s_opi);
				$("#reviewModal .review_star").removeClass("on");
				
				for(var i=1;i<=scoreItem;i++){
					$("#reviewScoreItem .review_star:nth-child(" + i + ")").addClass("on");					
				}
				
				for(var j=1;j<=scoreHost;j++){
					$("#reviewScoreHost .review_star:nth-child(" + j + ")").addClass("on");
				}				
				
				$("#reviewModal").modal("show");
				$("#btnReviewReg").hide();
				$("#btnReviewUpdate").show();
				$("#btnReviewDelete").show();
				
			});
			
		});
		
		
		//후기 수정하기
		$("#btnReviewUpdate").on("click",function(e){
			var reviewScoreItem = $("#reviewScoreItem .on").length;
			var reviewScoreHost = $("#reviewScoreHost .on").length;
			
			$("input[name='s_score_i']").val(reviewScoreItem);
			$("input[name='s_score_m']").val(reviewScoreHost);
			
			if($("textarea").val()==null || $("textarea").val()==""){
				alert("후기를 입력해주세요");
			}else{
				if(confirm("수정하시겠습니까?")){
					var review={
							s_id:$("input[name='s_id']").val(),
							s_opi: $("textarea").val(),
							s_score_m: $("input[name='s_score_m']").val(),
							s_score_i: $("input[name='s_score_i']").val()
					};
					
					console.log(review);
					
					reviewService.update(review, function(result){
						alert(result);
						$("#reviewModal").modal("hide");
						
						showStarScore(i_id); //별점 갱신
						showList(pageNum); //목록 갱신
					});
				}
				
				
			}
			
		});
		
		
		//후기 삭제하기
		$("#btnReviewDelete").on("click",function(e){
			if(confirm("정말 삭제하시겠습니까?")){
				
				var s_id=$("input[name='s_id']").val();
				console.log(s_id);
				
				var review={
						s_id:$("input[name='s_id']").val(),
						i_id:i_id,
						s_opi: $("textarea").val(),
						s_opi_chk: 1,
						s_score_m: $("input[name='s_score_m']").val(),
						s_score_i: $("input[name='s_score_i']").val()
				};
				
				
				reviewService.remove(review, function(result){
					alert(result);
					$("#reviewModal").modal("hide");
					
					showStarScore(i_id); //별점 갱신
					showList(pageNum); //목록 갱신
				});
			}
			
		});
		
		//후기 목록에서 후기 삭제하기
		$(document.body).on("click", ".btn_review_delete", function(e){
			if(confirm("정말 삭제하시겠습니까?")){
				
				var review={
						s_id:$(this).parent().parent().data("sid"),
						i_id:i_id,
						s_opi: $(this).parent().parent().data("opi"),
						s_opi_chk: $(this).parent().parent().data("opichk"),
						s_score_m: $(this).parent().parent().data("scorem"),
						s_score_i: $(this).parent().parent().data("scorei")
				};
				
				reviewService.remove(review, function(result){
					alert(result);
					$("#reviewModal").modal("hide");
					
					showStarScore(i_id);//별점 갱신
					showList(pageNum);//목록갱신
				});
			}
		});
		
		
	});
</script>

    
<!-- Review Modal --------------------------------->
<div class="modal" id="reviewModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h1 class="modal-title">REVIEW</h1>
      </div>

      <!-- Modal body -->
      <div class="modal-body" id="reviewBody">
      	<input type="hidden" name="s_id">
        <div>
        	<h4>후기</h4>
        	<textarea class="txt_review" name="s_opi" rows="10" placeholder="후기를 등록해주세요"></textarea>
        </div>
        <div class="wrap_review_star">
        	<h4>아이템 별점</h4>
        	<input type="hidden" name="s_score_i">
        	<div id="reviewScoreItem" class="review_star_score">
        		<span class="review_star color_gray on"><i class="fa fa-star"></i></span>
        		<span class="review_star color_gray"><i class="fa fa-star"></i></span>
        		<span class="review_star color_gray"><i class="fa fa-star"></i></span>
        		<span class="review_star color_gray"><i class="fa fa-star"></i></span>
        		<span class="review_star color_gray"><i class="fa fa-star"></i></span>
        	</div>
        </div>
        <div class="wrap_review_star">
        	<h4>호스트 별점</h4>
        	<input type="hidden" name="s_score_m">
        	<div id="reviewScoreHost" class="review_star_score">
        		<span class="review_star color_gray on"><i class="fa fa-star"></i></span>
        		<span class="review_star color_gray"><i class="fa fa-star"></i></span>
        		<span class="review_star color_gray"><i class="fa fa-star"></i></span>
        		<span class="review_star color_gray"><i class="fa fa-star"></i></span>
        		<span class="review_star color_gray"><i class="fa fa-star"></i></span>
        	</div>
        </div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" class="btn_review color_air_green" id="btnReviewReg">등록</button>
      	<button type="button" class="btn_review color_air_green" id="btnReviewUpdate">수정</button>
      	<button type="button" class="btn_review color_air_green" id="btnReviewDelete">삭제</button>
        <button type="button" class="btn_review color_air_green" id="btnReviewClose" data-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>
<!-- end Review Modal -->


