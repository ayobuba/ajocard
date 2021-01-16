variable "NodeVolumeSize" {
  default = 8
}

# OpenVPN EC2
variable "vpn_key" {
  default = "vpn.server.routing.private_network.2"
}

resource "aws_cloudformation_stack" "openvpn_stack" {
  name = "openvpn-stack"
  parameters = {
    VPCID              = module.vpc.vpc_id
    VpnInitialUsername = var.VpnInitialUsername
    VpnInitialPassword = var.VpnInitialPassword
    //SubnetIDs = [element(module.vpc.public_subnets, 0),element(module.vpc.public_subnets, 1), element(module.vpc.public_subnets, 2)]
  }
  capabilities  = ["CAPABILITY_IAM"]
  template_body = <<STACK
AWSTemplateFormatVersion: '2010-09-09'
Description: OpenVPN Setup

Parameters:
  NodeImageId:
    Description: The OpenVPN AMI Id
    Type: AWS::EC2::Image::Id
    Default: ${var.NodeImageId}

  NodeVolumeSize:
    Description: The size of the hard drive of the machines (GBs)
    Type: Number
    Default: 8

  KeyName:
    Description: The EC2 Key Pair to allow SSH access to the instances
    Type: AWS::EC2::KeyPair::KeyName
    Default: ${var.KeyName}

  NodeInstanceType:
    Description: EC2 instance type for the node instances
    Type: String
    Default: t2.micro

  NodeAutoScalingGroupMinSize:
    Type: Number
    Description: Minimum size of Node Group ASG.
    Default: 1

  NodeAutoScalingGroupMaxSize:
    Type: Number
    Description: Maximum size of Node Group ASG.
    Default: 1

  SubnetIDs:
    Type: List<AWS::EC2::Subnet::Id>
    Description: The list of the subnets where the app can be deployed
    Default: "${element(module.vpc.public_subnets, 0)}, ${element(module.vpc.public_subnets, 1)},${element(module.vpc.public_subnets, 2)}"


  VPCID:
    Type: AWS::EC2::VPC::Id
    Description: The VPC where OpenVPN will be installed


  VPCCidr:
    Type: String
    Description: The VPC CIDR that will be used for configuring the access inside OpenVPN
    Default: ${module.vpc.vpc_cidr_block}

  AllowedIpRange:
    Type: String
    Default: 0.0.0.0/0

  VpnInitialUsername:
    Type: String

  VpnInitialPassword:
    Type: String
    NoEcho: true


Resources:
  NodeSecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: Security group for all nodes in the cluster
      VpcId: !Ref VPCID

  NodeSecurityGroupIngressTCP443:
    Type: AWS::EC2::SecurityGroupIngress
    Properties:
      GroupId: !Ref NodeSecurityGroup
      CidrIp: !Ref AllowedIpRange
      IpProtocol: tcp
      FromPort: 443
      ToPort: 443

  NodeSecurityGroupIngressSSH22:
    Type: AWS::EC2::SecurityGroupIngress
    Properties:
      GroupId: !Ref NodeSecurityGroup
      CidrIp: !Ref AllowedIpRange
      IpProtocol: tcp
      FromPort: 22
      ToPort: 22

  NodeSecurityGroupIngressTCP943:
    Type: AWS::EC2::SecurityGroupIngress
    Properties:
      GroupId: !Ref NodeSecurityGroup
      CidrIp: !Ref AllowedIpRange
      IpProtocol: tcp
      FromPort: 943
      ToPort: 943

  NodeSecurityGroupIngressTCP945:
    Type: AWS::EC2::SecurityGroupIngress
    Properties:
      GroupId: !Ref NodeSecurityGroup
      CidrIp: !Ref AllowedIpRange
      IpProtocol: tcp
      FromPort: 945
      ToPort: 945

  NodeSecurityGroupIngressUDP1194:
    Type: AWS::EC2::SecurityGroupIngress
    Properties:
      GroupId: !Ref NodeSecurityGroup
      CidrIp: !Ref AllowedIpRange
      IpProtocol: udp
      FromPort: 1194
      ToPort: 1194

  NodeSecurityGroupEgress:
    Type: AWS::EC2::SecurityGroupEgress
    Properties:
      GroupId: !Ref NodeSecurityGroup
      CidrIp: !Ref AllowedIpRange
      IpProtocol: -1

  NodeRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
        - Effect: Allow
          Principal:
            Service:
            - ec2.amazonaws.com
          Action:
          - sts:AssumeRole
      Path: "/"

  NodeRolePolicies:
    Type: AWS::IAM::Policy
    Properties:
      PolicyName: !Join
        - '-'
        - - openvpn
          - role
      PolicyDocument:
        Version: '2012-10-17'
        Statement:
        - Effect: Deny
          Action:
            - "*"
          Resource: "*"
      Roles:
      - !Ref NodeRole

  NodeInstanceProfile:
    Type: AWS::IAM::InstanceProfile
    Properties:
      Path: "/openvpn/"
      Roles:
      - !Ref NodeRole

  NodeGroup:
    Type: AWS::AutoScaling::AutoScalingGroup
    Properties:
      DesiredCapacity: !Ref NodeAutoScalingGroupMaxSize
      LaunchConfigurationName: !Ref NodeLaunchConfig
      MinSize: !Ref NodeAutoScalingGroupMinSize
      MaxSize: !Ref NodeAutoScalingGroupMaxSize
      VPCZoneIdentifier: !Ref SubnetIDs
      Tags:
        - Key: Project
          Value: OpenVPN
          PropagateAtLaunch: true
        - Key: Name
          Value: OpenVPN Server
          PropagateAtLaunch: true

  NodeLaunchConfig:
    Type: AWS::AutoScaling::LaunchConfiguration
    Properties:
      InstanceType: !Ref NodeInstanceType
      ImageId: !Ref NodeImageId
      KeyName: !Ref KeyName
      SecurityGroups:
      - !Ref NodeSecurityGroup
      IamInstanceProfile: !Ref NodeInstanceProfile
      BlockDeviceMappings:
      - DeviceName: /dev/xvda
        Ebs:
          VolumeSize:
            Ref: NodeVolumeSize
          VolumeType: gp2
          DeleteOnTermination: true
      UserData:
        Fn::Base64:
          !Sub |
            #!/bin/bash
            sudo /usr/local/openvpn_as/scripts/sacli --key "vpn.server.routing.private_network.1" --value "${module.vpc.vpc_cidr_block}" ConfigPut
            sudo /usr/local/openvpn_as/scripts/sacli --key "vpn.server.routing.private_network.2" --value "${var.SecondaryVPCCidr}" ConfigPut
            sudo /usr/local/openvpn_as/scripts/sacli --user ${var.VpnInitialUsername} --new_pass ${var.VpnInitialPassword} SetLocalPassword
            sudo /usr/local/openvpn_as/scripts/sacli stop
            sudo /usr/local/openvpn_as/scripts/sacli start
STACK
}