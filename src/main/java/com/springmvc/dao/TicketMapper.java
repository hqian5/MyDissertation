package com.springmvc.dao;

import com.springmvc.entity.Ticket;
import org.springframework.stereotype.Repository;

@Repository
public interface TicketMapper {
    int deleteByPrimaryKey(Integer ticketid);

    int insert(Ticket record);

    int insertSelective(Ticket record);

    Ticket selectByPrimaryKey(Integer ticketid);

    int updateByPrimaryKeySelective(Ticket record);

    int updateByPrimaryKey(Ticket record);
}