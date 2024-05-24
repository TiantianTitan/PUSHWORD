package com.pushwords.service;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * WordsApiService provides methods to interact with the WordsAPI to get word definitions.
 */
public class WordsApiService {
    private static final String API_URL = "https://wordsapiv1.p.rapidapi.com/words/";
    private static final String API_KEY = "4eca314a24msh01ca7c7cc4be4e7p143556jsn5318d093a358";

    /**
     * Translates a word by fetching its definitions from the WordsAPI.
     *
     * @param word the word to be translated
     * @return a list of maps containing the definitions of the word
     * @throws IOException if there is an error while making the API request
     */
    public List<Map<String, String>> translateWord(String word) throws IOException {
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpGet request = new HttpGet(API_URL + word + "/definitions");
        request.addHeader("x-rapidapi-key", API_KEY);
        request.addHeader("x-rapidapi-host", "wordsapiv1.p.rapidapi.com");

        try (CloseableHttpResponse response = httpClient.execute(request)) {
            int statusCode = response.getStatusLine().getStatusCode();
            if (statusCode == 200) {
                String result = EntityUtils.toString(response.getEntity());
                return extractDefinitions(result);
            } else {
                throw new IOException("Error: " + statusCode);
            }
        }
    }

    /**
     * Extracts definitions from the JSON response.
     *
     * @param jsonString the JSON response as a string
     * @return a list of maps containing the definitions
     */
    private List<Map<String, String>> extractDefinitions(String jsonString) {
        List<Map<String, String>> definitions = new ArrayList<>();
        JSONObject json = new JSONObject(jsonString);
        JSONArray definitionsArray = json.getJSONArray("definitions");

        for (int i = 0; i < definitionsArray.length(); i++) {
            JSONObject definitionObj = definitionsArray.getJSONObject(i);
            Map<String, String> definition = new HashMap<>();
            definition.put("definition", definitionObj.getString("definition"));
            definitions.add(definition);
        }

        return definitions;
    }
}
