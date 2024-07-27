resource "aws_cloudfront_origin_access_identity" "website" {
  comment = "${var.env}_${var.domain_name}"
}

locals {
  s3_origin_id = "${var.env}_${var.domain_name}"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.website.cloudfront_access_identity_path
    }
  }

  origin {
    domain_name = replace(var.public_api_gw_deployment_invoke_url, "/^https?://([^/]*).*/", "$1")
    origin_id   = "public_api"
    origin_path = "/production"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }


  web_acl_id = var.web_acl_id
  aliases = var.aliases

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  custom_error_response {
        error_caching_min_ttl = 60
        error_code = 404
        response_code = 404
        response_page_path = "/404.html"
 }

  custom_error_response {
        error_caching_min_ttl = 60
        error_code = 500
        response_code = 500
        response_page_path = "/error.html"
 }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

  ordered_cache_behavior {
    path_pattern     = "/api*"
    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods   = ["HEAD", "GET", "OPTIONS"]
    target_origin_id = "public_api"

    forwarded_values {
      query_string = true
      headers      = ["Origin"]
      cookies {
        forward = "all"
      }
    }

    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.website.arn
    ssl_support_method  = "sni-only"
  }
}
