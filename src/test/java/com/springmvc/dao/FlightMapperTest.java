package com.springmvc.dao;

import com.springmvc.entity.Flight;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;

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
        flight.setPrice(10);
        int result = mapper.insert(flight);
        System.out.println(result);
        assert (result == 1);

    }

    @Test
    public void selectByFlightNumber() {
        Flight flight = new Flight();
        flight.setFlightNumber("E222");
        ArrayList<Flight> list = mapper.selectByFlightNumber(flight);
        System.out.println(list.size());
        for (Flight f : list){
            System.out.println(f.getFlightNumber() + f.getDepartureTime());
        }
    }

    @Test
    public void selectAllFlights() {
        ArrayList<Flight> list = mapper.selectAllFlights();
        for (Flight f : list){
            System.out.println(f.getFlightNumber());
        }
    }

    @Test
    public void deleteByPrimaryKey() {
        int record = mapper.deleteByPrimaryKey(9);
        System.out.println(record);

    }

    @Test
    public void updateByPrimaryKeySelective() {
        Flight flight = new Flight();
        flight.setFlightid(8);
        flight.setFlightNumber("update");
        flight.setDepartureTime("b");
        flight.setDepartureAirport("c");
        flight.setArrivalTime("d");
        flight.setArrivalAirport("e");
        flight.setSeatNumber(50);
        flight.setSeatFree(20);
        flight.setPrice(10);
        int record = mapper.updateByPrimaryKeySelective(flight);
        System.out.println(record);
    }
}