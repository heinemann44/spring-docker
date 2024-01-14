resource "aws_security_group" "spring_security_group" {
  name        = "spring_security_group"
  description = "spring security group"
  vpc_id      = aws_vpc.spring_vpc.id
}

resource "aws_security_group_rule" "security_group_rule_pub_out" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.spring_security_group.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "security_group_rule_ssh_in" {
  from_port         = 22
  protocol          = "TCP"
  security_group_id = aws_security_group.spring_security_group.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "security_group_rule_http_in" {
  from_port         = 8080
  protocol          = "TCP"
  security_group_id = aws_security_group.spring_security_group.id
  to_port           = 8080
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_key_pair" "spring_key" {
  key_name   = "springkey"
  public_key = file("~/.ssh/springboot.pub")
}

