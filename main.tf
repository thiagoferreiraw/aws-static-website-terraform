module "s3" {
  source = "./modules/s3"

  domain_name = "${lookup(var.domain_name, var.env)}"
}

module "cloudfront" {
  source = "./modules/cloudfront"

  domain_name            = "${lookup(var.domain_name, var.env)}"
  domain_certificate_arn = "${var.domain_certificate_arn}"
}

module "route53" {
  source = "./modules/route53"

  domain_name = "${lookup(var.domain_name, var.env)}"
}
