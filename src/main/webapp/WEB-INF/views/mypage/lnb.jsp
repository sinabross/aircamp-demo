<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/member.css" />

<link rel="stylesheet" href="/resources/css/mypage.css" />

<h1 class="title_mypage ">
	MY PAGE<i class='fas fa-caret-down icon_mypagemobile_lnb on'></i><i
		class='fas fa-caret-up icon_mypagemobile_lnb'></i>
</h1>

<%-- <form id="formMyPage" method="POST" action="#">
	<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
	<input type="hidden" name="myid" value=<sec:authentication property="principal.member.m_id" />>
	<input type="hidden" id="pageNume" name="pageNum" value=1>
	<input type="hidden" id="amount" name="amount" value=10>
</form>
 --%>

<nav id="lnbMypage" class="col-sm-3 aside">
	<h5>
		"
		<sec:authentication property="principal.member.m_name" />
		"님 환영합니다!
	</h5>
	<h3>나의 공유 정보</h3>
	<hr>
	<ul class="nav nav-pills nav-stacked">
		<li class="menu_mypage_reservation"><a
			href="/mypage/my_reservation?m_id=<sec:authentication property="principal.member.m_id" />&pageNum=1&amount=10">나의
				예약정보</a></li>
		<li class="menu_mypage_post"><a
			href="/mypage/my_share?m_id=<sec:authentication property="principal.member.m_id" />&pageNum=1&amount=10">나의
				등록정보</a></li>
	</ul>

	<h3>내가 작성한 글</h3>
	<hr>
	<ul class="nav nav-pills nav-stacked">
		<li class="menu_mypage_community"><a
			href="/mypage/my_community?m_id=<sec:authentication property="principal.member.m_id" />&pageNum=1&amount=10">나의
				게시글</a></li>
		<li class="menu_mypage_contactus"><a
			href="/mypage/my_contactus?m_id=<sec:authentication property="principal.member.m_id" />&pageNum=1&amount=10">나의
				문의글</a></li>
	</ul>


	<h3>회원정보</h3>
	<hr>
	<ul class="nav nav-pills nav-stacked">
		<li class="menu_mypage_modify"><a
			href="/mypage/my_modify_check?m_id=<sec:authentication property="principal.member.m_id" />">회원정보수정</a></li>
		<li class="menu_mypage_delete"><a
			href="/mypage/my_delete?m_id=<sec:authentication property="principal.member.m_id" />">회원탈퇴</a></li>
	</ul>
</nav>


<nav id="lnbMypageMobile" class="col-sm-3 aside">
	<h3>나의 공유 정보</h3>
	<hr>
	<ul class="nav nav-pills nav-stacked">
		<li class="menu_mypage_reservation"><a
			href="/mypage/my_reservation?m_id=<sec:authentication property="principal.member.m_id" />&pageNum=1&amount=10">나의
				예약정보</a></li>
		<li class="menu_mypage_post"><a
			href="/mypage/my_share?m_id=<sec:authentication property="principal.member.m_id" />&pageNum=1&amount=10">나의
				등록정보</a></li>
	</ul>

	<h3>내가 작성한 글</h3>
	<hr>
	<ul class="nav nav-pills nav-stacked">
		<li class="menu_mypage_community"><a
			href="/mypage/my_community?m_id=<sec:authentication property="principal.member.m_id" />&pageNum=1&amount=10">나의
				게시글</a></li>
		<li class="menu_mypage_contactus"><a
			href="/mypage/my_contactus?m_id=<sec:authentication property="principal.member.m_id" />&pageNum=1&amount=10">나의
				문의글</a></li>
	</ul>


	<h3>회원정보</h3>
	<hr>
	<ul class="nav nav-pills nav-stacked">
		<li class="menu_mypage_modify"><a
			href="/mypage/my_modify_check?m_id=<sec:authentication property="principal.member.m_id" />">회원정보수정</a></li>
		<li class="menu_mypage_delete"><a
			href="/mypage/my_delete?m_id=<sec:authentication property="principal.member.m_id" />">회원탈퇴</a></li>
	</ul>
</nav>






