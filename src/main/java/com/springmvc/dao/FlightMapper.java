package com.springmvc.dao;

import com.springmvc.entity.Flight;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface FlightMapper {
    int deleteByPrimaryKey(Integer flightid);

    int insert(Flight record);

    int insertSelective(Flight record);

    Flight selectByPrimaryKey(Integer flightid);

    ArrayList<Flight> selectFlight(String record);

    int updateByPrimaryKeySelective(Flight record);

    int updateByPrimaryKey(Flight record);

    ArrayList<Flight> selectByFlightNumber(Flight record);
}