package com.plat.util;

import com.plat.entity.Message;

import java.util.ArrayList;
import java.util.List;

public class MessageUtils {

    public List<Message> removeDuplicate(List<Message> messageList,Integer uid){
        List<Message> newMessageList = new ArrayList<Message>();
        List<String> newList = new ArrayList<String>();
        for(Message m :messageList){   //遍历，将对方用户id存入toUserID字段
            if(m.getToId()==uid){
                m.setToUserId(m.getFromId());
            }
            else{
                m.setToUserId(m.getToId());
            }
            if(!newList.contains(""+m.getToUserId())){ //根据toUserID字段进行去重
                newList.add(""+m.getToUserId());
                newMessageList.add(m);
            }
        }
        return newMessageList;
    }
}
