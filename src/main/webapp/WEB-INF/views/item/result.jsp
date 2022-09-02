<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/result.css">
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<script>
	$(function(){
		//가격에 콤마 찍기
		var result_price = $(".result_price b").text();
		var resultPrice = numberWithCommas(result_price);                
		$(".result_price b").text(resultPrice);
		
		//가격에 콤마 찍기
		function numberWithCommas(price) {
		    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
	});
</script>

<div class="wrap_result">
        <section id="result">
            <h1>예약이 완료되었습니다.</h1>
            <div class="result_date">
                <div class="tit_result_date">대여일</div>
                <div class="txt_result_date">${reservation.s_sdate}</div>
            </div>
            <div class="result_date">
                <div class="tit_result_date">반납일</div>
                <div class="txt_result_date">${reservation.s_edate}</div>
            </div>
            
            <div>
                <div class="result_price">&#8361;<b>${reservation.s_price}</b></div>
                <div class="result_location">${reservation.s_addr}</div>
            </div>
            
            <div class="wrap_btn_result">
                <button onclick="history.go(-1)" class="btn_result">이전</button>
                <button onclick="location.href='/item/all'" class="btn_result">목록</button>
            </div>
        </section>
    </div>
    
<%@ include file="/WEB-INF/views/common/footer.jsp"%>


