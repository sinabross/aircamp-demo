<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- css detail.css -->
<link rel="stylesheet" href="/resources/css/detail.css" />
<link rel="stylesheet" href="/resources/css/review.css" />
<script src="/resources/js/review.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<c:forEach items="${item}" var="item">
<script>
      $(function(){
    	 var i_sdate = '${item.i_sdate}'; //대여가능시작날짜
  	  	 var i_edate = '${item.i_edate}'; //대여가능종료날짜

  	  	 //date형식이 'yy-mm-dd'일 경우
  	  	 var sDate = new Date(i_sdate);
 	  	 var eDate = new Date(i_edate);
 	  	   	 	 
  	 	 //date형식이 'yy/mm/dd'일 경우
  	  	 //var s = i_sdate.split("/");
  	  	 //var e = i_edate.split("/");
  	  	 //var sDate = new Date(s[0], parseInt(s[1])-1, s[2]);
         //var eDate = new Date(e[0], parseInt(e[1])-1, e[2]);
         
         var currentDate = new Date().toISOString().slice(0, 10);
         
         if(i_edate<currentDate){
        	 $("#detailDateStart").datepicker("destroy");
        	 $("#detailDateStart").hide();
        	 $("#detailDateEnd").datepicker("destroy");
        	 $("#detailDateEnd").hide();
        	 
        	 $(".label_sdate").html("대여가 종료되었습니다.");
        	 $(".label_sdate").css("margin-bottom", "20px");
        	 $(".label_edate").hide();
        	 
         }
         
  		  /* datepicker */
          $("#detailDateStart").datepicker({
          	  dateFormat:'yy-mm-dd',          	  
              showMonthAfterYear:true,
              changeYear: true,
              changeMonth: true,
              monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
              monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
              dayNamesMin: ['일','월','화','수','목','금','토'],
              dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
              minDate: sDate,
              maxDate: eDate,
          	  beforeShowDay: disableAllTheseDays
          });
  		  
          $("#detailDateEnd").datepicker({
        	  dateFormat:'yy-mm-dd',
              showMonthAfterYear:true,
              changeYear: true,
              changeMonth: true,
              monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
              monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
              dayNamesMin: ['일','월','화','수','목','금','토'],
              dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
              minDate: sDate,
              maxDate: eDate,
          	  beforeShowDay: disableAllTheseDays
          });
         
          
          /* 이미 대여된 날짜 체크 */
          var listDate = new Array();
          
          var a='<c:forEach items="${share}" var="share">';
          
          var rentedDateStart = "${share.s_sdate}";
          var rentedDateEnd = "${share.s_edate}";
          
          //date형식이 'yy/mm/dd'일 경우
          //var d1 = rentedDateStart.split("/");
          //var d2 = rentedDateEnd.split("/");
          //var dateFormatStart = new Date(d1[0], parseInt(d1[1])-1, parseInt(d1[2])+1);
          //var dateFormatEnd   = new Date(d2[0], parseInt(d2[1])-1, parseInt(d2[2])+1);
          //var dateFrom = dateFormatStart.toISOString().slice(0, 10);
          //var dateTo = dateFormatEnd.toISOString().slice(0, 10);
          
          
          //이미 대여된 목록의 시작일과 종료일 사이의 날짜 구하기
          getDateRange(rentedDateStart, rentedDateEnd, listDate);
          
          var b='</c:forEach>';  

          
           //달력에서 이미 대여된 날짜 막기
	       	function disableAllTheseDays(date) {
	       	    var month = date.getMonth()+1;
	       	    var date = date.getDate();
	       	    var year = new Date().getFullYear();
	       	    
	       	    if(month<10){
	 	      		month = '0' + month.toString();
	       	    }
	       	    if(date<10){
	       	    	date = '0' + date.toString();
	       	    }
	       	    
	       	    for (i=0;i<listDate.length;i++) {
	       	        if($.inArray(year + '-' + month + '-' + date, listDate) != -1) {
	       	            return [false];
	       	        }
	       	    }
	       	    return [true];
	       	}
          
                    
          //시작일과 종료일 사이의 날짜 구하기        
          function getDateRange(dateStart, dateEnd, listDate){
          	   var dateFormatStart = new Date(dateStart);
               var dateFormatEnd = new Date(dateEnd);
          	 
    	        if (dateStart == dateEnd){
    	            listDate.push(dateStart);
    	        }else{
    	            while(dateFormatStart <= dateFormatEnd){
    	                dateStart = dateFormatStart.toISOString().slice(0, 10);
    	                listDate.push(dateStart);
    	                dateFormatStart.setDate(dateFormatStart.getDate() + 1);
    	                
    	                if(dateFormatStart>dateFormatEnd){
    	                	break;
    	                }
    	            }
    	        }
    	        return listDate;
      	  }
           
                      
          /* 대여일, 반납일 체크. date형식이 일치할 때만 가능 */
          var startDate; //대여일
   	      var endDate;   //반납일
          
          //대여일 체크
          $("#detailDateStart").on("propertychange change keyup paste input", function() {	        
          	startDate = $(this).val();
          	endDate = $("#detailDateEnd").val();
          	
          	if(startDate!=null && startDate!="" && endDate!=null && endDate!=""){
          		if(startDate < i_sdate || startDate > i_edate || startDate > endDate){
	  	        	alert("대여일이 반납일보다 뒤에 있습니다.");
	  	        	$(this).val("");
	  	        	startDate=null;
	  	        	return;
	  	        }
          		
				var listDateChk = new Array();
  	         	
  				//대여일과 반납일 사이의 날짜 구하기        	
  		      	getDateRange(startDate, endDate, listDateChk);
  				
  		      	//대여일과 반납일 사이의 날짜가 대여리스트의 날짜와 중복되는지 체크
  	     		for(var i=0;i<listDate.length;i++){
  		      		if(listDateChk.includes(listDate[i])){
  		      			alert("대여일과 반납일 사이에 대여가 불가능한 날짜가 있습니다.");
  		      			$(this).val("");
  		  	        	startDate=null;
  		      			return;
  		      		}
  	     		}
          		
          	}
          });
          
          //반납일 체크
          $("#detailDateEnd").on("propertychange change keyup paste input", function() {
        	  startDate = $("#detailDateStart").val();
              endDate = $(this).val();
              
              if(startDate!=null && startDate!="" && endDate!=null && endDate!=""){
            	  if(endDate < i_sdate || endDate > i_edate || startDate > endDate){
        	        	alert("반납일이 대여일보다 앞에 있습니다.");
        	        	$(this).val("");
        	        	endDate = null;
        	        	return;
        	        }
            	  
            	    var listDateChk = new Array();
    	         	
    				//대여일과 반납일 사이의 날짜 구하기        	
    		      	getDateRange(startDate, endDate, listDateChk);
    		      	
    		      	//대여일과 반납일 사이의 날짜가 대여리스트의 날짜와 중복되는지 체크
    	   			for(var i=0;i<listDate.length;i++){
    		      		if(listDateChk.includes(listDate[i])){
    		      			alert("대여일과 반납일 사이에 대여가 불가능한 날짜가 있습니다.");
    		      			$(this).val("");
    		  	        	endDate = null;
    		      			return;
    		      		}
    	   			}
              }
          });
          /* 대여일, 반납일 체크 종료 */
                  
        
        //예약하기
        $("#btnReservation").on("click", function(e){
        	e.preventDefault();
        	
        	//로그인 여부 체크
        	console.log($("#member").val());
        	
        	if($("#member").val()==null){
        		console.log("noMember");
        	}else{
        		$(this).removeAttr("data-toggle");
        		$(this).removeAttr("data-target");
        		console.log($("#member").val())
        		
	            //대여일, 반납일 체크
	         	startDate = $("#detailDateStart").val();
	         	endDate = $("#detailDateEnd").val();
	         	
	         	var listDateChk = new Array();
	            var dateFlag = true;
	         	
	            if(startDate==null || startDate=="" || endDate==null || endDate==""){
	            	dateFlag = false;
	            	alert("날짜를 입력해주세요!");
	            	return;
	            	
	            }else if(startDate!=null && startDate!="" && endDate!=null && endDate!=""){
	            	//대여일과 반납일 사이의 날짜 구하기        	
	            	getDateRange(startDate, endDate, listDateChk);
	            	
	            	//대여일과 반납일 사이의 날짜가 대여리스트의 날짜와 중복되는지 체크
	           		for(var i=0;i<listDate.length;i++){
	            		if(listDateChk.includes(listDate[i])){
	            			dateFlag = false;
	            			alert("대여일과 반납일 사이에 대여가 불가능한 날짜가 있습니다.");
	            			return;
	            		}
	           		}
	            	
	            	if(dateFlag==true){
	            		if(confirm("예약하시겠습니까?")){
		    	        	$("#reservationForm").submit();
	            		}
	            	}else{
	            		alert("대여가 불가능합니다.");
	            	}
	            }
	            
	            
        	}
        });//예약하기 끝
        
        
        //예약에 실패했을 경우 알림창 띄우기
        var fail = '${fail}';
        
        if(fail!=null && fail!=""){
	        alert(fail);
        }
          
        //가격에 콤마 찍기
        var price = $("#detailPrice b").text();
        var detailPrice = numberWithCommas(price);                
        $("#detailPrice b").text(detailPrice);
        
        //가격에 콤마 찍기
        function numberWithCommas(price) {
            return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        
     
      });
      
</script>

<div class="wrap_detail">
	<h1>${item.i_title}</h1>
	
	<section class="fotorama" data-width="100%" data-nav="thumbs" data-loop="true" data-autoplay="3000">
		<c:forEach items="${item.galleryList}" var="galleryList">
           <c:choose>
	           	<c:when test="${empty galleryList.g_path || empty galleryList.g_uuid || empty galleryList.g_filename}">
	           		<img src="/resources/images/detail/img_no_image.png">
	           	</c:when>
	           	<c:otherwise>
	           		<!-- 이미지를 불러오지 못할 경우 controller에서 기본 이미지 출력 -->
	           		<img src="/item/displayImage?fileName=${galleryList.g_path}/${galleryList.g_uuid}_${galleryList.g_filename}">
	           	</c:otherwise>
           </c:choose>
		</c:forEach>
	</section>
	
	<section id="detailReservation">
		  <form action="/item/reservation" method="post" id="reservationForm">
			  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			  <input type="hidden" name="i_id" value="${item.i_id}">
			  
			  <!-- id는 로그인한 사용자의 id. 수정해야함 -->
			  <!-- <input type="hidden" name="m_id" value="abcid"> -->
			  
			  <sec:authorize access="isAnonymous()">
					<input type="hidden" id="noMember" name="m_id" value="no_member" />
			  </sec:authorize>
			  <sec:authorize access="isAuthenticated()">
					<input type="hidden" id="member" name="m_id"
						value=<sec:authentication property="principal.member.m_id"/>>
			  </sec:authorize>
			   
			  <input type="hidden" name="s_price" value="${item.i_price}">
			  <input type="hidden" name="s_addr" value="${item.i_addr}">
			  
	          <div id="detailPrice">&#8361;<b>${item.i_price}</b></div>
	
	          <div id="detailDate">               
	              <label>대여가능날짜</label>
	              <div id="detailRentDate">${item.i_sdate} - ${item.i_edate}</div>
	              <label class="label_sdate">대여일</label>
	              <input type="text" id="detailDateStart" name="s_sdate" placeholder=" 대여일" autocomplete="off">
	              <label class="label_edate">반납일</label>
	              <input type="text" id="detailDateEnd" name="s_edate" placeholder=" 반납일" autocomplete="off">
	              <div id="detailItemLocation">
	                  <img class="img_icon_location" src="/resources/images/detail/icon_location.png"><span>&nbsp; ${item.i_addr}</span>
	              </div>               
	          </div>
	           
	          <div id="btnReserv">
	              <button type="submit" id="btnReservation" class="btn_detail color_air_green" data-toggle="modal"
						data-target="#modalAir" onclick="haveToLogin()">대여하기</button>
	          </div>
      	  </form>
       </section>
       
       <section id="detailItemIntro">
           <div class="detail_title">INTRO</div>
           <div class="detail_item_intro">
               ${item.i_info}
           </div>
           
           <div class="detail_title">
               <b>등록일</b>
               <span>&nbsp; <fmt:formatDate pattern="yyyy-MM-dd" value="${item.i_regdate}"/></span>
           </div>
           
           <div>
               <a id="detailReport" href="/contactus"><i class="fa fa-bullhorn"></i>&nbsp;신고하기&nbsp;</a>
           </div> 
       </section>

       <hr class="line_detail">
       
       <section id="detailHostInfo">
           <div class="detail_title">HOST</div>
       	   <div class="detail_host_info" data-toggle="modal" data-target="#hostModal">
           <c:forEach items="${item.memberList}" var="memberList">
                <c:choose>
                	<c:when test="${empty memberList.m_path || empty memberList.m_uuid || empty memberList.m_filename}">
                		<img class="img_host_photo" src="/resources/images/detail/img_member_default.png">
                	</c:when>
                	<c:otherwise>
                		<!-- 이미지를 불러오지 못할 경우 controller에서 기본 이미지 출력 -->
                		<img class="img_host_photo" src="/item/displayMember?fileName=${memberList.m_path}/s_${memberList.m_uuid}_${memberList.m_filename}">
                	</c:otherwise>
                </c:choose>
				<span class="detail_host_name">${memberList.m_name}</span>
			</c:forEach>    
			</div>
       </section>
       
       <%@ include file="/WEB-INF/views/item/host.jsp"%>
       
       <section id="detailItemInfo">
           <div class="detail_item_info">
           		<i class="fa fa-phone"></i>&nbsp;&nbsp; ${item.i_phone}
           </div>
           <div class="detail_item_info">
           		<i class="fa fa-envelope"></i>&nbsp;&nbsp; 
           		<c:choose>
           			<c:when test="${empty item.i_email}">
           				<span class="detail_no_info">이메일이 없습니다.</span>
           			</c:when>
           			<c:otherwise>
		           		${item.i_email}
           			</c:otherwise>
           		</c:choose>
           </div>
           <div class="detail_item_info">
           		<img class="img_icon_katalk" src="/resources/images/detail/icon_katalk.png">&nbsp;&nbsp; 
           		<c:choose>
           			<c:when test="${empty item.i_katalk}">
           				<span class="detail_no_info">카카오톡 아이디가 없습니다.</span>
           			</c:when>
           			<c:otherwise>
		           		${item.i_katalk}
           			</c:otherwise>
           		</c:choose>
           	</div>
       </section>
       
       <hr class="line_detail">
             
       
       <section id="detailReview">
           <div class="detail_title">REVIEW</div>
           <div class="detail_title" id="detailStarScore">              
               <b>별점&nbsp;</b>
               
               <!-- 별점 평가자 수가 0인 경우 -->
			   <c:if test="${item.i_eval eq 0}">
				    <i class="far fa-star color_yellow"></i>
				    <i class="far fa-star color_yellow"></i>
				    <i class="far fa-star color_yellow"></i>
				    <i class="far fa-star color_yellow"></i>
				    <i class="far fa-star color_yellow"></i>
			   </c:if>

			   <!-- 별점 평가자 수가 0이 아닌 경우 -->
               <c:if test="${item.i_eval ne 0}">
	               <c:set var="score" value="${item.i_score/item.i_eval}" />
				   <c:choose>
		               <c:when test="${empty score}">
		               		<i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
		               </c:when>
		               <c:when test="${score eq 0}">
					        <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
					    </c:when>
					    <c:when test="${score gt 4.5}">
					        <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
					    </c:when>
					    <c:when test="${score gt 4.0}">
					        <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fas fa-star-half-alt color_yellow"></i>
					    </c:when>	
					    <c:when test="${score gt 3.5}">
					        <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
					    </c:when>
					    <c:when test="${score gt 3.0}">
					        <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fas fa-star-half-alt color_yellow"></i>
						    <i class="far fa-star color_yellow"></i> 
					    </c:when>
					    <c:when test="${score gt 2.5}">
					        <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i> 
					    </c:when>
					    <c:when test="${score gt 2.0}">
					        <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="fas fa-star-half-alt color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i> 
					    </c:when>
					    <c:when test="${score gt 1.5}">
					        <i class="fa fa-star color_yellow"></i>
						    <i class="fa fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i> 
					    </c:when>
					    <c:when test="${score gt 1.0}">
					        <i class="fa fa-star color_yellow"></i>
						    <i class="fas fa-star-half-alt color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
					    </c:when>
					    <c:when test="${score gt 0.5}">
					        <i class="fa fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
					    </c:when>
					    <c:when test="${score le 0.5}">
					        <i class="fas fa-star-half-alt color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
					    </c:when>					    
					    <c:otherwise>
					        <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i> 
					    </c:otherwise>
					</c:choose>
				</c:if>
				&nbsp;<span>(${item.i_eval}명 참여)</span>
           </div>
           
           <ul id="detailReviewList">
              <c:forEach items="${opinion}" var="opinion">           		
              <li data-sid="${opinion.s_id}">
                   <div class="wrap_review_photo">
                       <c:choose>
                       		<c:when test="${empty opinion.m_path || empty opinion.m_uuid || empty opinion.m_filename}">
	                       		<img class="img_member_photo" src="/resources/images/detail/img_member_default.png">
                       		</c:when>
                       		<c:otherwise>
                       			<span class="img_member_photo">
                       				<!-- 이미지를 불러오지 못할 경우 controller에서 기본 이미지 출력 -->
	                       			<img class="img_member_profile" src="/item/displayMember?fileName=${opinion.m_path}/s_${opinion.m_uuid}_${opinion.m_filename}">
	                       		</span>
                       		</c:otherwise>
                       </c:choose>
                       <span class="review_member_name">${opinion.m_id}</span>
                   </div>
                   
                   <div class="wrap_review_content">
                       <div class="review_content">${opinion.s_opi}</div>
                       <div class="review_regdate">
                       		<span><fmt:formatDate pattern="yyyy-MM-dd" value="${opinion.s_opidate}"/></span>
                       </div>
                   </div>
                   
                   <div class="wrap_review_btn">
                   		<button class="btn_review_update"><i class="fas fa-edit"></i></button>
                   		<button class="btn_review_delete"><i class="fas fa-trash-alt"></i></button>
                   </div>
               </li>
               
               <hr class="line_detail">
               </c:forEach>
           </ul>
           
           <button id="btnReviewModal" class="btn_detail color_air_green" data-toggle="modal"
						data-target="#modalAir" onclick="haveToLogin();">후기 등록하기</button>
           
           <%@ include file="/WEB-INF/views/item/review.jsp"%>
           
           <div id="reviewPaging"></div>
           
       </section>
       
       <section id="btnDetailBottom" class="container-fluid">
           <div class="row">
           	  <sec:authorize access="isAnonymous()">
				   <input type="hidden" id="noMember" name="m_id" value="no_member" />
				   <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
	                   <button id="btnItemReg" class="btn_detail color_air_green" data-toggle="modal"
							data-target="#modalAir" onclick="haveToLogin()">아이템 등록</button>
	               </div>
	               <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
	                   <button id="btnItemUpdate" class="btn_detail color_air_green" data-toggle="modal"
							data-target="#modalAir" onclick="haveToLogin()">아이템 수정</button>
	               </div>
	
	               <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
	                   <button id="btnItemDelete" class="btn_detail color_air_green" data-toggle="modal"
							data-target="#modalAir" onclick="haveToLogin()">아이템 삭제</button>
	               </div>
					
			  </sec:authorize>
			  <sec:authorize access="isAuthenticated()">
					<input type="hidden" id="member" name="m_id" value=<sec:authentication property="principal.member.m_id"/>>
					
					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
	                   <button id="btnItemReg" class="btn_detail color_air_green" onclick="location.href='/item/add'">아이템 등록</button>
	               </div>
	               <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
	                   <button id="btnItemUpdate" class="btn_detail color_air_green" onclick="itemUpdate()">아이템 수정</button>
	               </div>
	
	               <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
	                   <button id="btnItemDelete" class="btn_detail color_air_green" onclick="itemDelete()">아이템 삭제</button>
	               </div>
					
			  </sec:authorize>
			  
           		   <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
	                   <button id="btnItemList" class="btn_detail color_air_green" onclick="history.go(-1)">이전 페이지</button>
	               </div>
               
           </div>
       </section>
       
       <script>       		
			var itemUserId = '${item.m_id}';
			var loginUserId = $("#member").val(); //로그인한 사용자 아이디
			
			function itemUpdate(){
				//로그인한 사용자와 아이템 등록한 사용자가 일치하는지 체크
				if(loginUserId==itemUserId){
					if(confirm("수정하시겠습니까?")){
						location.href='/item/modify?i_id=${item.i_id}&m_id=' + itemUserId;
					}
				}else{
					alert("수정 권한이 없습니다.");
					return;
				}
			}
			
			function itemDelete(){
				//로그인한 사용자와 아이템 등록한 사용자가 일치하는지 체크
				if(loginUserId==itemUserId){
					if(confirm("정말 삭제하시겠습니까?")){
						location.href='/item/itemRemove?i_id=${item.i_id}&m_id=' + itemUserId;
					}
				}else{
					alert("삭제 권한이 없습니다.");
				}
			}
	  </script>

</div>
</c:forEach>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
