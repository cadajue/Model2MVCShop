<%@page import="com.model2.mvc.service.domain.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">
<head>

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

    
    function setDetailImg(fileName) {
    	var fileUrl = "/images/uploadFiles/"+fileName;
		$(".col-md-5 > img").attr("src",fileUrl);
	}
    
    
	
	$(function(){		
		
		
			$("button:contains('구매')").on("click", function() {
				self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
			});
			
			$("button:contains('목록')").on("click", function() {		
				//$(self.location).attr("href","/product/listProduct?menu=search");
				self.location = "/product/listProduct?menu=search";
			});	
			
			$("button:contains('수정')").on("click", function() {
					$("form").attr("method", "POST");
					$("form").attr("action", "/product/updateProduct");
					$("form").submit();
			});
			
			
			$(".imageList").on("click", function() {
				var fileName = $(this).attr("value"); 				
				setDetailImg(fileName);
			});
		
		});
		
	
	
</script>
	


</head>

<body>
		<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="/layout/toolbar.jsp" />
	
		<div class="container">
			<div class="page-header">
		       <h3 class=" text-info">상품 상세 조회</h3>		   
		    </div>	
		    
		  <div class="row"> 
		  
			  <div class="col-md-5">
			  
			  	<img src="/images/uploadFiles/${product.fileName.get(0).fileName}" width="450" />
			  
			  </div>
		  
			  <div class="col-md-7">
				  <form>  
				    <div class="row">
			  			<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
						<div class="col-xs-8 col-md-4">${product.prodNo}</div>
					</div>
				
					<hr/>
					
					<div class="row">
			  			<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
						<div class="col-xs-8 col-md-4">${product.prodName}</div>
					</div>
				
					<hr/>					
					
					<div class="row">
			  			<div class="col-xs-4 col-md-2"><strong>상세정보</strong></div>
						<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
					</div>
				
					<hr/>
					
					<div class="row">
			  			<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
						<div class="col-xs-8 col-md-4">${product.price}</div>
					</div>
				
					<hr/>
					
					<div class="row">
			  			<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
						<div class="col-xs-8 col-md-4">${product.manuDate}</div>
					</div>
				
					<hr/>
					
					
					<div class="row">
			  			<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
						<div class="col-xs-8 col-md-4">${product.regDate}</div>
					</div>
				
					<hr/>
					
					</form>
					
					<div class="row">
				  		<div class="col-md-12 text-right ">
				  		
				  			<c:if test="${sessionScope.user.role == 'user'}">
				  				<c:if test="${product.proTranCode =='0'}">
				  					<button type="button" class="btn btn-primary btn-lg">구매</button>	
				  				</c:if>		  				 
				  			</c:if>
				  			
				  			<c:if test="${sessionScope.user.role == 'admin'}">
				  				<button type="button" class="btn btn-primary btn-lg">수정</button>	 
				  			</c:if>
				  			
				  			<button type="button" class="btn btn-primary btn-lg">목록</button>					  			
			
				  		</div>
					</div>	
					<hr/>
				</div> 
		</div>	

	</div>
	
	<div class="container">
	
	    <ul class="nav nav-tabs">
		  <li role="presentation" class="active"><a href="#prodImage" data-toggle="tab">상품이미지</a></li>
		  <li role="presentation"><a href="#prodReview" data-toggle="tab">상품 리뷰</a></li>
		</ul>
		
		
		<div class="tab-pane active" id="prodImage">
			 <div class="row">    												
				<c:forEach var="image" items="${product.fileName}">
					<div class= "imageList" value="${image.fileName}">
						<div class= "col-md-3">
							<img src="/images/uploadFiles/${image.fileName}" width="200" />						
						</div>
					</div>
	
				</c:forEach>				
			</div>
		</div>	
	

	</body>
</html>