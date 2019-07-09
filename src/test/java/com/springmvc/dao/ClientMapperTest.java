package com.springmvc.dao;

import com.springmvc.entity.Client;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;

import static org.junit.Assert.*;

public class ClientMapperTest {

    private ApplicationContext applicationContext;

    @Autowired
    private ClientMapper clientMapper;

    @Before
    public void setUp() throws Exception {
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        clientMapper = applicationContext.getBean(ClientMapper.class);
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void insert() {
        Client client = new Client();
        client.setUserid(1);
        client.setUsername("tom");
        client.setPassword("abc");
        client.setRealname("c");
        client.setPassport("d");
        client.setEmail("e");
        client.setPhone("123");
        client.setPreference("cheap");
        int result = clientMapper.insert(client);
        System.out.println(result);
        assert (result == 1);
    }

    @Test
    public void selectSelective() {
        Client client = new Client();
        client.setUsername("tom");
        client.setPassword("abc");
        ArrayList<Client> arrayList = clientMapper.selectSelective(client);
        for (Client c : arrayList){
            System.out.println(c.getUsername() + ": " + c.getPassword());
        }
    }

    @Test
    public void selectByUsername() {
        Client client = new Client();
        client.setUsername("tom");
        ArrayList<Client> list = clientMapper.selectByUsername(client);
        for (Client c : list){
            System.out.println(c.getUsername() + ": " + c.getRealname());
        }
    }
}