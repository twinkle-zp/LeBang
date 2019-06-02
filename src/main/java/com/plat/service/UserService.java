package com.plat.service;

import com.plat.entity.Page;
import com.plat.entity.User;

import java.util.List;

public interface UserService {
    User findByUsername(String username);

    boolean register(User user);

    int login(String username, String password);


    Page findListByAdmin(String currPage);

    void updateState(Integer uid, Integer state);

    void delete(Integer uid);

    void update(User user);
}
