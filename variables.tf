variable "role_name" {
  description = "Name Of The Role To Create"
  type        = string
  default     = "GitHubActions"
}

variable "role_policies" {
  description = "List Of IAM Policy ARNs To Attach To The CI Role"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}

variable "github_url" {
  description = "The URL Of The Token Endpoint For Github"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

variable "github_org" {
  description = "Github Trusted Organisation"
  type        = string
}

variable "github_repos" {
  description = "Github Trusted Repositories"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "List Of Tags For Resources"
  type        = map(string)
  default     = {}
}
