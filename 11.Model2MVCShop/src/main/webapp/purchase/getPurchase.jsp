<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>

<html lang="ko">

<head>

	<meta charset="utf-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	<title>상품 조회</title>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
    </style>
     
	<title>상품 조회</title>
	
	<script type="text/javascript">
		
		//============= 회원정보수정 Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button[name=confirmbt]" ).on("click" , function() {
					self.location = "/purchase/updatePurchase?prodNo=${purchase.purchaseProd.prodNo}"
			});
			 
			 $( "button[name=history]" ).on("click" , function() {
					self.location = "/purchase/listPurchase?userId=${purchase.buyer.userId}"
			});
		});
		
	</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<div class="container">
   		<div class="page-header">
   			<h3 class="text-info">구매상세조회</h3>
   		</div>
   		<input type="hidden" name="tranNo" value="${purchase.tranNo}" />
   		<div class="row">
   			<div class="col-md-2"><strong>물품번호</strong></div>
   			<div class="col-md-4">${purchase.purchaseProd.prodNo}</div>
   		</div>
   		<hr/>
   		<div class="row">
   			<div class="col-md-2"><strong>구매자아이디</strong></div>
   			<div class="col-md-4">${purchase.buyer.userId}</div>
   		</div>
   		<hr/>
   		<div class="row">
   			<div class="col-md-2"><strong>구매방법</strong></div>
   			<div class="col-md-4">${(purchase.paymentOption==1) ? "현금구매" : "카드구매"}</div>
   		</div>
   		<hr/>
   		<div class="row">
   			<div class="col-md-2"><strong>구매자이름</strong></div>
   			<div class="col-md-4">${purchase.receiverName}</div>
   		</div>
   		<hr/>
   		<div class="row">
   			<div class="col-md-2"><strong>구매자연락처</strong></div>
   			<div class="col-md-4">${purchase.receiverPhone}</div>
   		</div>
   		<hr/>
   		<div class="row">
   			<div class="col-md-2"><strong>구매자주소</strong></div>
   			<div class="col-md-4">${purchase.divyAddr}</div>
   		</div>
   		<hr/>
   		<div class="row">
   			<div class="col-md-2"><strong>구매요청사항</strong></div>
   			<div class="col-md-4">${purchase.divyRequest}</div>
   		</div>
   		<hr/>
   		<div class="row">
   			<div class="col-md-2"><strong>배송희망일자</strong></div>
   			<div class="col-md-4">${purchase.divyDate}</div>
   		</div>
   		<hr/>
   		<div class="row">
	  		<div class="col-md-12 text-center ">
				<button type="button" class="btn btn-primary" name="confirmbt">수정</button>
				<button type="button" class="btn btn-primary" name="history">이전</button>
	  		</div>
		</div>
   	</div>

</body>
</html>