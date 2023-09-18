package com.model2.mvc.web.product;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}

	@RequestMapping( value="json/listProduct")
	public List<Product> listProduct(@ModelAttribute("search") Search search, HttpServletRequest request) throws Exception{
		System.out.println("/product/json/listProduct : POST");
		//Business Logic
		System.out.println(search);
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(20);
		Map<String, Object> map = productService.getProductList(search);
		search.setPageSize((Integer)map.get("totalCount"));
		List<Product> list = (List<Product>)map.get("list");
		return list;
	}
}