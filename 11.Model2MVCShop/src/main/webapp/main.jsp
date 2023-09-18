<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="utf-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	 	
	
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  아래의 내용은 http://getbootstrap.com/getting-started/  참조 -->	
   	<div class="container ">
   	<div class="col-md-3">
			<div class="panel panel-primary">
				<div class="panel-heading">
						마이페이지
	    			</div>
					<ul class="list-group">
						<a href="/user/getUser?userId=${sessionScope.user.userId}" class="list-group-item"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> 개인정보조회</a>
						<c:if test="${sessionScope.user.role == 'user'}">
						<a href="/purchase/listPurchase?userId=${sessionScope.user.userId}" class="list-group-item"><span class="glyphicon glyphicon-gift" aria-hidden="true"></span> 구매목록조회</a>
						<a href="/basket/listBasket" class="list-group-item"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> 장바구니조회</a>
						</c:if>
						<c:if test="${sessionScope.user.role == 'admin'}">
							<a href="/user/listUser" class="list-group-item"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> 회원정보조회</a>
						</c:if>
					</ul>
				</div>
				
				<div class="panel panel-primary">
					<div class="panel-heading">
						상품
	    			</div>
					<ul class="list-group">
						<c:if test="${sessionScope.user.role == 'user'}">
						 <a href="/product/listProduct?menu=search" class="list-group-item"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 전체상품검색</a>
						</c:if>
						<c:if test="${sessionScope.user.role == 'admin'}">
						 <a href="/product/addProduct?menu=manage" class="list-group-item"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 판매상품등록</a>
		                 <a href="/product/listProduct?menu=manage" class="list-group-item"><span class="glyphicon glyphicon-check" aria-hidden="true"></span> 판매상품관리</a>
		                </c:if>
					</ul>
				</div>
				
	</div>
      <!-- Main jumbotron for a primary marketing message or call to action -->
      <div class="col-md-9">
      <div class="jumbotron">
        <h1>Model2MVCShop </h1>
      </div>
      </div>
    </div>

</body>

</html>