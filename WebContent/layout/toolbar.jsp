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
	         
	         	<!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  ȸ������ DrowDown -->
	              <c:if test="${sessionScope.user != null}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >ȸ������</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="/user/getUser?userId=${user.userId}">����������ȸ</a></li>
		                         
		                         <c:if test="${sessionScope.user.role == 'admin'}">
		                         	<li><a href="#">ȸ��������ȸ</a></li>
		                         </c:if>	                         
	
		                     </ul>
		                 </li>
	                 </c:if>
	                 
	              <!-- �ǸŻ�ǰ���� DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >�ǸŻ�ǰ����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">�ǸŻ�ǰ���</a></li>
		                         <li><a href="#">�ǸŻ�ǰ��ȸ</a></li>		       
		                     </ul>
		                </li>		                
	                 </c:if>
	                 
	                 <c:if test="${sessionScope.user != null}">
	                       <li class="dropdown">
			                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
			                         <span >�����߱ް���</span>
			                         <span class="caret"></span>
			                     </a>
			                     <ul class="dropdown-menu">
			                     	<c:if test="${sessionScope.user.role == 'admin'}">
			                        	<li><a href="#">�ű��������</a></li>
			                         	<li><a href="#">�߱�������ȸ</a></li>
			                         	<!-- <li><a href="#">���������Ȳ</a></li> -->
			                        </c:if>
			                        <c:if test="${sessionScope.user.role == 'user'}">
			                        	<li><a href="#">����������ȸ</a></li>
			                         </c:if>		       
			                     </ul>
			                </li>
		                </c:if>
	                 
	              <!-- ���Ű��� DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >��ǰ����</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">�ǸŻ�ǰ�˻�</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#">�����̷���ȸ</a></li>
	                         </c:if>
	                         
	                         <li><a href="#">�ֱ���ȸ��ǰ</a></li>	      
	                     </ul>
	                 </li>	                 
	                 
	             </ul>
	            
	             <c:if test="${not empty sessionScope.user}">
	                <ul class="nav navbar-nav navbar-right">
	                	<li><a href="#">�α׾ƿ�</a></li>
	            	</ul>	             
	             </c:if>

	            
	     	     <c:if test="${empty sessionScope.user}">
	                <ul class="nav navbar-nav navbar-right">
	                	<li><a href="#">ȸ������</a></li>
	            	</ul>
	                
	                <ul class="nav navbar-nav navbar-right">
	                	<li><a href="#">�α���</a></li>
	            	</ul>
	             
	             </c:if>
	            
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
	
	   	
		function history(){
			popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		}
	   	
   	
		//============= logout Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('�α׾ƿ�')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
		 });
		
		
			//============= login Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('�α���')").on("click" , function() {
				$(self.location).attr("href","../user/loginView.jsp");
				
			}); 
			
		 	$("a:contains('ȸ������')").on("click" , function() {
				$(self.location).attr("href","../user/addUserView.jsp");
				
			});
			
		 });
		
		
		//============= ȸ��������ȸ Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('ȸ��������ȸ')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		

	 	$( "a:contains('����������ȸ')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});		
		
		
	 	$( "a:contains('�ǸŻ�ǰ���')" ).on("click" , function() {		
	 		$(self.location).attr("href","../product/addProductView.jsp;");
		});
	 	
	 	$( "a:contains('�ǸŻ�ǰ��ȸ')" ).on("click" , function() {		
	 		$(self.location).attr("href","/product/listProduct?menu=manage");
		});
	 	
	 	$( "a:contains('�ű��������')" ).on("click" , function() {		
	 		$(self.location).attr("href","../coupon/addCouponView.jsp;");
		});
	 	
		$( "a:contains('�߱�������ȸ')" ).on("click" , function() {		
			$(self.location).attr("href","/coupon/listCoupon");
		});
		
		$( "a:contains('���������Ȳ')" ).on("click" , function() {		
			$(self.location).attr("href","/discount/listDiscountHistory");
		});
				
		$( "a:contains('����������ȸ')" ).on("click" , function() {		
			$(self.location).attr("href","/discount/DiscountList");
		});		
		
		$( "a:contains('�ǸŻ�ǰ�˻�')" ).on("click" , function() {		
			$(self.location).attr("href","/product/listProduct?menu=search");
		});
	 	
		$( "a:contains('�����̷���ȸ')" ).on("click" , function() {		
			$(self.location).attr("href","/purchase/listPurchase");
		});
		
		
		$( "a:contains('�ֱ���ȸ��ǰ')" ).on("click" , function() {		
			history();
		});	
		
		
	</script>  