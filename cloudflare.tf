resource "cloudflare_record" "website" {
  count = length(var.cf_records)
  zone_id = var.cf_zone_id
  name    = "${var.cf_records[count.index]}"
  value   = aws_cloudfront_distribution.s3_distribution.domain_name
  type    = "CNAME"
  proxied = true
}

