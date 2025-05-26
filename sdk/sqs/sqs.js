import { ReceiveMessageCommand, SQSClient, SendMessageCommand, DeleteMessageCommand } from "@aws-sdk/client-sqs";

const client = new SQSClient({});
const SQS_QUEUE_URL = "https://sqs.us-east-1.amazonaws.com/940482411315/tf-sqs-queue";

const sendMessage = async (message) => {
    const command = new SendMessageCommand({
        QueueUrl: SQS_QUEUE_URL,
        MessageBody: message
    });
    return await client.send(command);
}

const receivedMessages = async () => {
    const command = new ReceiveMessageCommand({
        QueueUrl: SQS_QUEUE_URL,
        MaxNumberOfMessages: 10,
        WaitTimeSeconds: 10
    })
    return await client.send(command);
}

const deleteMessage = async (message) => {
    const command = new DeleteMessageCommand({
        QueueUrl: SQS_QUEUE_URL,
        ReceiptHandle: message.ReceiptHandle
    })
    return await client.send(command);
}

export { sendMessage, receivedMessages, deleteMessage };