package com.springmvc.dao;

import com.springmvc.entity.Client;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface ClientMapper {
    int deleteByPrimaryKey(Integer userid);

    int insert(Client record);

    int insertSelective(Client record);

    Client selectByPrimaryKey(Integer userid);

    int updateByPrimaryKeySelective(Client record);

    int updateByPrimaryKey(Client record);

    ArrayList<Client> selectSelective(Client record);

    ArrayList<Client> selectByUsername(Client record);
}