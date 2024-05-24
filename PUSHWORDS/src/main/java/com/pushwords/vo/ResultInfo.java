package com.pushwords.vo;

/**
 * ResultInfo is a generic class used to encapsulate the result of an operation, including a status code, message, and result data.
 *
 * @param <T> the type of the result data
 */
public class ResultInfo<T> {
    private Integer code;
    private String msg;
    private T result;

    /**
     * Gets the status code of the operation.
     * Success is represented by 1, and failure is represented by 0.
     *
     * @return the status code
     */
    public Integer getCode() {
        return code;
    }

    /**
     * Sets the status code of the operation.
     *
     * @param code the status code
     */
    public void setCode(Integer code) {
        this.code = code;
    }

    /**
     * Gets the message associated with the operation.
     *
     * @return the message
     */
    public String getMsg() {
        return msg;
    }

    /**
     * Sets the message associated with the operation.
     *
     * @param msg the message
     */
    public void setMsg(String msg) {
        this.msg = msg;
    }

    /**
     * Gets the result data of the operation.
     *
     * @return the result data
     */
    public T getResult() {
        return result;
    }

    /**
     * Sets the result data of the operation.
     *
     * @param result the result data
     */
    public void setResult(T result) {
        this.result = result;
    }
}
