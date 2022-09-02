<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/resources/css/host.css" />

<!-- Host Modal --------------------------------------------------------------->
<div class="modal" id="hostModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h1 class="modal-title">HOST</h1>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
			<c:forEach items="${item.memberList}" var="memberList">
            
            <!-- Host Information -->
            <div id="wrapHostInfo">
                <c:choose>
                	<c:when test="${empty memberList.m_path || empty memberList.m_uuid || empty memberList.m_filename}">
                		<img class="img_host_profile" src="/resources/images/detail/img_member_default.png">
                	</c:when>
                	<c:otherwise>
                		<!-- 이미지를 불러오지 못할 경우 controller에서 기본 이미지 출력 -->
                		<img class="img_host_profile" src="/item/displayMember?fileName=${memberList.m_path}/s_${memberList.m_uuid}_${memberList.m_filename}">
                	</c:otherwise>
                </c:choose>
				<div class="host_name">${memberList.m_name}</div>
				<div class="host_id">(${memberList.m_id})</div>
				
				
				<div id="hostInfo">
				
					<div class="detail_item_info host_phone">
		           		<i class="fa fa-phone"></i>&nbsp;&nbsp; ${memberList.m_phone}
		            </div>
		            <div class="detail_item_info">
		           		<i class="fa fa-envelope"></i>&nbsp;&nbsp; 
		           		<c:choose>
		           			<c:when test="${empty memberList.m_email}">
		           				<span class="detail_no_info">이메일이 없습니다.</span>
		           			</c:when>
		           			<c:otherwise>
				           		${memberList.m_email}
		           			</c:otherwise>
		           		</c:choose>
		           </div>
		           <div class="detail_item_info">
		           		<img class="img_icon_katalk" src="/resources/images/detail/icon_katalk.png">&nbsp;&nbsp; 
		           		<c:choose>
		           			<c:when test="${empty memberList.m_katalk}">
		           				<span class="detail_no_info">카카오톡 아이디가 없습니다.</span>
		           			</c:when>
		           			<c:otherwise>
				           		${memberList.m_katalk}
		           			</c:otherwise>
		           		</c:choose>
		           	</div>
		           	
		           <div id="hostScore" class="detail_title">
		               <b>별점&nbsp;</b>
		               
		               <!-- 별점 평가자 수가 0인 경우 -->
					   <c:if test="${memberList.m_eval eq 0}">
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
						    <i class="far fa-star color_yellow"></i>
					   </c:if>
		
					   <!-- 별점 평가자 수가 0이 아닌 경우 -->
		               <c:if test="${memberList.m_eval ne 0}">
			               <c:set var="score" value="${memberList.m_score/memberList.m_eval}" />
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
						&nbsp;<span>(${memberList.m_eval}명 참여)</span>
	           		</div>
           		
           		</div>
	           	
	        </div>
	        <!-- end Host Information -->
	        
	        <hr class="host_line">
	        
	        <!-- 현재 대여중인 아이템 -->
	        <div id="hostItem">
	        	<h4>${memberList.m_name}님의 대여중인 아이템</h4>
	        	
	        	<c:forEach items="${host}" var="host">
	        	<a href="/item/detail?i_id=${host.i_id}">
					<span class="host_gallery">
	        		<c:forEach items="${host.galleryList}" var="galleryList">
		        		<c:choose>
				           	<c:when test="${empty galleryList.g_path || empty galleryList.g_uuid || empty galleryList.g_filename}">
				           		<img class="img_host_gallery" src="/resources/images/detail/s_no_image.png">
				           	</c:when>
				           	<c:otherwise>
				           		<!-- 이미지를 불러오지 못할 경우 controller에서 기본 이미지 출력 -->
			           			<img class="img_host_gallery" src="/item/displayImage?fileName=${galleryList.g_path}/${galleryList.g_uuid}_${galleryList.g_filename}">
				           	</c:otherwise>
			            </c:choose>
	        		</c:forEach>
	        		</span>
	        	</a>
	        	</c:forEach>
	        	
	        </div>
	        <!-- end 현재 대여중인 아이템 -->
				
			</c:forEach>
      </div>
      <!-- end Modal body -->

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="color_air_green" id="btnHostClose" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>
<!-- end Host Modal -->


