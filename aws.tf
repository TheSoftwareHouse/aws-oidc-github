resource "aws_iam_role" "ci_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.allow_ci.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "role_policies" {
  for_each   = toset(var.role_policies)
  role       = aws_iam_role.ci_role.name
  policy_arn = each.value
}

data "aws_iam_policy_document" "allow_ci" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "ForAllValues:StringLike"
      variable = "${aws_iam_openid_connect_provider.github.url}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "ForAllValues:StringLike"
      variable = "${aws_iam_openid_connect_provider.github.url}:sub"
      values   = [for repo in var.github_repos : "repo:${var.github_org}/${repo}:*"]
    }
  }
}
