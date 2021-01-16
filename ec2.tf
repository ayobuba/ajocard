//# Create and bootstrap EC2 in eu-central-1
//resource "aws_instance" "jenkins_master" {
//  ami           = data.aws_ssm_parameter.LinuxAmi-Master.value
//  instance_type = var.instance_type
//  //key_name                    = aws_key_pair.master-key.key_name
//  key_name                    = "prenovate-eu-central-1"
//  associate_public_ip_address = true
//  vpc_security_group_ids      = [aws_security_group.jenkins_group.id]
//  subnet_id                   = aws_subnet.subnet_1_central.id
//
//  provisioner "file" {
//
//    connection {
//      type        = "ssh"
//      user        = "ubuntu"
//      host        = aws_instance.jenkins_master.public_ip
//      private_key = file("prenovate-eu-central-1.pem")
//      agent       = false
//      timeout     = "2m"
//    }
//    source      = "ansible_templates/"
//    destination = "/tmp"
//  }
//
//
//
//
//
//
//  tags = {
//    Name = "jenkins_master_tf"
//  }
//  depends_on = [aws_main_route_table_association.set-master-default-rt-assoc]
//}
//
//# Create EC2 in eu-west-2
//resource "aws_instance" "jenkins_worker_london" {
//  provider      = aws.region_worker
//  ami           = data.aws_ssm_parameter.LinuxAmi-Worker.value
//  instance_type = var.instance_type
//  //key_name                    = aws_key_pair.worker-key.key_name
//  key_name                    = "prenovate-eu-west-2"
//  count                       = var.worker-count
//  associate_public_ip_address = true
//  vpc_security_group_ids      = [aws_security_group.jenkins_sg_london.id]
//  subnet_id                   = aws_subnet.subnet_1_london.id
//
//
//  //  provisioner "local-exec" {
//  //    command = <<EOF
//  //    aws --profile ${var.profile} ec2 wait instance-status-ok --region ${var.region_worker} --instance-ids ${self.id}
//  //    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key ./prenovate-eu-west-2.pem -i '${aws_instance.jenkins_worker_london[count.index].public_ip},' ansible_templates/jenkins-worker-sample.yml
//  //    EOF
//  //  }
//
//  //  provisioner "local-exec" {
//  //
//  //    command = <<EOF
//  //aws --profile ${var.profile} ec2 wait instance-status-ok --region ${var.region_worker} --instance-ids ${self.id}
//  //ansible-playbook -i '${self.public_ip},' --extra-vars 'passed_in_hosts=tag_Name_${self.tags.Name}'  --private-key ./prenovate-eu-west-2.pem ansible_templates/jenkins-worker-sample.yml
//  //EOF
//  //  }
//
//  tags = {
//    Name = join("_", ["jenkins_worker_tf", count.index + 1])
//  }
//
//  depends_on = [aws_main_route_table_association.set-worker-default-rt-assoc, aws_instance.jenkins_master]
//}