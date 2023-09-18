package com.model2.mvc.service.purchase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {

	public void insertPurchase(Purchase purchase) throws Exception;
	
	public Purchase findPurchase(int prodNo) throws Exception;
	
	public List<Purchase> getPurchaseList(Map param) throws Exception;
	
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
	public String getTranCode(int prodNo) throws Exception;
	
	public int getTotalCount(String userId) throws Exception;
	
}
