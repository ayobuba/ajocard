
resource "aws_launch_template" "main" {
  ebs_optimized = var.nodes_defaults["ebs_optimized"]
  network_interfaces {
    associate_public_ip_address = var.nodes_defaults["public_ip"]
  }
    iam_instance_profile {
      name = sc-stg-eks-worker
    }
  image_id = var.nodes_defaults["ami_id"]
  #  instance_type        = var.nodes_defaults["instance_type"]
  key_name             = var.nodes_defaults["key_name"]
  name_prefix          = "eks-config-lt"
  security_group_names = [data.aws_security_group.selected.name]
  user_data            = base64encode(local.eks-nodes-userdata)


  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = var.metadata_http_endpoint_enabled ? "enabled" : "disabled"
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    http_tokens                 = var.metadata_http_tokens_required ? "required" : "optional"
  }
  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings

    content {
      #      device_name = block_device_mappings.value.device_name

      ebs {

        delete_on_termination = lookup(block_device_mappings.value, "delete_on_termination", null)
        encrypted             = lookup(block_device_mappings.value, "encrypted", null)
        iops                  = lookup(block_device_mappings.value, "iops", null)
        kms_key_id            = lookup(block_device_mappings.value, "kms_key_id", null)
        snapshot_id           = lookup(block_device_mappings.value, "snapshot_id", null)
        throughput            = lookup(block_device_mappings.value, "throughput", null)
        volume_size           = lookup(block_device_mappings.value, "volume_size", null)
        volume_type           = lookup(block_device_mappings.value, "volume_type", null)
      }
    }
  }
  #  metadata_options {
  #    http_endpoint               = "enabled"
  #    http_tokens                 = "optional"
  #    http_put_response_hop_limit = "10"
  #  }

  #  block_device_mappings {
  #    ebs {
  #      volume_size           = var.ec2_disk
  #      delete_on_termination = true
  #    }
  #  }

}

