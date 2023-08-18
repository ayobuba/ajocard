resource "aws_cloudwatch_event_rule" "asg_term_rule" {
  name = "${var.sqs_que_prefix}-ASGTermRule"
  description = "Capture all Instance-terminate lifecycle action"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.autoscaling"
  ],
  "detail-type": [
    "EC2 Instance-terminate Lifecycle Action"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_rule" "ec2_term_rule" {
  name        = "${var.sqs_que_prefix}-EC2TermRule"
  description = "Capture all EC2 scaling events"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.ec2"
  ],
  "detail-type": [
    "EC2 Spot Instance Interruption Warning",
    "EC2 Instance Rebalance Recommendation",
    "EC2 Instance State-change Notification"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_rule" "health_term_rule" {
  name = "${var.sqs_que_prefix}-ScheduledChangeRule"
  description = "Capture all Instance-terminate lifecycle action"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.health"
  ],
  "detail-type": [
    "AWS Health Event"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "asg_termination_rule" {
  arn  = aws_sqs_queue.sc_stg_us_termination_events_queue.arn
  rule = aws_cloudwatch_event_rule.asg_term_rule.name
  target_id = "ASG-Termination-Rule"
}

resource "aws_cloudwatch_event_target" "ec2_termination_rule" {
  arn  = aws_sqs_queue.sc_stg_us_termination_events_queue.arn
  rule = aws_cloudwatch_event_rule.ec2_term_rule.name
  target_id = "EC2-Spot-Instance-Termination"
}

resource "aws_cloudwatch_event_target" "health_termination_rule" {
  arn  = aws_sqs_queue.sc_stg_us_termination_events_queue.arn
  rule = aws_cloudwatch_event_rule.health_term_rule.name
  target_id = "Health-Event-Change"
}