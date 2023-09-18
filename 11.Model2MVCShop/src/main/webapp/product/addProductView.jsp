<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>

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
	  body {
            padding-top : 70px;
        }
        
        
    </style>
    
	<title>상품등록</title>

<script type="text/javascript">
	
	$(function() {
    $("#fileNameOrigin").change(function() {
        var file = this.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $("#imagePreview").attr("src", e.target.result).show();
            };
            reader.readAsDataURL(file);
        } else {
            $("#imagePreview").hide();
        }
    });
	});
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-primary" ).on("click" , function() {
			fncAddProduct();
		});
	});
	
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#']").on("click" , function() {
			$("form")[0].reset();
		});
	});	

	
	function fncAddProduct(){
		//Form 유효성 검증
		
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
		
		if(name == null || name.length<1){
			alert("상품명은 반드시 입력하여야 합니다.");
			return;
		}
		
		if(detail == null || detail.length<1){
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		
		if(manuDate == null || manuDate.length<1){
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
		
		if(price == null || price.length<1){
			alert("가격은 반드시 입력하셔야 합니다.");
			return;
		}
		
		$("form").attr("method" , "POST").attr("action" , "/product/addProduct?menu=${menu}").submit();
	
	}

</script>

</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

   	
   	<div class="container">
   		
   		<h2 class="bg-default text-center">상 품 등 록</h2><br/>
   		<form class="form-horizontal" enctype="multipart/form-data">
   			<div class="form-group">
   				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
   				<div class="col-sm-4">
		    		<input type="text" class="form-control" id="prodName" name="prodName">
				</div>
   			</div>
   			
   			<div class="form-group">
		    	<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="prodDetail" name="prodDetail">
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    	<div class="col-sm-4">
		      		<input type="date" class="form-control" id="manuDate" name="manuDate">
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가 격</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="price" name="price">
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    	<div class="col-sm-4">
		      		<input type="file" class="form-control" id="fileNameOrigin" name="fileNameOrigin">
		    	</div>
		  	</div>
		  	
		  	<div class="col-sm-offset-4 col-sm-3">
		    	<img src="" alt="미리보기" id="imagePreview" style="display:none; max-width: 350px;">
		  	</div>
		  	
		  	<div class="form-group">
		    	<div class="col-sm-offset-4  col-sm-4 text-center">
		      		<button type="button" class="btn btn-primary"  >등&nbsp;록</button>
			  		<a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    	</div>
		  	</div>
   		</form>
   		
		
		
   	</div>
   

</body>

</html>