terraform {
  backend "s3" {
    bucket = "terraform-backend-buck-01"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "DB-Table-lock"
  }
}
