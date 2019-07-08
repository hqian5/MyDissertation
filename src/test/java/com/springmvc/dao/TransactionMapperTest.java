package com.springmvc.dao;

import com.springmvc.entity.Transaction;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TransactionMapperTest {

    private ApplicationContext applicationContext;

    @Autowired
    private TransactionMapper mapper;

    @Before
    public void setUp() throws Exception {
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        mapper = applicationContext.getBean(TransactionMapper.class);
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void insert() {
        Transaction transaction = new Transaction();
        transaction.setUserid(1);
        transaction.setFlightid(111);
        transaction.setTicketid(1);
        transaction.setTransCondition("abc");
        int result = mapper.insert(transaction);
        System.out.println(result);
        assert (result == 1);
    }
}