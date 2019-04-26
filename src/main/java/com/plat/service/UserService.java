package com.plat.service;

import com.plat.entity.User;

public interface UserService {
    User findByUsername(String username);

    boolean register(User user);

    int login(String username, String password);
}
