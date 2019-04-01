resource "aws_instance" "WebInstance" {
  count           = "${length(var.aws_subnet_cidr)}"
  ami             = "${lookup(var.aws_ami_id,var.aws_region)}"
  instance_type   = "${var.aws_instance_type}"
  key_name        = "${var.aws_key_name}"
  security_groups = ["${aws_security_group.webservers-sg.id}"]
  subnet_id       = "${element(aws_subnet.PublicSubnet.*.id,count.index)}"

  user_data = "${file("install_nginx.sh")}"

  tags {
    Name = "WebServer-${count.index+1}"
  }
}

output "InstancePublicIP" {
  value = "${aws_instance.WebInstance.*.public_ip}"
}
