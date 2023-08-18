aws eks describe-cluster --name sc-stg-cluster --query "cluster.identity.oidc.issuer" --output text
aws iam list-open-id-connect-providers | grep 3AD1324D62BFD9E0843E0E41414B3358