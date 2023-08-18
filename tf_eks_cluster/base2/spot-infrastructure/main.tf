resource "aws_autoscaling_lifecycle_hook" "sc_stg_us" {
  //for_each = toset(local.asg_names)
  autoscaling_group_name = var.aws_autoscaling_group_name
  #autoscaling_group_name = data.aws_autoscaling_group.sc_stg_us.name
  lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                 = "${var.sqs_que_prefix}-hook"
  default_result       = "CONTINUE"
  heartbeat_timeout    = 300
}

resource "aws_sqs_queue" "sc_stg_us_termination_events_queue" {
  name                      = "${var.sqs_que_prefix}-termination-events-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = "production"
  }
}

resource "aws_sqs_queue_policy" "policy" {
  queue_url = aws_sqs_queue.sc_stg_us_termination_events_queue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [{
    "Effect": "Allow",
    "Principal": {
      "Service": ["events.amazonaws.com", "sqs.amazonaws.com"]
    },
    "Action": "sqs:SendMessage",
    "Resource": [
      "arn:aws:sqs:${var.aws_region}:${var.aws_account_id}:${aws_sqs_queue.sc_stg_us_termination_events_queue.name}"
    ]
  }]
}
POLICY
}



