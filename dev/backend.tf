terraform {
  backend "s3" {
    bucket = "terraform-backend-buck-01"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "DB-Table-lock"
    access_key = "AKIAQFGYD5FORCTWIYEF"
    secret_key = "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"
  }
}
