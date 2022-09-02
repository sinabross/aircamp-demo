<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/aboutus.css" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>aircamp</title>
    <link rel="stylesheet" href="/resources/css/aboutus.css">
</head>
<body>
    <div class="wrap_aboutus">
        <section class="aboutus">
            <div class="txt_aboutus_1">캠핑용품이 필요하세요?</div>
                <div class="img_camping_item">
                    <img src="/resources/images/detail/icon_wrench.png">
                    <img src="/resources/images/detail/icon_jumper.png">
                    <img src="/resources/images/detail/icon_fire.png">
                    <img src="/resources/images/detail/icon_coffee.png">
                </div>
                
            <div class="txt_aboutus_1">
            	자주 사용하지 않는 캠핑용품,<br>
            	구입하기가 망설여지시나요?
            </div>
            
            <div class="img_grill">
                <img src="/resources/images/detail/icon_grill.png">
            </div> 
            
            <div class="txt_aboutus_2">
                에어캠프는 캠핑용품을 
                <br><b style="color:red;font-size:55px;">공유</b>, <b style="color:blue;font-size:55px;">대여</b>하는 서비스입니다.
            </div>
            
            <div class="img_tent">
                <img src="/resources/images/detail/img_tent.png">
            </div>    
            
            <div class="txt_aboutus_3">
                캠핑용품, 사지말고<br>
                <b style="color:red;font-size:50px">에어캠프</b>에서 공유하세요!
                
                <a href="/home" class="aboutus_start">시작하기<br>
                	<i class="fas fa-arrow-down"></i>
                </a>
            </div>
        </section>        
        
    </div>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
