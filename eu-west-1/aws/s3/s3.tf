resource "aws_s3_bucket" "bucketname-eu-west-1" {
    bucket = "${var.project}-${var.region}"
    acl    = "private"
    region = "eu-west-1"
    versioning {
        enabled = true
    }
}
