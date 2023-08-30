resource "aws_iam_role" "tf-codepipeline-role-terraform" {
  name = "tf-codepipeline-role-terraform"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ] ,
   [
    ### BEGIN ADDING STATEMENT HERE ###
    {
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:CompleteLayerUpload",
        "ecr:GetAuthorizationToken",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    ### END ADDING STATEMENT HERE ###
    ...
  ]
}
EOF

}


data "aws_iam_policy_document" "tf-cicd-pipeline-policies-terraform" {
    statement{
        sid = ""
        actions = ["codestar-connections:UseConnection"]
        resources = ["*"]
        effect = "Allow"
    }
    statement{
        sid = ""
        actions = ["cloudwatch:*", "s3:*", "codebuild:*"]
        resources = ["*"]
        effect = "Allow"
    }
}

resource "aws_iam_policy" "tf-cicd-pipeline-policy-terraform" {
    name = "tf-cicd-pipeline-policy-terraform"
    path = "/"
    description = "Pipeline policy"
    policy = data.aws_iam_policy_document.tf-cicd-pipeline-policies-terraform.json
}

resource "aws_iam_role_policy_attachment" "tf-cicd-pipeline-attachment" {
    policy_arn = aws_iam_policy.tf-cicd-pipeline-policy-terraform.arn
    role = aws_iam_role.tf-codepipeline-role-terraform.id
}


resource "aws_iam_role" "tf-codebuild-role-terraform" {
  name = "tf-codebuild-role-terraform"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

data "aws_iam_policy_document" "tf-cicd-build-policies-terraform" {
    statement{
        sid = ""
        actions = ["logs:*", "s3:*", "codebuild:*", "secretsmanager:*","iam:*"]
        resources = ["*"]
        effect = "Allow"
    }
}

resource "aws_iam_policy" "tf-cicd-build-policy-terraform" {
    name = "tf-cicd-build-policy-terraform"
    path = "/"
    description = "Codebuild policy"
    policy = data.aws_iam_policy_document.tf-cicd-build-policies-terraform.json
}

resource "aws_iam_role_policy_attachment" "tf-cicd-codebuild-attachment-terraform11" {
    policy_arn  = aws_iam_policy.tf-cicd-build-policy-terraform.arn
    role        = aws_iam_role.tf-codebuild-role-terraform.id
}

resource "aws_iam_role_policy_attachment" "tf-cicd-codebuild-attachment-terraform12" {
    policy_arn  = "arn:aws:iam::aws:policy/PowerUserAccess"
    role        = aws_iam_role.tf-codebuild-role-terraform.id
}