package com.plat.service;

import com.plat.dao.AdminMapper;
import com.plat.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;
    public int login(String username, String password) {
        Admin admin = adminMapper.findByUsername(username);
        if(admin==null){
            return 0;
        }
        if(!admin.getPassword().equals(password)) {
            return 1;
        }
        return 2;
    }

    public Admin findByUsername(String username) {
        Admin admin = adminMapper.findByUsername(username);
        return admin;
    }
}
