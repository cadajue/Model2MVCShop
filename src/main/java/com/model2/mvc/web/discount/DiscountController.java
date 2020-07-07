package com.model2.mvc.web.discount;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.service.coupon.CouponService;
import com.model2.mvc.service.discount.DiscountService;
import com.model2.mvc.service.domain.Coupon;
import com.model2.mvc.service.domain.Discount;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/discount/*")
public class DiscountController {

	
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;	
	
	@Autowired
	@Qualifier("couponServiceImpl")
	private CouponService couponService;
	
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	

	@Autowired
	@Qualifier("discountServiceImpl")
	private DiscountService discountService;	
	
	
	
	//����Ʈ ������
	public DiscountController() {
		// TODO Auto-generated constructor stub
	}				
	
	
	@RequestMapping(value = "addDiscount", method = RequestMethod.POST)
	public ModelAndView addCoupon(@RequestParam("selectCoupon")int selectCoupon, @RequestParam("ownerId") String userId ) throws Exception {
		
		System.out.println("���õ� ��ȣ"+ selectCoupon );
		System.out.println("���� ����"+ userId );
		
		User user = userService.getUser(userId);
		Coupon coupon = couponService.findCoupon(selectCoupon);
		
		
		Discount discount = new Discount();
		
		discount.setDiscountCoupon(coupon);
		discount.setOwner(user);
		
		discountService.addDiscount(discount);	
		return new ModelAndView("forward:/common/alertView.jsp", "message", "������ ���޵Ǿ����ϴ�.");				
	}
	
	
	@RequestMapping(value = "deleteDiscount")
	public ModelAndView deleteDiscount(@RequestParam("discountNo")int discountNo) throws Exception {
		System.out.println("���õ� ����"+ discountNo );
		
		
		discountService.deleteDiscount(discountNo);
		
		
		return new ModelAndView("forward:/common/alertView.jsp", "message", "������ �����Ǿ����ϴ�.");	
	}
	
	
	
	@RequestMapping("DiscountList")
	public ModelAndView listDiscount(@ModelAttribute("search") Search search, HttpSession session) throws Exception {
		
		//���� ���������� ������ ù��° �������� ����
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		User owner = (User)session.getAttribute("user");
		
		Map<String , Object> map = discountService.getDiscountCouponList(search, owner.getUserId());
		
				
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("count")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		
		ModelAndView modelAndView = new ModelAndView();
		
		
		// Model �� View ����
		modelAndView.setViewName("forward:/coupon/listDiscount.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		
		return modelAndView;
	}
	
		
	@RequestMapping(value = "listDiscountHistory", method = RequestMethod.POST)
	public ModelAndView listDiscountHistory(@ModelAttribute("search") Search search) throws Exception {
		
		//���� ���������� ������ ù��° �������� ����
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		
		//Condition, order ������ ��� �⺻ �� ����
		if(CommonUtil.null2str(search.getSearchCondition()) == "") {
			search.setSearchCondition("0");
		}
		
		if(CommonUtil.null2str(search.getSearchOrder()) == "") {
			search.setSearchOrder("0");			
		}			
		
		search.setPageSize(pageSize);
		
		Map<String , Object> map = discountService.getDiscountCouponList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("count")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);		
		
		ModelAndView modelAndView = new ModelAndView();		
		
		// Model �� View ����
		modelAndView.setViewName("forward:/coupon/listDiscountHistory.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);		
		
		return modelAndView;
	}
	
	@RequestMapping(value = "listDiscountHistory" ,method = RequestMethod.GET)
	public ModelAndView listDiscountHistory(@RequestParam("couponNo") int couponNo) throws Exception {
		
		Search search = new Search();		

		search.setCurrentPage(1);	
		search.setSearchCondition("0");	
		search.setSearchOrder("0");			
		search.setPageSize(pageSize);
		search.setSearchKeyword(Integer.toString(couponNo));
		
		Map<String , Object> map = discountService.getDiscountCouponList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("count")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);		
		
		ModelAndView modelAndView = new ModelAndView();
		
		
		// Model �� View ����
		modelAndView.setViewName("forward:/coupon/listDiscountHistory.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		
		return modelAndView;
	}
	
	

}
