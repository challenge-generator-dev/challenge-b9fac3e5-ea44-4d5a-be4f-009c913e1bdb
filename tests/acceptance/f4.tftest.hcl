mock_provider "aws" {}

run "test_validate_infrastructure_functioning" {
  command = plan

  assert {
    condition     = output.backend_configured == true
    error_message = "Backend should be configured"
  }

  assert {
    condition     = output.s3_bucket_name != ""
    error_message = "S3 bucket name should be exposed"
  }

  assert {
    condition     = output.dynamodb_table_name != ""
    error_message = "DynamoDB table name should be exposed"
  }
}

run "test_optimize_terraform_modules" {
  command = plan

  assert {
    condition     = aws_s3_bucket.terraform_state.bucket != ""
    error_message = "S3 bucket should have valid name"
  }

  assert {
    condition     = aws_s3_bucket_server_side_encryption_configuration.terraform_state[0].rule[0].apply_server_side_encryption_by_default[0].sse_algorithm == "AES256"
    error_message = "Encryption should be optimized to AES256"
  }

  assert {
    condition     = aws_s3_bucket_versioning.terraform_state[0].versioning_configuration[0].status == "Enabled"
    error_message = "Versioning should be enabled for state management"
  }
}

run "test_validate_terraform_modules_invalid_config" {
  command = plan

  variables {
    bucket_name = "invalid-name-with-underscores"
  }

  expect_failures = [
    resource.aws_s3_bucket.terraform_state,
  ]
}

run "test_validate_terraform_modules_syntax_errors" {
  command = plan

  variables {
    enable_syntax_errors = true
  }

  expect_failures = [
    resource.aws_s3_bucket.terraform_state,
  ]
}