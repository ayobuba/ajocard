export AGW_AWS_REGION=eu-west-3
export AGW_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text --profile psirs-cloud-admin)
export AGW_EKS_CLUSTER_NAME=CPP_Ut

curl curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.0/docs/install/iam_policy.json \
     --output iam_policy.json