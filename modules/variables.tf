variable "instance-name" {
    type= string 
    description = "instance name"
}

variable "instance_type" {
    type = string 
    description = "instance type by defualt it choose the free tier t2.micro "
    default = "t2.micro"
}

variable "instance_ami" {
    description = "instance ami by defualt it choose free tier ami"
}
