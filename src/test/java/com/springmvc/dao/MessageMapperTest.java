package com.springmvc.dao;

import com.springmvc.entity.Message;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import static org.junit.Assert.*;

public class MessageMapperTest {

    private ApplicationContext applicationContext;

    @Autowired
    private MessageMapper messageMapper;

    @Before
    public void setUp() throws Exception {
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        messageMapper = applicationContext.getBean(MessageMapper.class);
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void insert() {
        Message message = new Message();
        message.setCommand("aa");
        message.setContent("bb");
        message.setDescription("cc");
        int result = messageMapper.insert(message);
        System.out.println(result);
        assert (result == 1);
    }

}