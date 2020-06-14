provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"

  version = "~> 1.7"
}

resource "aws_instance" "KafkaNode1" {
   ami  = "ami-67589505"
   instance_type = "t2.medium"
   key_name = "${var.key_name}"
   subnet_id = "${aws_subnet.KafkaSN.id}"
   vpc_security_group_ids = ["${aws_security_group.KafkaSG.id}"]
   associate_public_ip_address = true
   source_dest_check = true

  tags {
    Name = "Kafka Node 1"
  }
}

output "Kafka Node 1 IP" {
  value = "${aws_instance.KafkaNode1.public_ip}"
}

output "Kafka Node 1 DNS" {
  value = "${aws_instance.KafkaNode1.public_dns}"
}