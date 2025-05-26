package br.com.sqstest.classes;

import br.com.sqstest.models.EventDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.awspring.cloud.sqs.annotation.SqsListener;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class SqsService {
    ObjectMapper objectMapper = new ObjectMapper();

    @SqsListener("tf-sqs-queue")
    public void receiveMessage(String message) throws JsonProcessingException {
        System.out.println("Message Received");
        System.out.println(message);

        EventDto event = objectMapper.readValue(message, EventDto.class);
        System.out.println(event.toString());
    }
}
