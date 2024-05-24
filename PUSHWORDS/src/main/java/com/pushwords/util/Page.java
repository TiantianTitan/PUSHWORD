package com.pushwords.util;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * Page represents a paginated list of results.
 *
 * @param <T> the type of the results in the page
 */
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

    /**
     * Constructs a Page object with pagination details.
     *
     * @param pageNum the current page number
     * @param pageSize the number of items per page
     * @param totalCount the total number of items
     */
    public Page(Integer pageNum, Integer pageSize, long totalCount) {
        this.pageNum = pageNum;
        this.pageSize = pageSize;
        this.totalCount = totalCount;

        // Calculate the total number of pages
        this.totalPages = (int) Math.ceil(totalCount / (pageSize * 1.0));

        // Calculate previous and next page numbers
        this.prePage = Math.max(pageNum - 1, 1);
        this.nextPage = Math.min(pageNum + 1, totalPages);

        // Calculate the navigation start and end pages
        this.startNavPage = pageNum - 5;
        this.endNavPage = pageNum + 4;

        if (startNavPage < 1) {
            this.startNavPage = 1;
            this.endNavPage = Math.min(this.startNavPage + 9, totalPages);
        }
        if (endNavPage > totalPages) {
            this.endNavPage = totalPages;
            this.startNavPage = Math.max(this.endNavPage - 9, 1);
        }
    }
}
