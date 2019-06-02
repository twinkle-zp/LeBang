package com.plat.service;

import com.plat.dao.UserMapper;
import com.plat.entity.Page;
import com.plat.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.UUID;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    public User findByUsername(String username) {
        User user = userMapper.findByUsername(username);
        return user;
    }

    public boolean register(User user) {
        boolean result = false;
        //user.setUid(UUID.randomUUID().toString().replaceAll("-", ""));

        //设置激活码
        String code = UUID.randomUUID().toString().replaceAll("-", "");
        user.setCode(code);
        //设置状态
        user.setState(0);

        userMapper.insert(user);

        //TODO 发送激活邮件
        //MailUtils.sendMail(user.getEmail(),code);

        result = true;

        return result;
    }

    public int login(String username, String password) {
        User user = userMapper.findByUsername(username);
        if(user==null){
            return 0;
        }
        if(!user.getPassword().equals(password)) {
            return 1;
        }
        return 2;

    }

    public Page findListByAdmin(String currPage) {
        if(currPage==null)
        {
            currPage = "1";
        }
        Page result = new Page();
        int totalCount = userMapper.getAllCount();

        result.setTotalCount(totalCount);
        result.setCurrPage(Integer.valueOf(currPage));

        List<User> list = userMapper.findAllPage(result.getBeginRows(),result.getPageSize());
        result.setList(list);
        return result;
    }

    public void updateState(Integer uid, Integer state) {
        User user = new User();
        user.setUid(uid);
        if(state==0){
            user.setState(1);
            userMapper.updateByPrimaryKeySelective(user);
        }
        else
        {
            user.setState(0);
            userMapper.updateByPrimaryKeySelective(user);
        }
    }

    public void delete(Integer uid) {
        userMapper.deleteByPrimaryKey(uid);
    }

    public void update(User user) {
        userMapper.updateByPrimaryKeySelective(user);
    }


}
