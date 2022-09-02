<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/detail.css" />
<link rel="stylesheet" href="/resources/css/review.css" />

<script>
	$(function() {

		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";

		//Ajax spring security header
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});

		//별점 처리
		$(".review_star").on("click", function() {
			$(this).parent().children("span").removeClass("on");
			$(this).addClass("on").prevAll("span").addClass("on");
		});

		var i_id 
		var s_id=$("input[name='s_id']").val()
		var m_id = $("#member").val();


		//후기 등록 모달창 열기
		$(".btnReviewModal").each(function(i){
			//모달창 초기화
			$("#reviewModal textarea").val("");
			$(".review_star").removeClass("on");
			$(".review_star:first-child").addClass("on");
			$("#btnReviewReg").show();
			$("#btnReviewUpdate").hide();
			$("#btnReviewDelete").hide();
			i_id=$(".i_idVal").eq(i).val()
			s_id=$(".s_idVal").eq(i).val()

		})
		

		//후기 등록
		$("#btnReviewReg").on("click", function() {
			var reviewScoreItem = $("#reviewScoreItem .on").length;
			var reviewScoreHost = $("#reviewScoreHost .on").length;

			$("input[name='s_score_i']").val(reviewScoreItem);
			$("input[name='s_score_m']").val(reviewScoreHost);
			

			if ($("textarea").val() == null || $("textarea").val() == "") {
				alert("후기를 입력해주세요");
			} else {
				if (confirm("후기를 등록하시겠습니까?")) {

					var review = {
						i_id : i_id,
						m_id : m_id,
						s_id: s_id,
						s_opi : $("textarea").val(),
						s_score_m : $("input[name='s_score_m']").val(),
						s_score_i : $("input[name='s_score_i']").val()
					};

					console.log(review);

					reviewService.addMypage(review, function(result) {
						if (result == "success") {
							alert("후기가 등록되었습니다.");
						} else {
							alert("후기를 등록할 수 없습니다.");
						}

						$("textarea").val("");
						$(".review_star").removeClass("on");
						$(".review_star:first-child").addClass("on");

						$("#reviewModal").modal("hide");

						showList(-1);

					});

				}

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
					<textarea class="txt_review" name="s_opi" rows="10"
						placeholder="후기를 등록해주세요"></textarea>
				</div>
				<div class="wrap_review_star">
					<h4>아이템 별점</h4>
					<input type="hidden" name="s_score_i">
					<div id="reviewScoreItem" class="review_star_score">
						<span class="review_star color_gray on"><i
							class="fa fa-star"></i></span> <span class="review_star color_gray"><i
							class="fa fa-star"></i></span> <span class="review_star color_gray"><i
							class="fa fa-star"></i></span> <span class="review_star color_gray"><i
							class="fa fa-star"></i></span> <span class="review_star color_gray"><i
							class="fa fa-star"></i></span>
					</div>
				</div>
				<div class="wrap_review_star">
					<h4>호스트 별점</h4>
					<input type="hidden" name="s_score_m">
					<div id="reviewScoreHost" class="review_star_score">
						<span class="review_star color_gray on"><i
							class="fa fa-star"></i></span> <span class="review_star color_gray"><i
							class="fa fa-star"></i></span> <span class="review_star color_gray"><i
							class="fa fa-star"></i></span> <span class="review_star color_gray"><i
							class="fa fa-star"></i></span> <span class="review_star color_gray"><i
							class="fa fa-star"></i></span>
					</div>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn_review color_air_green"
					id="btnReviewReg">등록</button>
				<button type="button" class="btn_review color_air_green"
					id="btnReviewUpdate">수정</button>
				<button type="button" class="btn_review color_air_green"
					id="btnReviewDelete">삭제</button>
				<button type="button" class="btn_review color_air_green"
					id="btnReviewClose" data-dismiss="modal">취소</button>
			</div>

		</div>
	</div>
</div>
<!-- end Review Modal -->


