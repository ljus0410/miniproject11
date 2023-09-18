package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthOptionPaneUI;

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
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public ModelAndView addPurchase(@RequestParam("prodNo") int prodNo, HttpSession session) throws Exception {
		
		System.out.println("/addPurchase GET");
		
		String viewName = "/purchase/addPurchaseView.jsp";
		Product product = productService.getProduct(prodNo);
		String userId=((User)session.getAttribute("user")).getUserId();
		
		User user = userService.getUser(userId);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("user", user);
		modelAndView.addObject("product", product);
		
		return modelAndView;
	}
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public ModelAndView addPurchase(@ModelAttribute("product") Product product, 
									@ModelAttribute("user") User user, 
									@ModelAttribute("purchase") Purchase purchase) throws Exception {
		
		System.out.println("/addPurchase POST");
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setTranCode("1");
		purchaseService.addPurchase(purchase);
		System.out.println(purchase);
		String viewName = "/purchase/getPurchase.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public ModelAndView getPurchase(@RequestParam("prodNo") int prodNo) throws Exception {
		
		System.out.println("/getPurchase");
		
		Purchase purchase = purchaseService.getPurchase(prodNo);
		System.out.println(purchase.getPurchaseProd());
		String viewName = "/purchase/getPurchase.jsp";
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	@RequestMapping(value="listPurchase")
	public ModelAndView getPurchaseList(@ModelAttribute("search") Search search, @ModelAttribute("user") User user) throws Exception {
		
		System.out.println("/listPurchase");
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		Map<String, Object> map = purchaseService.getPurchaseList(search, user);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		String viewName = "/purchase/listPurchase.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public ModelAndView updatePurchase(@RequestParam("prodNo") int prodNo) throws Exception {
		
		System.out.println("/updatePurchase GET");
		
		Purchase purchase = purchaseService.getPurchase(prodNo);
		System.out.println(purchase);
		String viewName = "/purchase/updatePurchase.jsp";

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("purchase",purchase);
		
		return modelAndView;
	}
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public ModelAndView updatePurchase(@ModelAttribute("purchase") Purchase purchase) throws Exception {
		
		System.out.println("/updatePurchase POST");
		
		String viewName = "/purchase/getPurchase.jsp";

		purchaseService.updatePurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("purchase",purchase);
		
		return modelAndView;
	}
	
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
	public ModelAndView updateTranCodeByProd(@RequestParam("prodNo") int prodNo,
												@RequestParam("proTranCode") String proTranCode,
												@RequestParam("menu") String menu) throws Exception {
		System.out.println("updateTranCodeByProd");
		System.out.println(menu);
		String viewName = "redirect:/product/listProduct?menu="+menu;
		String tranCode = null;
			
		if (proTranCode.equals("판매중")) {
			tranCode = "0";
		} else if(proTranCode.equals("구매완료")) {
			tranCode = "1";
		} else if (proTranCode.equals("배송중")) {
			tranCode = "2";
		} else if (proTranCode.equals("배송완료")) {
			tranCode = "3";
		}
		
		Purchase purchase = purchaseService.getPurchase(prodNo);
		System.out.println(purchase);
		System.out.println(tranCode);
		purchaseService.updateTranCode(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("purchase",purchase);
		
		return modelAndView;
	}
	
//	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.POST)
//	public ModelAndView updateTranCodeByProd(@ModelAttribute("product") Product product,
//													@RequestParam("menu") String menu) throws Exception {
//			System.out.println("updateTranCodeByProd");
//			System.out.println(product);
//			int prodNo = product.getProdNo();
//			System.out.println("여기"+prodNo);
//			String proTranCode = product.getProTranCode();
//			String viewName = "/purchase/listProduct?menu="+menu;
//			String tranCode = null;
//				
//			if (proTranCode.equals("판매중")) {
//				tranCode = "0";
//			} else if(proTranCode.equals("구매완료")) {
//				tranCode = "1";
//			} else if (proTranCode.equals("배송중")) {
//				tranCode = "2";
//			} else if (proTranCode.equals("배송완료")) {
//				tranCode = "3";
//			}
//			
//			Purchase purchase = purchaseService.getPurchase(prodNo);
//			System.out.println(purchase);
//			System.out.println(tranCode);
//			purchaseService.updateTranCode(purchase);
//			
//			ModelAndView modelAndView = new ModelAndView();
//			modelAndView.setViewName(viewName);
//			modelAndView.addObject("purchase",purchase);
//			
//			return modelAndView;
//		}
}
