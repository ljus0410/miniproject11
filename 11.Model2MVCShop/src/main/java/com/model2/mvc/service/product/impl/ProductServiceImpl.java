package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseDao;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {

	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}
	
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addProduct(Product product) throws Exception {
		productDao.insertProduct(product);
	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		String tranCode = purchaseDao.getTranCode(prodNo);
		Product product = productDao.findProduct(prodNo);
		if (tranCode != null) {
			if (tranCode.trim().equals("0")) {
				product.setProTranCode("판매중");
			} else if (tranCode.trim().equals("1")) {
				product.setProTranCode("구매완료");
			} else if (tranCode.trim().equals("2")) {
				product.setProTranCode("배송중");
			} else if (tranCode.trim().equals("3")) {
				product.setProTranCode("배송완료");
			}
		}
		return product;
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
		
		List<Product> list = productDao.getProductList(search);
		for (int i=0; i<list.size();i++) {
			String tranCode = purchaseDao.getTranCode(list.get(i).getProdNo());
			
			if (tranCode != null) {
				if (tranCode.trim().equals("0")) {
					list.get(i).setProTranCode("판매중");
				} else if (tranCode.trim().equals("1")) {
					list.get(i).setProTranCode("구매완료");
				} else if (tranCode.trim().equals("2")) {
					list.get(i).setProTranCode("배송중");
				} else if (tranCode.trim().equals("3")) {
					list.get(i).setProTranCode("배송완료");
				}
			}
		}
		
		int totalCount = productDao.getTotalCount(search);
		System.out.println(list);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		return map;
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);
	}

}
