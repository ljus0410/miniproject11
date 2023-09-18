<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head lang="ko">

	<title>상품 목록</title>
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
  		.table td {
    		vertical-align: bottom; /* 이미지와 텍스트를 수직 가운데로 정렬 */
    		padding: 10px;
  		}
        
    </style>
    
    
	<script type="text/javascript">
	
		
		  $( function() {
		    var availableTags = [];
		    $.ajax( 
					{
						url : "/product/json/listProduct/",
						method : "POST" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							$.each(JSONData, function(index, item){
								availableTags[index] = JSONData[index].prodName
							})
						}
				});
		    $( "#searchKeyword" ).autocomplete({
		      source: availableTags
		    });
		  } );
		  
		function fncGetProductList(currentPage){
			$("#currentPage").val(currentPage);
			$("form").attr("method","post").attr("action","/product/listProduct?menu=${menu}").submit();
		}
		
		 $(function() {
			 
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetProductList(1);
			});
		 });
		 
		 $(function() {
				
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "td:nth-child(3)" ).on("click" , function() {
					if(${menu=='search'}) {
						self.location ="/product/getProduct?prodNo="+$("input:hidden[name="+$(this).html()+"]").val()+"&menu=${menu}"
					}else {
						self.location ="/product/updateProduct?prodNo="+$("input:hidden[name="+$(this).html()+"]").val()+"&menu=${menu}"
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
   			<h3>상품목록조회</h3>
   		</div>
   		
   		<div class="row">
   			<div class="col-md-6 text-left">
   				<p class="text-primary">
   					전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
   				</p>
   			</div>
   		
   			<div class="col-md-6 text-right">
	   			<form class="form-inline" name="detailForm">
	   				<div class="form-group">
	   					<select class="form-control" name="searchCondition">
	   						<option value="0" ${ ! empty search.searchCondition && search.searchCondition == 0 ? "selected" : "" }>상품명</option>
							<option value="1" ${ ! empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>높은가격순</option>
							<option value="2" ${ ! empty search.searchCondition && search.searchCondition == 2 ? "selected" : "" }>낮은가격순</option>
							<option value="3" ${ ! empty search.searchCondition && search.searchCondition == 3 ? "selected" : "" }>판매중</option>
						</select>
	   				</div>
   				
	   				<div class="form-group">
	   					<label class="sr-only" for="searchKeyword">검색어</label>
	   					<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어"
	   						value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
	   				</div>
   				
   					<button type="button" class="btn btn-default">검색</button>
   				
   					<input type="hidden" id="currentPage" name="currentPage" value=""/>
   				</form>
   			</div>
   		</div>
   	
   		<table class="table table-hover table-striped">
   			<thead>
	   			<tr>
	   				<th align="center">No</th>
	   				<th align="left" style="width: 200px;"></th>
	   				<th align="left">상품명</th>
					<th align="left">가격</th>
					<th align="left">등록일</th>
					<th align="left">현재상태</th>
					<th class="hidden"/>
				</tr>
			</thead>
		
			<tbody>
				<c:set var="i" value="0"/>
				<c:forEach var="product" items="${list}">
					<c:set var="i" value="${i+1}"/>
					<tr>
						<td align="center">${ i }<input type="hidden" name="prodNo" value="${product.prodNo}"></td>
						<td align="left" style="width: 100px"><img src="/images/uploadFiles/${product.fileName}" style="height: 100px;display: block; margin: 0 auto;"></td>
		   				<td align="left">${product.prodName}</td>
						<td align="left">${product.price}</td>
						<td align="left">${product.manuDate}</td>
						<td align="left">
							<c:if test="${product.proTranCode=='판매중'}">
								판매중
							</c:if>
							<c:if test="${product.proTranCode!='판매중'}">
								<c:if test="${menu=='search'}">
									재고없음
								</c:if>
								<c:if test="${menu=='manage'}">
									${product.proTranCode}
								</c:if>
								<c:if test="${product.proTranCode=='구매완료'}">
								<c:if test="${menu=='manage'}">
									<a href="/purchase/updateTranCodeByProd?menu=${menu}&prodNo=${product.prodNo}&proTranCode=${product.proTranCode}" >배송하기</a>
								</c:if>
								</c:if>
							</c:if>
							</td>
						<input type="hidden" name="${product.prodName}" value="${product.prodNo}">
					</tr>
				</c:forEach>
			</tbody>
   		</table>
	</div>
	
	<!-- PageNavigation Start... -->
	<c:set var="what" value="Product" scope="request"/>
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
   	

</body>
</html>
