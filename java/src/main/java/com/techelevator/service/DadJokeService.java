package com.techelevator.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;



public class DadJokeService {

    private RestTemplate restTemplate = new RestTemplate();

    public final String API_URL = "https://icanhazdadjoke.com";
    public String getDadJoke(){
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Accept", "text/plain");

        HttpEntity<String> entity = new HttpEntity<>(httpHeaders);
        ResponseEntity<String> response = restTemplate.exchange(API_URL, HttpMethod.GET, entity, String.class);
        return response.getBody();
    }
}
