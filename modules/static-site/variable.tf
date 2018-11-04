variable "bucket_gocarbook_name" {
    default = ""
}

variable "bucket_gocarbook_acl" {
    default = ""
}

variable "bucket_wwwgocarbook_name" {
    default = ""
}

variable "bucket_wwwgocarbook_acl" {
    default = ""
}

variable "bucket_wwwgocarbook_policy" {
    default = ""
}

variable "cloudfront_enabled" {
  default = true
}

variable "cloudfront_ipv6_enabled" {
    default = true
}

variable "cloudfront_default_root_object" {
    type = "string"
    default = ""
}

variable "cloudfront_domain_aliases" {
    type = "list"
}

variable "cloudfront_viewer_protocol_policy" {
    type = "string"
    default = "allow-all"
}

variable "cloudfront_acm_certificate_arn" {
    type = "string"
    default = ""
}

variable "route53_record_gocarbook_type" {
    default = "A"
}

variable "route53_record_gocarbook_target_health" {
    default = "true"
}

variable "route53_record_www_gocarbook_type" {
    default = "A"
}

variable "route53_record_www_gocarbook_target_health" {
    default = "true"
}