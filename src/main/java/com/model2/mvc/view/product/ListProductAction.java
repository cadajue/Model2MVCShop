package com.model2.mvc.view.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;



public class ListProductAction extends Action {

	@Override
	public String execute(	HttpServletRequest request,
												HttpServletResponse response) throws Exception {
		Search search=new Search();
		
		int currentPage=1;
		
		//������ �������� ������ �ش� �������� ����
		if(request.getParameter("currentPage") != null) {
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		
		search.setCurrentPage(currentPage);
		search.setSearchCondition(request.getParameter("searchCondition"));
		search.setSearchKeyword(request.getParameter("searchKeyword"));	
		
		search.setSearchKeywordOptional(request.getParameter("searchKeywordOptional"));
		search.setSearchOrder(request.getParameter("searchOrder"));
		
		
		// web.xml  meta-data �� ���� ��� ���� 
		int pageSize = Integer.parseInt( getServletContext().getInitParameter("pageSize"));
		int pageUnit  =  Integer.parseInt(getServletContext().getInitParameter("pageUnit"));
		search.setPageSize(pageSize);
		search.setPageSize(pageUnit);
		
		ProductService service=new ProductServiceImpl();
		Map<String,Object> map=service.getProductList(search);
		
		Page resultPage	= new Page( currentPage, ((Integer)map.get("count")).intValue(), pageUnit, pageSize);
		
		
		System.out.println("�˻�Ű���� :" + request.getParameter("searchKeyword"));

		// Model �� View ����
		request.setAttribute("list", map.get("list"));
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search);
		
		//requst���� param���� �Ѿ�� �� ����
		request.setAttribute("menu", request.getParameter("menu"));
				
		return "forward:/product/listProduct.jsp";
	}
}