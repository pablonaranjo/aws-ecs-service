variable "cluster_id" {
  description = "The ECS cluster ID"
  type        = string
}

variable "name" {
  description = "Name of the service"
  type        = string
}

variable "log_group" {
  description = "Name of the log_group"
  type        = string
}

variable "container_def" {
  description = "Container definition - json"
  type        = string
  default     = ""
}

variable "memory" {
  description = "Memory RAM for the service"
  type        = number
  default     = 512
}

variable "cpu" {
  description = "CPU for the service"
  type        = number
  default     = 1024
}

variable "create" {
  default = true
}

variable "use_elb" {
  default = false
}

variable "use_alb" {
  default = false
}

variable "target_group_arn" {
  default = ""
}

variable "elb_port" {}
variable "elb_name" {
  default = ""
}
variable "elb_health_check_grace_period" {}
