resource "aws_s3_bucket" "private_bucket" {
  bucket = var.private_bucket_name #optional unique name of 63 character random string will be generated
  # force_destroy = true
  tags = var.tags
}


resource "aws_s3_bucket" "public_bucket" {
  bucket = var.public_bucket_name
  # force_destroy = true -> dont see the any object inside or not simply delete the bucket
  tags = var.tags

}

resource "aws_s3_bucket_public_access_block" "access" {
  bucket                  = aws_s3_bucket.public_bucket.id
  block_public_acls       = false #upload of file can be successful
  block_public_policy     = false #can add policy and make bucket public
  ignore_public_acls      = true  #even file is public s3 ignores and treats them as private
  restrict_public_buckets = false #anyone spcified the in the public policy can access the bucket
}



resource "aws_s3_bucket_policy" "public_bucket_policy" {
  bucket = aws_s3_bucket.public_bucket.id


  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.public_bucket.id}/*"
      }
    ]
  }
  EOF
}



resource "aws_s3_bucket_policy" "private_s3_policy" {
  bucket = aws_s3_bucket.private_bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.private_bucket.bucket}",
        "arn:aws:s3:::${aws_s3_bucket.private_bucket.bucket}/*"
      ],
      "Condition": {
        "StringEquals": {
          "aws:SourceVpce": "${aws_vpc_endpoint.s3_vpc_endpoint.id}"
        }
      }
    }
  ]
}
EOF
}


resource "aws_vpc_endpoint" "s3_vpc_endpoint" {
  vpc_id          = var.vpc_id
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = var.route_table_ids
  # vpc_endpoint_type is gateway (default)
  tags = var.tags
}
