package com.model2.mvc.web.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.service.coupon.CouponService;
import com.model2.mvc.service.domain.Coupon;
import com.model2.mvc.service.domain.GoogleProfile;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.domain.Token;

//==> ȸ������ Controller
@Controller
@RequestMapping("/user/*")
public class UserController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
	
	
	@Autowired
	@Qualifier("couponServiceImpl")
	private CouponService couponService;
	
	
		
	public UserController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	

	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{
	
		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	

	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user, HttpSession session ) throws Exception {

		System.out.println("/user/addUser : POST");
		//Business Logic
		userService.addUser(user);
		
		session.setAttribute("user", userService.getUser(user.getUserId()));
		return "redirect:/index.jsp";		
	}
	
	//@RequestMapping("/getUser.do")
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);
		
		
		
		///////////////////////////////���� ������ �Ѱ��ִ� �κ� //////////////////////////////////
		
		List<Coupon> list = couponService.getSimpleCouponList();
		model.addAttribute("list", list);		
		
		///////////////////////////////���� ������ �Ѱ��ִ� �κ� //////////////////////////////////
		
		
		return "forward:/user/getUser.jsp";
	}
	
	
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);
		
		return "forward:/user/updateUser.jsp";
	}
	
	//@RequestMapping("/updateUser.do")
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		//return "redirect:/getUser.do?userId="+user.getUserId();
		return "redirect:/user/getUser?userId="+user.getUserId();
	}
	
	//@RequestMapping("/loginView.do")
	//public String loginView() throws Exception{
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{
		
		System.out.println("/user/logon : GET");

		return "redirect:/user/loginView.jsp";
	}
	
	//@RequestMapping("/login.do")
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user, HttpSession session, Model model ) throws Exception{
		
		System.out.println("/user/login : POST");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		
		if(dbUser == null) {
			model.addAttribute("message", "��ġ�ϴ� ���̵� �����ϴ�.");
			return "forward:/common/alertView.jsp";
		}else if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
			return "redirect:/index.jsp";
		}else {
			model.addAttribute("message", "��й�ȣ�� Ʋ�Ƚ��ϴ�.");
			return "forward:/common/alertView.jsp";
		}		
	}
	
	//@RequestMapping("/logout.do")
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{	
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	
	//@RequestMapping("/checkDuplication.do")
	@RequestMapping( value="checkDuplication", method=RequestMethod.POST )
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{
		
		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		// Model �� View ����
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}
	
	//@RequestMapping("/listUser.do")
	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}	
	
	
	@RequestMapping(value="googleLogin")
	public String googleLogin( @RequestParam("code") String code, Model model, HttpSession session) throws Exception{
		String query = "code=" + code;
		query += "&client_id=" + "1066684939894-ov1i6t12dtlchrirrgasm2oa133nmut5.apps.googleusercontent.com";
		query += "&client_secret=" + "7fAqt-iMU2JhiTYJyHFo9Dyj";
		query += "&redirect_uri=" + "http://localhost:8080/user/googleLogin";
		query += "&grant_type=authorization_code";

		String tokenJson = CommonUtil.getHttpConnection("https://accounts.google.com/o/oauth2/token", query);	
		
		Gson gson = new Gson();
		Token token = gson.fromJson(tokenJson, Token.class);
		String ret = CommonUtil.getHttpConnection("https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + token.getAccess_token());	
		
		GoogleProfile profile = gson.fromJson(ret, GoogleProfile.class);
		
		//���ۿ� ����� ������ �ִٸ� ������ �ҷ���
		if(userService.getGoogleID(profile.getId()) != null ) {
			session.setAttribute("user", userService.getGoogleID(profile.getId()));
			return "redirect:/index.jsp";
		}
		
		//���� ������ �ȵǾ� ������ ���� ȭ������ �̵�
		User user = new User();
		user.setEmail(profile.getEmail());
		user.setGoogleId(profile.getId());		
	
		model.addAttribute("user", user);
		
		return "forward:/user/addUserView.jsp";
	}
	
}