resource "aws_iam_policy" "aws_load_balancer_controller_policy" {
  name = "aws-load-balancer-controller-policy-APIGWDEMO"
  policy = file("api-gateway-integration-eks/iam_policy.json")
}

# Create IAM role
resource "aws_iam_role" "alb-ingress-controller-role" {
  name = "alb-ingress-controller"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_openid_connect_provider.oidc.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${replace(aws_iam_openid_connect_provider.oidc.url, "https://", "")}:sub": "system:serviceaccount:kube-system:alb-ingress-controller",
          "${replace(aws_iam_openid_connect_provider.oidc.url, "https://", "")}:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
POLICY

  depends_on = [aws_iam_openid_connect_provider.oidc]

  tags = {
    "ServiceAccountName" = "alb-ingress-controller"
    "ServiceAccountNameSpace" = "kube-system"
  }
}

output "alb-ingress-controller-role-ARN" {
  value = aws_iam_role.alb-ingress-controller-role.arn
}

# Attach policies to IAM role
resource "aws_iam_role_policy_attachment" "alb-ingress-controller-role-ALBIngressControllerIAMPolicy" {
  policy_arn = aws_iam_policy.aws_load_balancer_controller_policy.arn
  role       = aws_iam_role.alb-ingress-controller-role.name
  depends_on = [aws_iam_role.alb-ingress-controller-role]
}

resource "aws_iam_role_policy_attachment" "alb-ingress-controller-role-AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.alb-ingress-controller-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  depends_on = [aws_iam_role.alb-ingress-controller-role]
}