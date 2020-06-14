resource "aws_vpc" "KafkaVPC" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "Kafka-QA-VPC"
  }
}

resource "aws_subnet" "KafkaSN" {
  vpc_id = "${aws_vpc.KafkaVPC.id}"
  cidr_block = "${var.subnet_cidr}"
  availability_zone = "ap-southeast-2a"

  tags {
    Name = "Kafka-QA-SN"
  }
}

resource "aws_internet_gateway" "KafkaIGW" {
  vpc_id = "${aws_vpc.KafkaVPC.id}"

  tags {
    Name = "Kafka-QA-IGW"
  }
}

resource "aws_route_table" "KafkaRT" {
  vpc_id = "${aws_vpc.KafkaVPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.KafkaIGW.id}"
  }

  tags {
    Name = "Kafka-QA-RT"
  }
}

resource "aws_route_table_association" "KafkaRTA" {
  subnet_id = "${aws_subnet.KafkaSN.id}"
  route_table_id = "${aws_route_table.KafkaRT.id}"
}

resource "aws_security_group" "KafkaSG" {
  vpc_id = "${aws_vpc.KafkaVPC.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5181
    to_port = 5181
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 9092
    to_port = 9092
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = -1
    self = true
    from_port = 0
    to_port = 0
  }

  egress {
    protocol = -1
    self = true
    from_port = 0
    to_port = 0
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Kafka-QA-SG"
  }
}