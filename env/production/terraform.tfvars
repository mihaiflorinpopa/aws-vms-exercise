project            = "aws-vms-exercise"
env                = "production"
profile            = "test"
region             = "us-east-1"
vpc_cidr_block     = "10.1.0.0/16"
subnet_cidr_block  = "10.1.0.0/24"
availability_zone  = "us-east-1a"

instance_count     = 2
ami                = "ami-06f59e43b31a49ecc"
instance_type      = "t2.micro"
