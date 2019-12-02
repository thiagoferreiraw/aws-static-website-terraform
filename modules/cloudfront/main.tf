locals {
  website_bucket_origin_id = "origin-bucket-${aws_s3_bucket.website_bucket.bucket_regional_domain_name}"
}

resource "aws_cloudfront_distribution" "website_distribuition" {
  origin {
    domain_name = "${aws_s3_bucket.website_bucket.bucket_regional_domain_name}"
    origin_id   = "${local.website_bucket_origin_id}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "${aws_s3_bucket.website_bucket_logs.id}"
    prefix          = "distribuition-logs"
  }

  aliases = ["${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.website_bucket_origin_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  viewer_certificate {
    acm_certificate_arn = "${var.domain_certificate_arn}"
    ssl_support_method  = "sni-only"
  }
}
