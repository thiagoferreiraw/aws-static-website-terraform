resource "aws_route53_zone" "domain" {
  name = "${var.domain_name}"
}

resource "aws_route53_record" "name" {
  zone_id = "${aws_route53_zone.domain.zone_id}"
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.website_distribuition.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.website_distribuition.hosted_zone_id}"
    evaluate_target_health = false
  }
}
