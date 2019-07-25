package com.springmvc.dao;

import com.springmvc.entity.Ticket;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;

import static org.junit.Assert.*;

public class TicketMapperTest {

    private ApplicationContext applicationContext;

    @Autowired
    private TicketMapper mapper;

    @Before
    public void setUp() throws Exception {
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        mapper = applicationContext.getBean(TicketMapper.class);
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void insert() {
        Ticket ticket = new Ticket();
        ticket.setFlightid(2);
        ticket.setUserid(2);
        int result = mapper.insert(ticket);
        System.out.println(result);
        assert (result == 1);
    }

    @Test
    public void selectTicketsByUserId() {
        int id = 21;
        ArrayList<Ticket> list = mapper.selectTicketsByUserId(id);
        for (Ticket t : list){
            System.out.println(t.getFlightid());
        }
    }
}