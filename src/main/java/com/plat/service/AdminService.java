package com.plat.service;

import com.plat.entity.Admin;

public interface AdminService {
    int login(String username, String password);

    Admin findByUsername(String username);
}
