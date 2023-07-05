# <block_type> <resource_type> <resource_name> {
#
#   
#
#}


provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_user" "user1" {
  name = "Smit"
}

resource "aws_iam_user" "user2" {
  name = "Ansh"
}

resource "aws_iam_group" "Group" {
  name = "Kotkar"
}

resource "aws_iam_group_membership" "example_membership" {
  users = [
    aws_iam_user.user1.name
    aws_iam_user.user2.name
  ]

  group = [
    aws_iam_group.Group.name
  ]
}

resource "aws_iam_policy" "policy" {
  name        = "policy"
  description = "policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject"],
      "Resource": ["arn:aws:s3:::example-bucket/*"]
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "example_attachment" {
  name       = "example_attachment"
  policy_arn = aws_iam_policy.policy.arn
  groups     = [aws_iam_group.Group.name]
}
