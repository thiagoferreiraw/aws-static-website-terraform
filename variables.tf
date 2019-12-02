variable "env" {
  description = "Project environments: dev, sandbox, prod"
}

variable "domain_name" {
  type        = "map"
  description = "Project domain name. E.g: site.com"
}

variable "domain_certificate_arn" {
  type        = "string"
  description = "Domain certificate ARN."
}
