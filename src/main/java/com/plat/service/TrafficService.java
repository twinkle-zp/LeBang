package com.plat.service;

import com.plat.entity.Page;
import com.plat.entity.Traffic;
import com.plat.entity.TrafficJoin;
import com.plat.entity.TrafficType;

import java.util.List;

public interface TrafficService {
    Page findList(String currPage);

    List<TrafficType> findType();

    int add(Traffic traffic);

    int insert(TrafficJoin trafficJoin);

    Page findMyList(String currPage, Integer uid);

    List<TrafficJoin> findCheckList(Integer tid);

    int update(TrafficJoin trafficJoin);

    List<TrafficJoin> findMyJoin(Integer uid);
}
