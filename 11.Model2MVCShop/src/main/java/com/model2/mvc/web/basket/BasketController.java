package com.model2.mvc.web.basket;

import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.basket.BasketService;
import com.model2.mvc.service.domain.Basket;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/basket/*")
public class BasketController {

	@Autowired
	@Qualifier("basketServiceImpl")
	private BasketService basketService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public BasketController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value="addBasket", method=RequestMethod.GET)
	public ModelAndView addBasket(@RequestParam("prodNo") int prodNo, HttpSession session) throws Exception {
		
		System.out.println("/addBasket POST");
		
		String viewName = "/product/listProduct?menu=search";
		Product product = productService.getProduct(prodNo);
		String userId=((User)session.getAttribute("user")).getUserId();
		User user = userService.getUser(userId);
		
		Basket basket = new Basket();
		basket.setPreProduct(product);
		basket.setPreUser(user);
		
		basketService.addBasket(basket);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		return modelAndView;
	}
	
	@RequestMapping(value="listBasket")
	public ModelAndView getBasketList(@ModelAttribute("search") Search search , HttpSession session) throws Exception {
		
		System.out.println("/listBasket");
		
		System.out.println(search);
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String userId=((User)session.getAttribute("user")).getUserId();
		Map<String, Object> map = basketService.getBasketList(search, userId);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);
		
		String viewName = "/basket/listBasket.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	@RequestMapping(value="deleteBasket")
	public ModelAndView deleteBasket() throws Exception {
		
		System.out.println("/deleteBasket");
		
		basketService.deleteBasket(0);
		String viewName = "/basket/listBasket.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		return modelAndView;
	}
	
//	@RequestMapping(value="buyBasket")
//	public ModelAndView buyBasket() throws Exception {
//		
//		System.out.println("/buyBasket");
//		String viewName = "/purchase/";
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.setViewName(viewName);
//		return modelAndView;
//	}
}
