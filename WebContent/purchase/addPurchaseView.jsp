<%@page import="com.model2.mvc.service.domain.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>


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
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script type="text/javascript" src="../javascript/calendar.js"></script>	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
<script type="text/javascript">
	// Jquery 실행 문
	$(function() {		

	$("#discountCoupon").change(function() {

			$.ajax({
				url : "/purchase/json/discountPrice",
				method : "post",
				dataType : 'json',
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					discountNo : $("#discountCoupon").val(),
					price : '${product.price}'

				}),
				success : function(JSONData, status) {					
					var  discountPrice = '${product.price}' +'<br/><h5 style="color: red">' + "(할인가격 : " +JSONData +") </h5>";											
					$("#totalPrice").html(discountPrice);					
				}

			});
		});

		$("button:contains('구매')").on("click", function() {			
			
			$("form").attr("action", "/purchase/addPurchase");
			$("form").submit();
		});

		$("button:contains('취소')").on("click", function() {
			//window.history.back();
			self.location = document.referrer;
		});	
		
		$("i").on("click", function() {		
			show_calendar('document.detailForm.divyDate', document.detailForm.divyDate.value);
		});


	});
	
	
</script>
</head>

<body>
	
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		
		
		<div class="page-header">
		      <h3 class=" text-info">상품 구매 정보</h3>	
		</div>	
			
		<div class="col-md-5">	
		
		
			<div class="row">
			  		<div class="col-xs-4 col-md-4">
			  			<img src="/images/uploadFiles/${product.fileName.get(0).fileName}" width="400" />			  		
			  		</div>				
			</div>
		
			<div class="row">
			  		<div class="col-xs-4 col-md-4"><strong>상품번호</strong></div>
					<div class="col-xs-8 col-md-5">${product.prodNo}</div>
			</div>
			
			<hr/>
			
			<div class="row">
			  	<div class="col-xs-4 col-md-4"><strong>상품명</strong></div>
				<div class="col-xs-8 col-md-5">${product.prodName}</div>
			</div>
			
			<hr/>
			
			<div class="row">
			  	<div class="col-xs-4 col-md-4"><strong>상품상세정보</strong></div>
				<div class="col-xs-8 col-md-5">${product.prodDetail}</div>
			</div>
			
			<hr/>
			
			<div class="row">
			  	<div class="col-xs-4 col-md-4"><strong>제조일자</strong></div>
				<div class="col-xs-8 col-md-5">${product.manuDate}</div>
			</div>
			
			<hr/>			

		</div>
		
		<div class="col-md-1">
		<!-- 공간을 벌리기 위해 설정 -->
		</div>
		
			
		<div class="col-md-6">	
		
			<div class="row">
			  	<div class="col-xs-4 col-md-3"><strong>회원아이디</strong></div>
				<div class="col-xs-8 col-md-4">${user.userId}</div>
			</div>
			
			<hr/>
		
		
		
			<div class="row">
			  	<div class="col-xs-4 col-md-3"><strong>가격</strong></div>
				<div id="totalPrice" class="col-xs-8 col-md-4" >${product.price}</div>
			</div>
			
			<hr/>
			<form name="detailForm"  method="post">
			
			<input type="hidden" name="prodNo" value="${product.prodNo}" />
			
			<div class="row">
			  	<div class="col-xs-4 col-md-3"><strong>적용가능쿠폰</strong></div>
				<div class="col-xs-8 col-md-4">
					<select name="discountCoupon" id="discountCoupon" class="form-control">
						<option value='0'>===== 선택 =====</option>
						<c:forEach var="discount" items="${list}">
							<option value="${discount.discountNo}">${discount.discountCoupon.couponName}</option>
						</c:forEach>
					</select>				
				</div>
			</div>
			
			<hr/>
			
			<div class="row">
			  	<div class="col-xs-4 col-md-3"><strong>구매방법</strong></div>
				<div class="col-xs-8 col-md-4">				
					<select name="paymentOption" class="form-control">
							<option value="1" selected="selected">현금구매</option>
							<option value="2">신용구매</option>
					</select>				
				</div>
			</div>
			
			<hr/>
			
			<div class="row">
			  	<div class="col-xs-4 col-md-3"><strong>구매자이름</strong></div>
				<div class="col-xs-8 col-md-4">				
					<input type="text" name="receiverName" class="form-control" value="${user.userName}" />
				</div>
			</div>
			
			<hr/>
			
			<div class="row">
			  	<div class="col-xs-4 col-md-3"><strong>구매자연락처</strong></div>
				<div class="col-xs-8 col-md-4">				
					<input type="text" name="receiverPhone" class="form-control" value="${user.phone}" />
				</div>
			</div>
			
			<hr/>
			
			<div class="row">
			  	<div class="col-xs-4 col-md-3"><strong>구매자주소</strong></div>
				<div class="col-xs-8 col-md-4">				
					<input type="text" name="divyAddr" class="form-control" value="${user.addr}" />
				</div>
			</div>
			
			<hr/>
			
			<div class="row">
			  	<div class="col-xs-4 col-md-3"><strong>배송요청사항</strong></div>
				<div class="col-xs-8 col-md-4">				
					<input type="text" name="divyRequest" class="form-control" placeholder="배송시 요청사항을 적어 주세요"/>
				</div>
			</div>
			
			<hr/>			
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3"><strong>배송희망일자</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" name="divyDate" class="form-control" placeholder="원하는 배송일을 지정해주세요" readonly/>			
				</div>			
				<i class="glyphicon glyphicon-calendar" ></i>			
			</div>			
			<hr/>				
		
			</form>	
		</div>
				
					<div class="row">
			  			<div class="col-md-12 text-center">
			  		
			  			<button type="button" class="btn btn-primary  btn-lg">구매</button>	 
			  			<button type="button" class="btn btn-primary  btn-lg">취소</button>	  			
		
			  			</div>
					</div>		
	
	</div>

</body>
</html>