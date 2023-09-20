package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		this.purchaseDao = purchaseDao;
	}
	
	public PurchaseServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addPurchase(Purchase purchase) throws Exception {
		int purchaseCount = purchase.getPurchaseCount();
		int productCount = purchase.getPurchaseProd().getProdCount();
		int sum = productCount - purchaseCount;
		purchase.getPurchaseProd().setProdCount(sum);
		
		Product product = purchase.getPurchaseProd();

		productDao.updateProductCount(product);
		System.out.println("여기");
		purchaseDao.insertPurchase(purchase);
	}

	@Override
	public Purchase getPurchase(int prodNo) throws Exception {
		return purchaseDao.findPurchase(prodNo);
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search, User user) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		param.put("searchKeyword", search.getSearchKeyword());
		param.put("endRowNum", search.getEndRowNum());
		param.put("startRowNum", search.getStartRowNum());
		param.put("userId", user.getUserId());
		
		List<Purchase> list = purchaseDao.getPurchaseList(param);
		
		for (int i=0; i<list.size();i++) {
			String tranCode = purchaseDao.getTranCode(list.get(i).getPurchaseProd().getProdNo());
			
			if (tranCode != null) {
				if (tranCode.trim().equals("0")) {
					list.get(i).getPurchaseProd().setProTranCode("판매중");
				} else if (tranCode.trim().equals("1")) {
					list.get(i).getPurchaseProd().setProTranCode("구매완료");
				} else if (tranCode.trim().equals("2")) {
					list.get(i).getPurchaseProd().setProTranCode("배송중");
				} else if (tranCode.trim().equals("3")) {
					list.get(i).getPurchaseProd().setProTranCode("배송완료");
				}
			}
		}
		int totalCount = purchaseDao.getTotalCount(user.getUserId());
		System.out.println(list);
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		purchaseDao.updateTranCode(purchase);
	}

	@Override
	public String getTranCode(int prodNo) throws Exception {
		return purchaseDao.getTranCode(prodNo);
	}

}
