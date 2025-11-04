variable "comment" {
  description = "Comment for the distribution"
  type        = string
  default     = ""
}

variable "aliases" {
  description = "Alternate domain names (CNAMEs)"
  type        = list(string)
  default     = []
}

variable "price_class" {
  description = "Price class for the distribution"
  type        = string
  default     = "PriceClass_100"
}

variable "web_acl_id" {
  description = "Web ACL ID for WAF integration"
  type        = string
  default     = ""
}

variable "s3_domain_name" {
  description = "Domain name of the S3 bucket origin"
  type        = string
}

variable "alb_domain_name" {
  description = "Domain name of the ALB origin for API requests"
  type        = string
}

variable "logs_bucket_domain_name" {
  description = "Domain name of the S3 bucket for logs"
  type        = string
}

variable "logs_prefix" {
  description = "Prefix for CloudFront logs"
  type        = string
  default     = "cloudfront/"
}

variable "web_acl_arn" {
  description = "ARN of the WAF Web ACL to associate with CloudFront"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
