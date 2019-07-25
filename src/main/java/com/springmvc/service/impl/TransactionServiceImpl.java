package com.springmvc.service.impl;

import com.springmvc.dao.TransactionMapper;
import com.springmvc.entity.Transaction;
import com.springmvc.service.inter.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TransactionServiceImpl implements TransactionService {

    @Autowired
    private TransactionMapper mapper;

    public int insert(Transaction record) {
        return mapper.insert(record);
    }
}
