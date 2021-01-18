#!/bin/sh

aws eks --region eu-west-3 update-kubeconfig --name AjoCard-EKS-NAX62UTW
#aws eks --region $(terraform output aws_region) update-kubeconfig --name $(terraform output cluster_name)