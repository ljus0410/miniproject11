package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	public ProductController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value = "addProduct", method = RequestMethod.GET)
	public ModelAndView addProduct(@RequestParam("menu") String menu) throws Exception {

		System.out.println("/addProduct GET");

		String viewName = "/product/addProductView.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("menu", menu);

		return modelAndView;
	}

	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public ModelAndView addProduct(@ModelAttribute("product") Product product, @RequestParam("menu") String menu, @RequestParam("fileNameOrigin") MultipartFile file) throws Exception {

		System.out.println("/addProduct POST");
		String originalFilename = null;
		String temDir = "C:\\miniproject\\10.Model2MVCShop(Ajax)\\src\\main\\webapp\\images\\uploadFiles\\";
		
		if (!file.isEmpty()) {
            originalFilename = file.getOriginalFilename();
            System.out.println(originalFilename);
        }
		
		String filePath = temDir+File.separator+originalFilename;
		file.transferTo(new File(filePath));
		product.setFileName(originalFilename);
		productService.addProduct(product);

		String viewName = "/product/getProduct.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("product", product);
		modelAndView.addObject("menu", menu);

		return modelAndView;
	}

	@RequestMapping(value = "listProduct")
	public ModelAndView getProductList(@ModelAttribute("search") Search search, HttpServletRequest request,
			@RequestParam String menu) throws Exception {

		System.out.println("/listProduct");

		System.out.println(search);
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> map = productService.getProductList(search);
		System.out.println(map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		String viewName = "/product/listProduct.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("menu", menu);

		return modelAndView;
	}

	
	@RequestMapping(value="getProduct", method=RequestMethod.GET) 
	public ModelAndView getProduct(@RequestParam("prodNo") int prodNo, @RequestParam String menu) throws Exception {
		
		System.out.println("/product/getProduct : GET");
	 
		Product product = productService.getProduct(prodNo);
		System.out.println(product.getFileName());
		String viewName = "/product/getProduct.jsp";
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("menu", menu);
		modelAndView.addObject("product", product);
		
		return modelAndView;
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public ModelAndView updateProduct(@RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu) throws Exception {
		
		System.out.println("/product/updateProduct : GET");
		
		Product product = productService.getProduct(prodNo);
		
		String viewName = "/product/updateProduct.jsp";
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("product", product);
		modelAndView.addObject("menu", menu);
		
		return modelAndView;
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public ModelAndView updateProduct(@ModelAttribute("product") Product product, @RequestParam("fileNameOrigin") MultipartFile file) throws Exception {
		
		System.out.println("/product/updateProduct : POST");
		String originalFilename = null;
		String temDir = "C:\\miniproject\\11.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles\\";
		if (!file.isEmpty()) {
            originalFilename = file.getOriginalFilename();
            System.out.println(originalFilename);
        }
		
		String filePath = temDir+File.separator+originalFilename;
		file.transferTo(new File(filePath));
		product.setFileName(originalFilename);
		productService.updateProduct(product);
		
		String viewName = "/product/getProduct.jsp";
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("product", product);
		modelAndView.addObject("menu", "ok");
		return modelAndView;
	}
}
