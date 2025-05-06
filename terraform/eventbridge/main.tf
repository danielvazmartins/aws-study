resource "aws_scheduler_schedule" "tf_eventbridge_schedule" {
  name       = "tf-eventbridge-schedule"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(1 minute)"

  target {
    arn      = "arn:aws:sns:us-east-1:940482411315:tf-envia-email"
    role_arn = aws_iam_role.tf_eventbridge_schedule_role.arn

    input = jsonencode({
        "Message": "Hello from EventBridge Scheduler!"
    })
  }
}

resource "aws_iam_role" "tf_eventbridge_schedule_role" {
    name = "TFEventBridgeRole"
    description = "Role for EventBridge Scheduler to send SNS notifications"
    assume_role_policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "scheduler.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_policy" "tf_eventbridge_schedule_policy" {
    name        = "TFEventBridgePolicy"
    description = "Policy for EventBridge Scheduler to send SNS notifications"
    policy      = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "sns:Publish"
                ],
                "Resource": "*"
            }
        ]
    })
}

resource "aws_iam_policy_attachment" "tf_eventbridge_schedule_policy_attachment" {
    name       = "TFEventBridgePolicyAttachment"
    roles       = [ aws_iam_role.tf_eventbridge_schedule_role.name ]
    policy_arn = aws_iam_policy.tf_eventbridge_schedule_policy.arn
}