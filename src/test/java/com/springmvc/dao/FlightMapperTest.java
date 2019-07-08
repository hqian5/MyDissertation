package com.springmvc.dao;

import com.springmvc.entity.Flight;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.math.BigDecimal;

public class FlightMapperTest {

    private ApplicationContext applicationContext;

    @Autowired
    private FlightMapper mapper;

    @Before
    public void setUp() throws Exception {
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        mapper = applicationContext.getBean(FlightMapper.class);
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void insert() {
        Flight flight = new Flight();
        flight.setFlightNumber("a");
        flight.setDepartureTime("b");
        flight.setDepartureAirport("c");
        flight.setArrivalTime("d");
        flight.setArrivalAirport("e");
        flight.setSeatNumber(50);
        flight.setSeatFree(20);
        flight.setPrice(BigDecimal.valueOf(10.00));
        int result = mapper.insert(flight);
        System.out.println(result);
        assert (result == 1);

    }
}