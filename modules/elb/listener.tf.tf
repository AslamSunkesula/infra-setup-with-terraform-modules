resource "aws_lb_listener" "elb_listener_public" {
  load_balancer_arn = aws_lb.aws_network_lb.arn
  port              = 80
  protocol          = "TCP"  # Correct protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}
