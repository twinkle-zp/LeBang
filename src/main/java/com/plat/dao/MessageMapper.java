package com.plat.dao;

import com.plat.entity.Message;

import java.util.List;

public interface MessageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Message record);

    int insertSelective(Message record);

    Message selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Message record);

    int updateByPrimaryKey(Message record);

    List<Message> findList(Integer good_id, Integer user_id);

    List<Message> findMessageList(Integer uid);

    List<Message> findUserMessage(Integer goodId, Integer uid, Integer toUserId);
}