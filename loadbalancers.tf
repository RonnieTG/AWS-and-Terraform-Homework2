resource "aws_lb" "web" {
  name = "NginX-ALB"
  internal = false
  load_balancer_type = "application"
  subnets         = [aws_subnet.public[0].id, aws_subnet.public[1].id]
  security_groups = [aws_security_group.web_servers.id]

  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_lb_listener" "web" {
    load_balancer_arn = aws_lb.web.arn
    port     = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.web.arn
    }
}
  
resource "aws_lb_target_group" "web" {
  name     = "Target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  
  health_check {
    enabled = true 
    path = "/"   
    }    
}

resource "aws_lb_target_group_attachment" "web_server" {
  count = 2 
  target_group_arn = aws_lb_target_group.web.id
  target_id        = aws_instance.web_server.*.id[count.index]
  port             = 80
}