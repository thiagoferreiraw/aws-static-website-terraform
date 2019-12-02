resource "aws_s3_bucket" "website_bucket" {
  bucket = "${var.domain_name}"
  acl    = "public-read"
  policy = "${file("policy.json")}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging {
    target_bucket = "${aws_s3_bucket.website_bucket_logs.id}"
    target_prefix = "log/"
  }
}

resource "aws_s3_bucket" "website_bucket_logs" {
  bucket = "logs-${var.domain_name}"
  acl    = "log-delivery-write"
}
