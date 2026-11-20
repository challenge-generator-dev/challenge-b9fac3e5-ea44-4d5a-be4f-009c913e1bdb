mock_provider "aws" {}

run "test_provision_infrastructure_valid_config" {
  command = plan

  assert {
    condition     = aws_s3_bucket.terraform_state.id != ""
    error_message = "S3 bucket should be created for terraform state"
  }

  assert {
    condition     = aws_s3_bucket_versioning.terraform_state[0].versioning_configuration[0].status == "Enabled"
    error_message = "S3 bucket versioning should be enabled"
  }

  assert {
    condition     = aws_s3_bucket_server_side_encryption_configuration.terraform_state[0].rule[0].apply_server_side_encryption_by_default[0].sse_algorithm == "AES256"
    error_message = "S3 bucket should use AES256 encryption"
  }

  assert {
    condition     = aws_dynamodb_table.terraform_state_lock[0].hash_key == "LockID"
    error_message = "DynamoDB table should have LockID as hash key"
  }
}

run "test_provision_infrastructure_invalid_config" {
  command = plan

  variables {
    bucket_name = ""
  }

  expect_failures = [
    resource.aws_s3_bucket.terraform_state,
  ]
}

run "test_provision_infrastructure_nonexistent_module" {
  command = plan

  variables {
    use_nonexistent_module = true
  }

  expect_failures = [
    module.nonexistent_module,
  ]
}

run "test_provision_infrastructure_terraform_error" {
  command = plan

  variables {
    invalid_backend_config = true
  }

  expect_failures = [
    resource.aws_s3_bucket.terraform_state,
  ]
}