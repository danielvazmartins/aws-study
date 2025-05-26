package br.com.sqstest.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.ToString;

import java.util.List;

@ToString()
@JsonIgnoreProperties(ignoreUnknown = true)
public class EventDto {
    @JsonProperty("Records")
    private List<RecordDto> records;
}
