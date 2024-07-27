# AWS S3 bucket for hosting
resource "aws_s3_bucket" "website" {
  bucket = "${var.domain_name}"
}

resource "aws_s3_bucket_ownership_controls" "website" {
  bucket = aws_s3_bucket.website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "website" {
  depends_on = [aws_s3_bucket_ownership_controls.website]

  bucket = aws_s3_bucket.website.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_cloudfront_origin_access_identity.website.iam_arn}"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.website.arn}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_cloudfront_origin_access_identity.website.iam_arn}"
            },
            "Action": "s3:ListBucket",
            "Resource": "${aws_s3_bucket.website.arn}"
        }
    ]
})
}
