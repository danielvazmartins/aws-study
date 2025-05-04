resource "aws_sns_topic" "tf_envia_email" {
  name = "tf-envia-email"
}

resource "aws_sns_topic_subscription" "tf_subscription_email" {
  topic_arn = aws_sns_topic.tf_envia_email.arn
  protocol  = "email"
  endpoint  = "danielvazmartins@gmail.com"
}