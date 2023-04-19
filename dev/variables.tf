variable "Dev-instance-name" {
  type        = string
  description = "name of instance in dev env"
}

variable "Dev-instance-type" {
  description = "Instance type for dev env"
  type        = string
}

variable "Dev-instance-ami" {
  description = "Instance type for dev env"
  type        = string
}

variable "access_key" {
  type = string
  default = "AKIAQFGYD5FO3QQSKUIZ"
}

variable "secret_key" {
  type = string
  default = "fduE1HqOexGU776dZv4X76abgXmAQcGH1EPob7hY"
}



