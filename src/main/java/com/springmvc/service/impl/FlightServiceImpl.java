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
}
