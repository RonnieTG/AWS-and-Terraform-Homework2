#######################################################################################

# INSTANCES #

resource "aws_instance" "web_server" {
  ami = data.aws_ami.ubuntu-18.id
  count = 2
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.*.id[count.index]
  vpc_security_group_ids = [aws_security_group.web_servers.id]
  key_name               = var.key_name
  associate_public_ip_address = true
  user_data = file("./installnginx.sh")
    ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "10"
    volume_type = "standard"
    encrypted = true
  }

  tags = { Name = "Web-${count.index + 1}" }
}

resource "aws_instance" "db_server" {
  ami = data.aws_ami.ubuntu-18.id
  count = 2
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private.*.id[count.index]
  vpc_security_group_ids = [aws_security_group.web_servers.id]
  key_name               = var.key_name
    ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "10"
    volume_type = "standard"
    encrypted = true
  }

  tags = { Name = "DB-${count.index + 1}" }
}