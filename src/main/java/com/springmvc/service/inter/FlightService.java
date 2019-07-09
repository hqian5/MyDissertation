package com.springmvc.service.inter;

import com.springmvc.entity.Flight;

import java.util.ArrayList;

public interface FlightService {
    int insert(Flight record);

    ArrayList<Flight> selectByFlightNumber(Flight record);

    ArrayList<Flight> selectFlight(String record);
}
