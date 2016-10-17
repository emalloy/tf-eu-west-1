# S3 requires Access Key and Secret Key
resource "aws_iam_user" "s3" {
  name = "${var.project}-${var.region}-user"
  path = "/system/"
}

resource "aws_iam_access_key" "s3" {
  user = "${aws_iam_user.s3.name}"
}


# Policy for "${aws_iam_user.s3.name}"

# @ToDo this should consume proper variables and be more granular
resource "aws_iam_policy" "registry_policy" {
  name = "${var.project}-${var.region}-policy"
  path = "/"
  description = "Policy for backup user ${aws_iam_user.s3.name} "
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::${var.project}-${var.region}",
        "arn:aws:s3:::${var.project}-${var.region}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "bucket-policy-attache-s3" {
  name       = "${var.project}-${var.region}-s3"
  users      = ["${aws_iam_user.s3.name}"]
  policy_arn = "${aws_iam_policy.registry_policy.arn}"
}

