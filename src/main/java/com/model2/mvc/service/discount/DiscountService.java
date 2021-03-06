package com.model2.mvc.service.discount;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Discount;
import com.model2.mvc.service.domain.Product;

public interface DiscountService {

	public Discount	findDiscount(int discountNo) throws Exception;	
	
	public void addDiscount(Discount discount) throws Exception;
	
	public void useDiscount(Map<String, Object> value) throws Exception;
	
	public void deleteDiscount(int discountNo) throws Exception;
	
	public List<Discount> getDiscountSimpleList(Map<String, Object> value) throws Exception;	
	
	public Map<String, Object> getDiscountCouponList(Search search,String ownerId) throws Exception;
	
	public Map<String,Object> getDiscountCouponList(Search search)  throws Exception;
}
