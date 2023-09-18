package com.model2.mvc.service.basket.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.basket.BasketDao;
import com.model2.mvc.service.domain.Basket;

@Repository("basketDaoImpl")
public class BasketDaoImpl implements BasketDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public BasketDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public Basket findBasket(int basketNo) throws Exception {
		return sqlSession.selectOne("BasketMapper.getBasket", basketNo);
	}

	@Override
	public void insertBasket(Basket basket) throws Exception {
		sqlSession.insert("BasketMapper.insertBasket",basket);
	}

	@Override
	public void deleteBasket(int basketNo) throws Exception {
		sqlSession.delete("BasketMapper.deleteBasket", basketNo);
	}

	@Override
	public List<Basket> getBasketList(Map param) throws Exception {
		return sqlSession.selectList("BasketMapper.getBasketList", param);
	}

	@Override
	public int getTotalCount(String userId) throws Exception {
		return sqlSession.selectOne("BasketMapper.getTotalCount", userId);
	}

}
