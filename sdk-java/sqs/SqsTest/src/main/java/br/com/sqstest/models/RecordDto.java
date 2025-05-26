package br.com.sqstest.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.ToString;

@ToString()
@JsonIgnoreProperties(ignoreUnknown = true)
public class RecordDto {
    @JsonProperty("eventVersion")
    private String version;

    @JsonProperty("eventSource")
    private String source;

    @JsonProperty("eventName")
    private String eventName;

    @JsonProperty("s3")
    private S3Dto s3Event;
}
