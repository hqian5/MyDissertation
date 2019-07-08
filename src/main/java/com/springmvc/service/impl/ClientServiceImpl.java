package com.springmvc.service.impl;

import com.springmvc.dao.ClientMapper;
import com.springmvc.entity.Client;
import com.springmvc.service.inter.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class ClientServiceImpl implements ClientService {

    @Autowired
    private ClientMapper mapper;

    public int insert(Client record){
        return mapper.insert(record);
    }

    public ArrayList<Client> selectSelective(Client record) {
        return mapper.selectSelective(record);
    }

    public ArrayList<Client> selectByUsername(Client record) { return mapper.selectByUsername(record); }
}
