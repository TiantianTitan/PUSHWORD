package com.pushwords.util;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class Page<T> {

    private Integer pageNum;
    private Integer pageSize;
    private long totalCount;

    private Integer totalPages;
    private Integer prePage;
    private Integer nextPage;

    private Integer startNavPage;
    private Integer endNavPage;

    private List<T> dataList;

    public Page(Integer pageNum, Integer pageSize, long totalCount) {
        this.pageNum = pageNum;
        this.pageSize = pageSize;
        this.totalCount = totalCount;

        this.totalPages = (int) Math.ceil(totalCount/(pageSize*1.0));
        this.prePage = Math.max(pageNum - 1, 1);
        this.nextPage = Math.min(pageNum + 1,totalPages);

        this.startNavPage = pageNum -5;
        this.endNavPage = pageNum + 4;

        if(startNavPage < 1){
            this.startNavPage = 1;
            this.endNavPage = Math.min(this.startNavPage + 9 ,totalPages);
        }
        if(endNavPage > totalPages){
            this.endNavPage = totalPages;
            this.startNavPage = Math.max(this.endNavPage - 9, 1);
        }

    }


}
