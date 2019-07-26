package com.springmvc.dao;

import com.springmvc.entity.Ticket;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface TicketMapper {
    int deleteByPrimaryKey(Integer ticketid);

    int insert(Ticket record);

    int insertSelective(Ticket record);

    Ticket selectByPrimaryKey(Integer ticketid);

    ArrayList<Ticket> selectTicketsByUserId(Integer record);

    int updateByPrimaryKeySelective(Ticket record);

    int updateByPrimaryKey(Ticket record);

    ArrayList<Ticket> selectByFlightId(int record);
}