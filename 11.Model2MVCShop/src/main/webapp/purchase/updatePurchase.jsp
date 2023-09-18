<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>

<html lang="ko">

<head>

	<title>구매정보수정</title>
	
	<meta charset="EUC-KR">
	
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
   
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body {
            padding-top : 50px;
        }
    </style>

	<script type="text/javascript">
	
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncUpdatePurchase();
			});
			
			$( "button[name=history]" ).on("click" , function() {
				self.location = "/purchase/listPurchase"
			});
		});
		
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#']").on("click" , function() {
				$("form")[0].reset();
			});
		});	
		
		function fncUpdatePurchase(){
			$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchase").submit();
		}
	
	</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
   		<div class="page-header text-center">
   			<h3 class="text-info">구매정보수정</h3>
   		</div>
   		
   		<form class="form-horizontal">

			<div class="form-group" hidden>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="tranNo" name="tranNo" value="${purchase.purchaseProd.prodNo}">
		    	</div>
		  	</div>

			<div class="form-group">
   				<label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자 아이디</label>
   				<div class="col-sm-4">
		    		<input type="text" class="form-control" id="buyerId" name="buyerId" value="${purchase.buyer.userId}">
				</div>
   			</div>
   			
   			<div class="form-group">
   				<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자 이름</label>
   				<div class="col-sm-4">
		    		<input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName}">
				</div>
   			</div>
   			
   			<div class="form-group">
   				<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자 아이디</label>
   				<div class="col-sm-4">
		    		<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${purchase.receiverPhone}">
				</div>
   			</div>

			<div class="form-group">
   				<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">배송 주소</label>
   				<div class="col-sm-4">
		    		<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${purchase.divyAddr}">
				</div>
   			</div>

			<div class="form-group">
   				<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">배송 요청사항</label>
   				<div class="col-sm-4">
		    		<input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest}">
				</div>
   			</div>

			<div class="form-group">
   				<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송 희망날짜</label>
   				<div class="col-sm-4">
		    		<input type="date" class="form-control" id="divyDate" name="divyDate" value="${purchase.divyDate}">
				</div>
   			</div>

			<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary" name="confirmbt">수정</button>
				<button type="button" class="btn btn-primary" name="history">이전</button>
	  		</div>
		</div>
	</form>
</div>

</body>
</html>