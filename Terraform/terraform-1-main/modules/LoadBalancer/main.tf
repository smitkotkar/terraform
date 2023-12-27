resource "aws_launch_configuration" "lc_home" {
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_pair
  name = "${var.project}-lc-home"
  security_groups = var.sg_ids
  user_data = <<-EOT
    #!/bin/bash
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo "<h1> Hello World <br> Welcome to Cloudblitz" > /var/www/html/index.html
  EOT
}

resource "aws_launch_configuration" "lc_laptop" {
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_pair
  name = "${var.project}-lc-laptop"
  security_groups = var.sg_ids
  user_data = <<-EOT
    #!/bin/bash
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    mkdir /var/www/html/laptop
    echo "<h1> Laptop Page <br> SALE SALE SALE " > /var/www/html/laptop/index.html
  EOT
}

resource "aws_launch_configuration" "lc_mobile" {
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_pair
  name = "${var.project}-lc-mobile"
  security_groups = var.sg_ids
  user_data = <<-EOT
    #!/bin/bash
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    mkdir /var/www/html/mobile
    echo "<h1>Mobile Page" > /var/www/html/mobile/index.html
  EOT
}

resource "aws_autoscaling_group" "as_home" {
    name = "${var.project}-as-home"
    max_size = 4
    min_size = 2
    desired_capacity = 2
    launch_configuration = aws_launch_configuration.lc_home.name
    vpc_zone_identifier = var.subnet_ids
    tag {
        key = "Name"
        value = "home"
        propagate_at_launch = true
    }
}


resource "aws_autoscaling_group" "as_laptop" {
    name = "${var.project}-as-laptop"
    max_size = 4
    min_size = 2
    desired_capacity = 2
    launch_configuration = aws_launch_configuration.lc_laptop.name
    vpc_zone_identifier = var.subnet_ids
    tag {
        key = "Name"
        value = "laptop"
        propagate_at_launch = true
    }
}


resource "aws_autoscaling_group" "as_mobile" {
    name = "${var.project}-as-mobile"
    max_size = 4
    min_size = 2
    desired_capacity = 2
    launch_configuration = aws_launch_configuration.lc_mobile.name
    vpc_zone_identifier = var.subnet_ids
    tag {
        key = "Name"
        value = "mobile"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_policy" "as_policy_home" {
    name = "${var.project}-as-policy-home"
    autoscaling_group_name = aws_autoscaling_group.as_home.name
    adjustment_type = "ChangeInCapacity"
    policy_type = "TargetTrackingScaling"
    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
    target_value = 40.0
    }
}

resource "aws_autoscaling_policy" "as_policy_laptop" {
    name = "${var.project}-as-policy-laptop"
    autoscaling_group_name = aws_autoscaling_group.as_laptop.name
    adjustment_type = "ChangeInCapacity"
    policy_type = "TargetTrackingScaling"
    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
    target_value = 40.0
    }
}

resource "aws_autoscaling_policy" "as_policy_mobile" {
    name = "${var.project}-as-policy-mobile"
    autoscaling_group_name = aws_autoscaling_group.as_mobile.name
    adjustment_type = "ChangeInCapacity"
    policy_type = "TargetTrackingScaling"
    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
    target_value = 40.0
    }
}

