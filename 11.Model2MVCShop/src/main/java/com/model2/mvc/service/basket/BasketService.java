package com.model2.mvc.service.basket;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Basket;

public interface BasketService {

	public void addBasket(Basket basket) throws Exception;
	
	public Basket getBasket(int basketNo) throws Exception;
	
	public Map<String, Object> getBasketList(Search search, String userId) throws Exception;
	
	public void deleteBasket(int basketNo) throws Exception;
	
	public void buyBasket(int basketNo) throws Exception;
	
}
