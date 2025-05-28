resource "aws_iam_role" "groupb_role" {
  name = "${local.prefix}-GroupB_server"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid    = "EC2AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "groupb_profile" {
  name = "${local.prefix}-groupb-profile"
  role = aws_iam_role.groupb_role.name
}

resource "aws_iam_policy" "s3_groupb_policy" {
  name        = "EC2S3AccessPolicy"
  description = "Policy to allow EC2 instance to access S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "S3Access",
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ],
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.terraform_state.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.terraform_state.bucket}/*"
        ]
      },

      {
        Effect= "Allow",
        Action= [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue"
        ],
        Resource= "arn:aws:secretsmanager:ca-central-1:473557429518:secret:rds-password05-kEXiby"
      },
   
    ]
  })
}

resource "aws_iam_role_policy_attachment" "groupb_s3_access" {
  role       = aws_iam_role.groupb_role.name
  policy_arn = aws_iam_policy.s3_groupb_policy.arn
}


