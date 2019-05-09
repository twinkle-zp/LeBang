package com.plat.service;

import com.plat.entity.Activity;
import com.plat.entity.ActivityCategory;
import com.plat.entity.ActivityJoin;
import com.plat.entity.Page;

import java.util.List;

public interface ActivityService {
    List<ActivityCategory> findAll();

    void add(Activity activity);

    Page findList(String currPage);

    void join(ActivityJoin activityJoin);

    List<ActivityJoin> findMyJoin(Integer uid);

    List<Activity> findMyActivity(Integer uid);

    List<ActivityJoin> findJoinList(Integer aid);//查找当前活动对应的报名列表

    void check(Integer state,Integer activityJoinId);
}
