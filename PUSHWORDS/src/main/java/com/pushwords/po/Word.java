package com.pushwords.po;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Word {


    private Integer wordId;
    private String title;
    private  String content;
    private Integer groupId;
    private Date pubTime;


}
