package com.springmvc.service.inter;

import com.springmvc.entity.Client;

import java.util.ArrayList;

public interface ClientService {

    int insert(Client record);

    ArrayList<Client> selectSelective(Client record);

    ArrayList<Client> selectByUsername(Client record);

    Client selectByPrimaryKey(Integer userid);
}
