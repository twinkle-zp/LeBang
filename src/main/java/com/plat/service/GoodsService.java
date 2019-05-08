package com.plat.service;

import com.plat.entity.Goods;
import com.plat.entity.Message;
import com.plat.entity.Page;

import java.util.List;

public interface GoodsService {
    void add(Goods goods);

    Page findList(String currPage);

    Goods findById(Integer id);

    List<Message> findMessage(Integer goodId,Integer userId);

    void addMessage(Message message1);

    Page findMyGoods(String currPage, Integer uid);

    void delete(Integer id);

    List<Message> findMessageList(Integer uid);

    List<Message> findUserMessage(Integer goodId, Integer uid, Integer toUserId);
}
