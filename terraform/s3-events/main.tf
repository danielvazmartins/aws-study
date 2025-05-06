## SNS ###
resource "aws_sns_topic" "tf_envia_email" {
  name = "tf-envia-email"
  policy = data.aws_iam_policy_document.tf_policy_bucket_sns.json
}

resource "aws_sns_topic_subscription" "tf_subscription_email" {
  topic_arn = aws_sns_topic.tf_envia_email.arn
  protocol  = "email"
  endpoint  = "danielvazmartins@gmail.com"
}

### Bucket S3 ###
resource "aws_s3_bucket" "tf_bucket" {
	bucket = "tf-bucket-notify"
}

resource "aws_s3_bucket_notification" "tf_bucket_notification" {
	bucket = aws_s3_bucket.tf_bucket.id

	# SNS notification configuration
	topic {
		topic_arn = aws_sns_topic.tf_envia_email.arn
		events    = ["s3:ObjectCreated:*"]
	}
}