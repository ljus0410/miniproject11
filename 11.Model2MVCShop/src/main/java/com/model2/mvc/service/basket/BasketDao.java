package com.model2.mvc.service.basket;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Basket;

public interface BasketDao {

	public Basket findBasket(int basketNo) throws Exception;
	
	public void insertBasket(Basket basket) throws Exception;
	
	public void deleteBasket(int basketNo) throws Exception;
	
	public List<Basket> getBasketList(Map param) throws Exception;
	
	public int getTotalCount(String userId) throws Exception;
	
}
