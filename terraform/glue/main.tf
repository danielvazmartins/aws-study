resource "aws_glue_job" "tf_glue_job" {
  name = "tf-glue-job"
	role_arn = aws_iam_role.tf_glue_role.arn
	command {
		script_location = "s3://tf-bucket-glue/main.py"
	}
}

resource "aws_iam_role" "tf_glue_role" {
  name = "TFGlueRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "TFGlueRole"
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "tf_glue_policy" {
  name = "TFGluePolicy"
  roles = [ aws_iam_role.tf_glue_role.name ]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}