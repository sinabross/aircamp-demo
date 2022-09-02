<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/item.css" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<h1>예약이 완료되었습니다.</h1>
	
	<div>대여일: ${reservation.s_sdate}</div>
	<div>반납일: ${reservation.s_edate}</div>
	
	<div>가격: ${reservation.s_price}</div>
	<div>위치: ${reservation.s_addr}</div>

	
	<button>이전</button>
	<button>목록</button>
	
<%@ include file="/WEB-INF/views/common/footer.jsp"%>