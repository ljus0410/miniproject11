<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

	<title>구매 목록조회</title>

<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용 
	
	/* $(function() {
		
		$( "td[name=arrive]" ).on("click" , function() {
			 self.location =
			 "/updateTranCodeByProd?menu=search&prodNo=${purchase.purchaseProd.prodNo}&proTranCode=${purchase.purchaseProd.proTranCode}";
		});
	}) */
	
	function fncGetPurchaseList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
	   	document.detailForm.submit();
	   	$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
	}
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<div class="container">
   		<div class="page-header text-info">
   			<h3>구매목록조회</h3>
   		</div>

		<div class="row">
   			<div class="col-md-6 text-left">
   				<p class="text-primary">
   					전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
   				</p>
   			</div>
   		</div>
   		
   		<table class="table table-hover table-striped">
   			<thead>
   				<th align="center">No</th>
				<th align="left">배송자명</th>
				<th align="left">전화번호</th>
				<th align="left">배송현황</th>
				<th align="left">배송확인</th>
   			</thead>
   			<tbody>
   				<c:set var="i" value="0"/>
   				<c:forEach var="purchase" items="${list}">
   					<c:set var="i" value="${i+1}"/>
   					<tr>
   						<td align="center">${i}</td>
   						<td align="left">${purchase.receiverName}</td>
   						<td align="left">${purchase.receiverPhone}</td>
   						<td align="left">현재 ${purchase.purchaseProd.proTranCode} 상태입니다.</td>
   						<td align="left" name="arrive">
   							<c:if test="${purchase.tranCode.trim()==2}">
   							<a href="/purchase/updateTranCodeByProd?menu=search&prodNo=${purchase.purchaseProd.prodNo}&proTranCode=${purchase.purchaseProd.proTranCode}">물건도착</a>
							</c:if>
						</td>
   					</tr>
   				</c:forEach>
   			</tbody>
   		</table>
 	</div>
 	
 	<!-- PageNavigation Start... -->
 	<c:set var="what" value="Purchase" scope="request"/>
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->

</body>
</html>