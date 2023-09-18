<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-default navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
			<button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
				<span class="sr-only">Toggle navigation</span>
				<span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
			</button>
		</div>
		
		<!--  dropdown hover Start -->
		<div class="collapse navbar-collapse" id="target" data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
			<!-- Tool Bar 를 다양하게 사용하면.... -->
			<ul class="nav navbar-nav">
	             
				<!--  회원관리 DrowDown -->
				<c:if test="${ ! empty user }">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span>마이페이지</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">		                     
							<li><a href="#">개인정보조회</a></li>
							<c:if test="${sessionScope.user.role == 'admin'}">
								<li><a href="/user/listUser">회원정보조회</a></li>
							</c:if>
							<c:if test="${sessionScope.user.role == 'user'}">
								<li><a href="#">구매이력조회</a></li>
								<li><a href="#">장바구니조회</a></li>
							</c:if>
						</ul>
					</li>
				</c:if>
	              
				<!-- 판매상품관리 DrowDown  -->
				<li class="dropdown ">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span>판매상품</span>
						<span class="caret"></span>
		            </a>
		            <ul class="dropdown-menu">
						<c:if test="${sessionScope.user.role == 'admin'}">
							<li><a href="/product/addProduct?menu=manage">판매상품등록</a></li>
		                    <li><a href="/product/listProduct?menu=manage">판매상품관리</a></li>
		                    
		                </c:if>
		                <c:if test="${sessionScope.user.role != 'admin'}">
		                    <li><a href="/product/listProduct?menu=search">상 품 검 색</a></li>
		            	</c:if>
		            </ul>
				</li>

			</ul>
			
				<c:if test="${ ! empty user }">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#">로그아웃</a></li>
					</ul>
				</c:if>
	            <c:if test="${ empty user }">
					<div class="collapse navbar-collapse" id="target">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="/user/addUser">회원가입</a></li>
							<li><a href="/user/login">로 그 인</a></li>
						</ul>
					</div>
				</c:if>
		</div>
		<!-- dropdown hover END -->	
		
		<!-- toolBar Button End //////////////////////// -->

	</div>
</div>
<!-- ToolBar End /////////////////////////////////////-->
 	
<script type="text/javascript">

//============= logout Event  처리 =============	
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
 	$("a:contains('로그아웃')").on("click" , function() {
		$(self.location).attr("href","/user/logout");
		//self.location = "/user/logout"
	}); 
});

//============= 회원정보조회 Event  처리 =============	
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
 	$("a:contains('회원정보조회')").on("click" , function() {
		//$(self.location).attr("href","/user/logout");
		self.location = "/user/listUser"
	}); 
});

//=============  개인정보조회회 Event  처리 =============	
$( "a:contains('개인정보조회')" ).on("click" , function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
});
$( "a:contains('구매이력조회')" ).on("click" , function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$(self.location).attr("href","/purchase/listPurchase?userId=${sessionScope.user.userId}");
});
$( "a:contains('장바구니조회')" ).on("click" , function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$(self.location).attr("href","/basket/listBasket");
});

</script>  