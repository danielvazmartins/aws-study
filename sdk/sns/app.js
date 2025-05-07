import { PublishCommand, SNSClient } from "@aws-sdk/client-sns";

// The AWS Region can be provided here using the `region` property. If you leave it blank
// the SDK will default to the region set in your AWS config.
const snsClient = new SNSClient({});

const message = "Mensagem enviada via SDK";
const topicArn = "arn:aws:sns:us-east-1:940482411315:tf-envia-email";

const publishMessage = async (message, topicArn) => {
    return await snsClient.send(new PublishCommand({
        Message: message,
        TopicArn: topicArn
    }))
}

const response = await publishMessage(message, topicArn);
console.log("Response: ", response);
console.log("Message sent. Message ID: ", response.MessageId);
