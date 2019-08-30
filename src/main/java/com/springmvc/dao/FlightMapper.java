package com.springmvc.dao;

import com.springmvc.entity.Flight;

import java.util.ArrayList;

public interface FlightMapper {
    int deleteByPrimaryKey(Integer flightid);

    int insert(Flight record);

    int insertSelective(Flight record);

    Flight selectByPrimaryKey(Integer flightid);

    int updateByPrimaryKeySelective(Flight record);

    int updateByPrimaryKey(Flight record);

    ArrayList<Flight> selectByFlightNumber(Flight record);

    ArrayList<Flight> selectFlight(String record);

    ArrayList<Flight> selectAllFlights();

    ArrayList<Flight> selectByDepartureAirport(String record);

    ArrayList<Flight> selectByDateAndAirports(Flight record);

}