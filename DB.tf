
#-----------------DB----------------
resource "aws_db_subnet_group" "global-subnet-group" {
  name        = "db-subnet-group"
  description = "The subnets used for RDS "
  subnet_ids  = ["${aws_subnet.global-private-subnet-a-db.id}", "${aws_subnet.global-private-subnet-c-db.id}"]

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "global-master-db" {
  allocated_storage     = 50
  max_allocated_storage = 80
  engine                = "mysql"
  engine_version        = "5.7.22"
  instance_class        = "db.t2.micro"
  name                  = "californiamasterdb"
  username              = "admin"
  password              = "password"
  db_subnet_group_name  = aws_db_subnet_group.global-subnet-group.id
  multi_az              = true
  skip_final_snapshot   = true
  vpc_security_group_ids = [
    aws_security_group.global-private-sg-db.id
  ]
  tags = {
    "name" = "MasterDB"
  }
}
