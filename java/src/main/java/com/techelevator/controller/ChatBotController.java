package com.techelevator.controller;

import com.techelevator.model.FastApiRequest;
import com.techelevator.model.QuestionRequestModel;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.client.RestTemplate;

@RestController
@CrossOrigin
@PreAuthorize("isAuthenticated()")
public class ChatBotController {


    RestTemplate restTemplate = new RestTemplate();

    @PostMapping("/ask")
    public String askQuestion(@RequestBody QuestionRequestModel request,
                              @RequestHeader("Authorization") String authorizationHeader) {

        String session_id = request.getSession_id();
        String question = request.getQuestion();

        if (session_id == null || session_id.isEmpty()) {
            session_id = authorizationHeader;
        }

        String fastApiUrl = "http://localhost:8000/ask"; // URL of your FastAPI service
        FastApiRequest fastApiRequest = new FastApiRequest(question, session_id);

        System.out.println("Request to FastAPI: " + fastApiRequest);

        String responseFromFastApi = restTemplate.postForObject(fastApiUrl, fastApiRequest, String.class);

        return responseFromFastApi;
    }
}
