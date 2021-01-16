# Create master subnet 1 Central
//resource "aws_subnet" "subnet_1_central" {
//  cidr_block        = "10.0.1.0/24"
//  vpc_id            = aws_vpc.vpc_master.id
//  availability_zone = element(data.aws_availability_zones.azs.names, 0)
//  tags = {
//    Name = "subnet_1_central"
//  }
//}

# Create master subnet 2 Central
//resource "aws_subnet" "subnet_2_central" {
//  cidr_block        = "10.0.2.0/24"
//  vpc_id            = aws_vpc.vpc_master.id
//  availability_zone = element(data.aws_availability_zones.azs.names, 1)
//  tags = {
//    Name = "subnet_2_central"
//  }
//}

//resource "aws_subnet" "public_subnet" {
//  count = length(data.aws_availability_zones.azs.names)
//  //cidr_block        = "10.0.1.0/24"
//  cidr_block        = "10.0.${(count.index + 1) * 10}.0/24"
//  vpc_id            = aws_vpc.vpc_master.id
//  availability_zone = element(data.aws_availability_zones.azs.names, count.index)
//  tags = {
//    Name = "public-${element(data.aws_availability_zones.azs.names, count.index)}"
//  }
//}