resource "aws_instance" "instance" {
  count = length(var.ec2_tag)
  ami                         = var.ami_id 
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip
  availability_zone           = data.aws_availability_zones.available.names[0]
  disable_api_termination     = var.disable_api_termination
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.private_subnet_id
  user_data                   = file("${path.module}/user-data.sh")
  # key_name                    = data.aws_key_pair.key.key_name

  hibernation = false
  
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = var.volume_size
    volume_type           = "gp2"
    tags = {
      Name  = var.ec2_tag[count.index]
    }
  }
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
  tags = {
    Name   = var.ec2_tag[count.index]
  }
}
