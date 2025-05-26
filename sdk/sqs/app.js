import { receivedMessages, sendMessage, deleteMessage } from "./sqs.js";

const main = async () => {
    //let response = await sendMessage("Hello from SQS!");
    //console.log("Response: ", response);

    for(let count=0; count < 1; count++) {
      let response = await receivedMessages();
      if (response.Messages) {
        console.log("Mensagens retornadas:", response.Messages?.length); 
        //console.log("Received Messages: ", response.Messages);
        for(const message of response.Messages) {
            console.log("Deleting message: ", message.MessageId);
            let responseD = await deleteMessage(message);
            console.log("Response: ", responseD);
        }
      } else {
        console.log("No messages received.");
      }
    }
};
main()

