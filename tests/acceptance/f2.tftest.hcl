mock_provider "aws" {}

mock_data "aws_vpc" {
  defaults {
    id = "vpc-12345678"
    cidr_block = "10.0.0.0/16"
  }
}

mock_data "aws_subnet" {
  defaults {
    id = "subnet-12345678"
    vpc_id = "vpc-12345678"
  }
}

mock_data "aws_security_group" {
  defaults {
    id = "sg-12345678"
    vpc_id = "vpc-12345678"
  }
}

run "test_configure_vpc_valid_config" {
  command = plan

  assert {
    condition     = aws_vpc.network.id != ""
    error_message = "VPC should be configured with valid ID"
  }
}

run "test_configure_vpc_invalid_config" {
  command = plan

  variables {
    vpc_cidr = "invalid-cidr"
  }

  expect_failures = [
    variable.vpc_cidr,
  ]
}

run "test_configure_instance_valid_config" {
  command = plan

  variables {
    ami_id     = "ami-12345678"
    subnet_id  = "subnet-12345678"
  }

  assert {
    condition     = aws_instance.compute.id != ""
    error_message = "Instance should be configured with valid ID"
  }
}

run "test_configure_instance_invalid_config" {
  command = plan

  variables {
    ami_id    = ""
    subnet_id = "subnet-12345678"
  }

  expect_failures = [
    variable.ami_id,
  ]
}

run "test_configure_rds_valid_config" {
  command = plan

  variables {
    db_name     = "orders"
    db_username = "ordersadmin"
    master_password = "SecurePassword123!"
    vpc_security_group_ids = ["sg-12345678"]
    db_subnet_group_name = "main"
  }

  assert {
    condition     = aws_rds_instance.database.id != ""
    error_message = "RDS instance should be configured with valid ID"
  }

  assert {
    condition     = aws_rds_instance.database.engine == "postgres"
    error_message = "RDS instance should use postgres engine"
  }

  assert {
    condition     = aws_rds_instance.database.storage_encrypted == true
    error_message = "RDS instance should have encryption enabled"
  }
}

run "test_configure_rds_invalid_config" {
  command = plan

  variables {
    db_name     = ""
    db_username = "ordersadmin"
    master_password = "SecurePassword123!"
    vpc_security_group_ids = ["sg-12345678"]
    db_subnet_group_name = "main"
  }

  expect_failures = [
    variable.db_name,
  ]
}