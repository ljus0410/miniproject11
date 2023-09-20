<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">

<head>

	<meta charset="UTF-8">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>

<title>구매 화면</title>

<script type="text/javascript">

$(function() {
	
	$("input:button").click(function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                
            	$("#addrPostcode").val(data.zonecode);
            	$("#addrRoad").val(data.roadAddress);
                     
            }
        }).open();
    })
	
    $("#inlineRadio1").click(function() {
    	$.ajax(
				{
					url : "/user/json/getUser/"+$("#userId").val(),
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData, status) {
						$("#addrPostcode").val(JSONData.addrPostcode);
						$("#addrRoad").val(JSONData.addrRoad);
						$("#addrExtra").val(JSONData.addrExtra);
					}
				}
			);
    })
    $("#inlineRadio2").click(function() {
		$("form")[0].reset();
	});
});

	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-primary" ).on("click" , function() {
			fncAddPurchase();
		});
	});
	
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#']").on("click" , function() {
			$("form")[0].reset();
		});
	});	
	
	function fncAddPurchase() {
		$("form").attr("method","POST").attr("action","/purchase/addPurchase").submit();
	}
	
	$(function() {
		var today = new Date();
		
		var yyyy = today.getFullYear();
		var mm = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 두 자리로 패딩합니다.
		var dd = String(today.getDate()).padStart(2, '0'); // 일도 두 자리로 패딩합니다.
		var formattedDate = yyyy + '-' + mm + '-' + dd;
		
		$("#divyDate").attr("min", formattedDate);
	})

</script>


</head>

<body>
	
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>

	<div class="container">
		<h2 class="bg-default text-center">구매하기</h2><br/>
		
		<form class="form-horizontal">
		
		<input type="hidden" name="prodNo" value="${product.prodNo}" />
		<input type="hidden" id="userId" name="userId" value="${user.userId}" />
		
			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
				<div class="col-sm-4">
		    		${product.prodName}
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
				<div class="col-sm-4">
		    		${product.prodDetail}
				</div>
			</div>
			
			<div class="form-group">
				<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
				<div class="col-sm-4">
		    		${product.manuDate}
				</div>
			</div>
			
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
				<div class="col-sm-4">
		    		${product.price}
				</div>
			</div>
			
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">상품갯수</label>
				<div class="col-sm-4">
		    		<select class="form-control" name="purchaseCount" id="purchaseCount">
		    		<c:forEach var="i" begin="1" end="${product.prodCount}">
					  	<option value="${i}" >${i}</option>
					</c:forEach>
					<input type="hidden" name="prodCount" id="prodCount" value="${product.prodCount}">
				</select>
				</div>
			</div>
			
			<div class="form-group">
				<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">구매자 아이디</label>
				<div class="col-sm-4">
		    		${user.userId}
				</div>
			</div>
			
			<div class="form-group">
   				<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자 이름</label>
   				<div class="col-sm-4">
		    		<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
				</div>
   			</div>
   			
   			<div class="form-group">
   				<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자 연락처</label>
   				<div class="col-sm-4">
		    		<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
				</div>
   			</div>
   			
   			<div class="form-group">
   				<label for="recieverName" class="col-sm-offset-1 col-sm-3 control-label">구매 방법</label>
   				<div class="col-sm-4">
		    		<select name="paymentOption" class="form-control">
						<option value="1">현금구매</option>
						<option value="2">카드구매</option>
					</select>
				</div>
   			</div>
   			<div class="form-group">
		    <label for="receiverAddr" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
   			<div class="form-group">
		    	<label class="col-sm-2 radio-inline">
		  			&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> 회원정보와 동일
				</label>
				<label class="col-sm-2 radio-inline">
		  			<input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2" checked> 새로운 배송지
				</label>
		  	</div>
		  	</div>
   			<div class="form-group">
   			<label for="receiverAddr" class="col-sm-offset-1 col-sm-3 control-label"></label>
		    <div class="col-sm-2 inline">
		      <input type="text" class="form-control" id="addrPostcode" name="addrPostcode" placeholder="우편번호">
		    </div>
		    <div class="col-sm-2 inline">
		      <input type="button" class="btn btn-info" name="button" value="우편번호 찾기">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverAddr" class="col-sm-offset-1 col-sm-3 control-label"></label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="addrRoad" name="addrRoad" placeholder="도로명주소">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverAddr" class="col-sm-offset-1 col-sm-3 control-label"></label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="addrExtra" name="addrExtra" placeholder="상세주소">
		    </div>
		  </div>
   			
   			<div class="form-group">
   				<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">배송 요청사항</label>
   				<div class="col-sm-4">
		    		<input type="text" class="form-control" id="divyRequest" name="divyRequest">
				</div>
   			</div>
			
			<div class="form-group">
   				<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송 희망날짜</label>
   				<div class="col-sm-4">
		    		<input type="date" class="form-control" id="divyDate" name="divyDate" min="2023-09-20">
				</div>
   			</div>
   			
   			<div class="form-group">
		    	<div class="col-sm-offset-4  col-sm-4 text-center">
		      		<button type="button" class="btn btn-primary"  >구&nbsp;매</button>
			  		<a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    	</div>
		  	</div>
		  	
		</form>
		
	</div>

</body>
</html>