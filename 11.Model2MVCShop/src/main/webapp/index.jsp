<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!-- ///// JSTL ///// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ///// 로그인시 Forward  ///// -->
<c:if test="${ ! empty user }">
	<jsp:forward page="main.jsp"/>
</c:if>
<!-- ////////////////////////// -->

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">
	
	<!-- 참조 : http://getbootstrap.com/css/ -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- ///// Bootstrap, jQuery CDN ///// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<!-- ///// CSS ///// -->
	<style>
		body {
            padding-top : 70px;
        }
	</style>
   	
   	<!-- ///// JavaScript ///// -->
	<script type="text/javascript">
		
		//============= 회원가입 화면이동 =============
		$( function() {
			$("a[href='/user/addUser']:contains('회원가입')").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
		//============= 로그인 화면이동 =============
		$( function() {
			$("a[href='/user/login']:contains('로 그 인')").on("click" , function() {
				self.location = "/user/login"
			});
		});
		
	</script>
	
</head>

<body>

	<!-- ToolBar Start ///// -->
	<div class="navbar  navbar-default navbar-fixed-top">
		
        <div class="container">
        
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
			
			<!-- toolBar Button Start ///// -->
			<div class="navbar-header">
			    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
			    </button>
			</div>
			<div class="collapse navbar-collapse" id="target">
	        	<ul class="nav navbar-nav navbar-right">
	                 <li><a href="/user/addUser">회원가입</a></li>
	                 <li><a href="/user/login">로 그 인</a></li>
	           	</ul>
	    	</div>
   			<!-- toolBar Button End ///// -->
   			
   		</div>
   	</div>
   	<!-- ToolBar End ///// -->
   	
	<!--  화면구성 div Start ///// -->
	<div class="container">
		
		<!-- 다단레이아웃  Start ///// -->
		<div class="row">
	
			<!--  Menu 구성 Start /////////////////////////////////////-->     	
			<div class="col-md-3">
			
				<div class="panel panel-primary">
					<div class="panel-heading">
						상품구매
	    			</div>
					<ul class="list-group">
						 <a href="/product/listProduct?menu=search" class="list-group-item"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 전체상품검색</a>
					</ul>
				</div>
				
			</div>
			<!--  Menu 구성 end /////////////////////////////////////-->   

	 	 	<!--  Main start /////////////////////////////////////-->   		
	 	 	<div class="col-md-9">
				<div class="jumbotron">
			  		<h1>Model2 MVC Shop</h1>
			  		<p>로그인 후 사용가능...</p>
			  		<p>로그인 전 검색만 가능합니다.</p>
			  		<p>회원가입 하세요.</p>
			  		
			  		<div class="text-center">
			  			<a class="btn btn-info btn-lg" href="/user/addUser" role="button">회원가입</a>
			  			<a class="btn btn-info btn-lg" href="/user/login" role="button">로 그 인</a>
			  		</div>
			  	
			  	</div>
	        </div>
	   	 	<!--  Main end /////////////////////////////////////-->   		
	 	 	
		</div>
		<!-- 다단레이아웃  end /////////////////////////////////////-->
		
	</div>
	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>