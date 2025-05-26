resource "aws_sqs_queue" "tf_sqs_queue" {
  name                        = "tf-sqs-queue"
  delay_seconds               = 0
  max_message_size            = 2048
  message_retention_seconds   = 86400
  receive_wait_time_seconds   = 10
  visibility_timeout_seconds  = 0

  tags = {
    Environment = "study"
  }
}