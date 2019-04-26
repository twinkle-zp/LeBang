package com.plat.service;

import com.plat.entity.Goods;
import com.plat.entity.Page;

public interface GoodsService {
    void add(Goods goods);

    Page findList(String currPage);

    Goods findById(Integer id);
}
