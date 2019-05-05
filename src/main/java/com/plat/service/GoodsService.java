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
}
