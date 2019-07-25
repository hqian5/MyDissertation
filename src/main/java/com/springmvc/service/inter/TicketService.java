package com.springmvc.service.inter;

import com.springmvc.entity.Ticket;

import java.util.ArrayList;

public interface TicketService {
    int insert(Ticket record);

    Ticket selectByPrimaryKey(Integer ticketid);

    ArrayList<Ticket> selectTicketsByUserId(Integer record);
}
