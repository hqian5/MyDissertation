package com.springmvc.dao;

import com.springmvc.entity.Flight;
import org.springframework.stereotype.Repository;

@Repository
public interface FlightMapper {
    int deleteByPrimaryKey(Integer flightid);

    int insert(Flight record);

    int insertSelective(Flight record);

    Flight selectByPrimaryKey(Integer flightid);

    int updateByPrimaryKeySelective(Flight record);

    int updateByPrimaryKey(Flight record);
}