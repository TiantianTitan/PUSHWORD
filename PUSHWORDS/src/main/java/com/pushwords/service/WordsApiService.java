package com.pushwords.service;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class WordsApiService {
    private static final String API_URL = "https://wordsapiv1.p.rapidapi.com/words/";
    private static final String API_KEY = "4eca314a24msh01ca7c7cc4be4e7p143556jsn5318d093a358"; // 替换为你的 API 密钥

    public List<String> translateWord(String word) throws IOException {
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpGet request = new HttpGet(API_URL + word + "/definitions");
        request.addHeader("x-rapidapi-key", API_KEY);
        request.addHeader("x-rapidapi-host", "wordsapiv1.p.rapidapi.com");

        try (CloseableHttpResponse response = httpClient.execute(request)) {
            int statusCode = response.getStatusLine().getStatusCode();
            System.out.println("API Response Status Code: " + statusCode);

            if (statusCode == 200) {
                String result = EntityUtils.toString(response.getEntity());
                System.out.println("API Response: " + result);
                return extractDefinitions(result);
            } else {
                String errorResponse = EntityUtils.toString(response.getEntity());
                System.err.println("API Error Response: " + errorResponse);
                throw new IOException("Error: " + statusCode);
            }
        }
    }

    private List<String> extractDefinitions(String jsonString) {
        List<String> definitions = new ArrayList<>();
        String startMarker = "\"definition\":\"";
        String endMarker = "\"";

        int startIndex = 0;
        while ((startIndex = jsonString.indexOf(startMarker, startIndex)) != -1) {
            startIndex += startMarker.length();
            int endIndex = jsonString.indexOf(endMarker, startIndex);
            if (endIndex != -1) {
                String definition = jsonString.substring(startIndex, endIndex);
                definitions.add(definition);
                startIndex = endIndex + endMarker.length();
            } else {
                break;
            }
        }

        return definitions;
    }
}
