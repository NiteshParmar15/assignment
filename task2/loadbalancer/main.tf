resource "aws_lb_target_group" "torum-nlb-tg" {
  name     = "torum-nlb-tg"
  port     = 80
  protocol = "TCP"
  target_type = "instance"
  vpc_id   = var.vpc_id
}

resource "aws_lb" "nlb" {
  name               = "torum-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [var.public_subnet_id]
  ip_address_type    = "ipv4"
  enable_deletion_protection = false

  tags = {
    Name = "torum-nlb"
  }
}

resource "aws_alb_listener" "torum-nlb-httplistener" {
  default_action {
    target_group_arn = aws_lb_target_group.torum-nlb-tg.arn
    type = "forward"
  }
  load_balancer_arn = aws_lb.nlb.arn
  port = 80
  protocol = "TCP"
}
resource "aws_alb_listener" "torum-nlb-httpslistener" {
  default_action {
    target_group_arn = aws_lb_target_group.torum-nlb-tg.arn
    type = "forward"
  }
  load_balancer_arn = aws_lb.nlb.arn
  port = 443
  protocol = "TCP"
}
resource "aws_alb_target_group_attachment" "tg-attachment" {
  count = length(var.aws_instance_id)
  target_group_arn = aws_lb_target_group.torum-nlb-tg.arn
  target_id = var.aws_instance_id[count.index]
}
