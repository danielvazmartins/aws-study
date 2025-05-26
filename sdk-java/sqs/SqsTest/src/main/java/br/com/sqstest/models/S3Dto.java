package br.com.sqstest.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.ToString;

@ToString()
@JsonIgnoreProperties(ignoreUnknown = true)
public class S3Dto {
    @JsonProperty("bucket")
    private Object bucket;
    @JsonProperty("object")
    private Object object;
}
