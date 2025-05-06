## SNS Policy ###
data "aws_iam_policy_document" "tf_policy_bucket_sns" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["SNS:Publish"]
    resources = ["arn:aws:sns:*:*:tf-envia-email"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.tf_bucket.arn]
    }
  }
}