#export AGW_AWS_REGION=eu-west-1
#export SC_AWS_REGION=us-east-1
#export AGW_ACCOUNT_ID=$(aws sts get-caller-identity --query 'ACCOUNT' --output text --profile psirs-cloud-admin)
#export AGW_EKS_CLUSTER_NAME=CPP-Ut
#export SC_EKS_CLUSTER_NAME=sc-stg-cluster
#export AGW_PROFILE=psirs-cloud-admin

#eksctl utils associate-iam-oidc-provider --region $AGW_AWS_REGION --cluster $AGW_EKS_CLUSTER_NAME --profile $AGW_PROFILE
#eksctl utils associate-iam-oidc-provider --region $SC_AWS_REGION --cluster $SC_EKS_CLUSTER_NAME

#curl --request GET -sL \
#     --url 'http://example.com'\
#     --output './path/to/file'

kubectl delete serviceaccount -n kube-system aws-node-termination-handler