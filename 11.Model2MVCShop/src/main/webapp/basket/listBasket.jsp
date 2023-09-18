<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head lang="ko">

	<title>장바구니 목록</title>
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
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
        

  		p.hidden {
    		visibility: hidden;
  		}
        
    </style>
    
    
	<script type="text/javascript">
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 $( "button[name=buybasket]" ).on("click" , function() {
				self.location = "/basket/buyBasket"
		});
		
		 $( "button[name=deletebasket]" ).on("click" , function() {
				self.location = "/basket/deleteBasket"
		});
	});
		  
		function fncGetBasketList(currentPage){
			$("#currentPage").val(currentPage);
			$("form").attr("method","post").attr("action","/basket/listBasket").submit();
		}
		
		 $(function() {
			 
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetBasketList(1);
			});
		 });
		 
		 $(function() {
				
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "td:nth-child(3)" ).on("click" , function() {
					if(${menu=='manage'}) {
						self.location ="/product/updateProduct?prodNo="+$("input:hidden[name="+$(this).html()+"]").val()+"&menu=${menu}"
					}else {
						self.location ="/product/getProduct?prodNo="+$("input:hidden[name="+$(this).html()+"]").val()+"&menu=search"
					}
				
			});	
		 });
	
	</script>
</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<div class="container">
   		<div class="page-header text-info">
   			<h3>장바구니 목록</h3>
   		</div>
   		
   		<div class="row">
   			<div class="col-md-6 text-left">
   				<p class="text-primary">
   					전체  ${resultPage.totalCount } 건수
   				</p>
   			</div>
   		</div>
   	
   		<table class="table table-hover table-striped">
   			<thead>
	   			<tr>
	   				<th align="center">No</th>
	   				<th align="left" style="width: 200px;"></th>
	   				<th align="left">상품명</th>
					<th align="left">가격</th>
					<th align="left">상세정보</th>
					<th class="hidden"/>
				</tr>
			</thead>
		
			<tbody>
				<c:set var="i" value="0"/>
				<c:forEach var="basket" items="${list}">
					<c:set var="i" value="${i+1}"/>
					<tr>
						<td align="center"><input type="checkbox" name="${basket.preProduct.prodName}" value="${basket.preProduct.prodNo}"></td>
						<td align="left" style="width: 100px"><img src="/images/uploadFiles/${basket.preProduct.fileName}" style="height: 100px;display: block; margin: 0 auto;"></td>
		   				<td align="left">${basket.preProduct.prodName}</td>
						<td align="left">${basket.preProduct.price}</td>
						<td align="left">${basket.preProduct.prodDetail}</td>
						<!-- input type="hidden" name="${basket.preProduct.prodName}" value="${basket.preProduct.prodNo}" -->
					</tr>
				</c:forEach>
			</tbody>
   		</table>
   		<div class="row">
   			<div class="col-md-12 text-center ">
				<button type="button" class="btn btn-primary" name="buybasket">전체구매</button>
				<button type="button" class="btn btn-primary" name="deletebasket">전체삭제</button>
	  		</div>
   		
   			
   			</div>
   		</div>
	
	<!-- PageNavigation Start... -->
	<c:set var="what" value="Basket" scope="request"/>
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
   	

</body>
</html>
