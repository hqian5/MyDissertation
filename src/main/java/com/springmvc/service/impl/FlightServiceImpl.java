package com.springmvc.service.impl;

import com.springmvc.dao.FlightMapper;
import com.springmvc.entity.Flight;
import com.springmvc.service.inter.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class FlightServiceImpl implements FlightService {

    @Autowired
    private FlightMapper mapper;

    public int insert(Flight record) {
        return mapper.insert(record);
    }

    public ArrayList<Flight> selectByFlightNumber(Flight record) {
        return mapper.selectByFlightNumber(record);
    }

    public ArrayList<Flight> selectFlight(String record) {
        return mapper.selectFlight(record);
    }

    public ArrayList<Flight> selectAllFlights() {
        return mapper.selectAllFlights();
    }

    public int deleteByPrimaryKey(Integer flightid) {
        return mapper.deleteByPrimaryKey(flightid);
    }

    public Flight selectByPrimaryKey(Integer flightid) {
        return mapper.selectByPrimaryKey(flightid);
    }

    public int updateByPrimaryKeySelective(Flight record) {
        return mapper.updateByPrimaryKeySelective(record);
    }

    public ArrayList<Flight> selectByDepartureAirport(String record) {
        return mapper.selectByDepartureAirport(record);
    }

    public ArrayList<Flight> selectByDateAndAirports(Flight record) {
        return mapper.selectByDateAndAirports(record);
    }
}
