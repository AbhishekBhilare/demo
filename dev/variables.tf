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


variable "from_port" {
  description = "Instance type for dev env"
  type        = list
}

variable "to_port" {
  description = "Instance type for dev env"
  type        = list
}


variable "no-of-instance" {
  description = "Instance type for dev env"
  type        = number
}

variable "key_name"{
  type = string
}
