package com.model2.mvc.service.basket.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.basket.BasketDao;
import com.model2.mvc.service.basket.BasketService;
import com.model2.mvc.service.domain.Basket;

@Service("basketServiceImpl")
public class BasketServiceImpl implements BasketService {

	@Autowired
	@Qualifier("basketDaoImpl")
	private BasketDao basketDao;
	
	public void setBasketDao(BasketDao basketDao) {
		this.basketDao = basketDao;
	}
	public BasketServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addBasket(Basket basket) throws Exception {
		basketDao.insertBasket(basket);
	}

	@Override
	public Basket getBasket(int basketNo) throws Exception {
		return basketDao.findBasket(basketNo);
	}

	@Override
	public Map<String, Object> getBasketList(Search search, String userId) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		param.put("searchKeyword", search.getSearchKeyword());
		param.put("endRowNum", search.getEndRowNum());
		param.put("startRowNum", search.getStartRowNum());
		param.put("userId", userId);
		System.out.println(param);
		List<Basket> list = basketDao.getBasketList(param);
		int totalCount = basketDao.getTotalCount(userId);
		
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		return map;
	}

	@Override
	public void deleteBasket(int basketNo) throws Exception {
		basketDao.deleteBasket(basketNo);
	}

	@Override
	public void buyBasket(int basketNo) throws Exception {
		
	}

}
