package com.pushwords.util;

import com.alibaba.fastjson.JSON;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * JsonUtil provides utility methods for converting objects to JSON and sending JSON responses.
 */
public class JsonUtil {

    /**
     * Converts an object to JSON and writes it to the HttpServletResponse.
     *
     * @param response the HttpServletResponse to write the JSON to
     * @param result the object to be converted to JSON
     */
    public static void toJson(HttpServletResponse response, Object result) {
        try {
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();

            String json = JSON.toJSONString(result);

            out.write(json);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Converts an object to a JSON string.
     *
     * @param object the object to be converted to JSON
     * @return the JSON string representation of the object
     */
    public static String jsonString(Object object) {
        return JSON.toJSONString(object);
    }
}
