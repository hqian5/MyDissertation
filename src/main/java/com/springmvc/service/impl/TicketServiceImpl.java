package com.springmvc.service.impl;

import com.springmvc.dao.TicketMapper;
import com.springmvc.entity.Ticket;
import com.springmvc.service.inter.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class TicketServiceImpl implements TicketService {

    @Autowired
    private TicketMapper mapper;

    public int insert(Ticket record) {
        return mapper.insert(record);
    }

    public Ticket selectByPrimaryKey(Integer ticketid) {
        return mapper.selectByPrimaryKey(ticketid);
    }

    public ArrayList<Ticket> selectTicketsByUserId(Integer record) {
        return mapper.selectTicketsByUserId(record);
    }
}
