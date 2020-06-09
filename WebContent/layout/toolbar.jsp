<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  회원관리 DrowDown -->
	              <c:if test="${sessionScope.user != null}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >회원관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="/user/getUser?userId=${user.userId}">개인정보조회</a></li>
		                         
		                         <c:if test="${sessionScope.user.role == 'admin'}">
		                         	<li><a href="#">회원정보조회</a></li>
		                         </c:if>	                         
	
		                     </ul>
		                 </li>
	                 </c:if>
	                 
	              <!-- 판매상품관리 DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >판매상품관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">판매상품등록</a></li>
		                         <li><a href="#">판매상품조회</a></li>		       
		                     </ul>
		                </li>		                
	                 </c:if>
	                 
	                 
                       <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >쿠폰발급관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                     	<c:if test="${sessionScope.user.role == 'admin'}">
		                        	<li><a href="#">신규쿠폰등록</a></li>
		                         	<li><a href="#">발급쿠폰조회</a></li>
		                        </c:if>
		                         <li><a href="#">보유쿠폰조회</a></li>		       
		                     </ul>
		                </li>
	                 
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >상품구매</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">판매상품검색</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#">구매이력조회</a></li>
	                         </c:if>
	                         
	                         <li><a href="#">최근조회상품</a></li>	      
	                     </ul>
	                 </li>	                 
	                 
	             </ul>
	             
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">로그아웃</a></li>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
	
	   	
		function history(){
			popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		}
	   	
   	
		//============= logout Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('로그아웃')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
		 });
		
		//============= 회원정보조회 Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('회원정보조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		

	 	$( "a:contains('개인정보조회')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});		
		
		
	 	$( "a:contains('판매상품등록')" ).on("click" , function() {		
	 		$(self.location).attr("href","../product/addProductView.jsp;");
		});
	 	
	 	$( "a:contains('판매상품조회')" ).on("click" , function() {		
	 		$(self.location).attr("href","/product/listProduct?menu=manage");
		});
	 	
	 	$( "a:contains('신규쿠폰등록')" ).on("click" , function() {		
	 		$(self.location).attr("href","../coupon/addCouponView.jsp;");
		});
	 	
		$( "a:contains('발급쿠폰조회')" ).on("click" , function() {		
			$(self.location).attr("href","/coupon/listCoupon");
		});
				
		$( "a:contains('보유쿠폰조회')" ).on("click" , function() {		
			$(self.location).attr("href","/discount/DiscountList");
		});		
		
		$( "a:contains('판매상품검색')" ).on("click" , function() {		
			$(self.location).attr("href","/product/listProduct?menu=search");
		});
	 	
		$( "a:contains('구매이력조회')" ).on("click" , function() {		
			$(self.location).attr("href","/purchase/listPurchase");
		});
		
		
		$( "a:contains('최근조회상품')" ).on("click" , function() {		
			history();
		});
		
		

		
		
		
		
		
		
		
	</script>  