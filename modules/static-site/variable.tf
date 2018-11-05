variable "bucket_acl" {
    default = ""
}

variable "domain_name" {
    default = ""
}

variable "bucket_policy" {
    default = ""
}

variable "cdn_enabled" {
  default = true
}

variable "cdn_ipv6_enabled" {
    default = true
}

variable "cdn_default_root" {
    type = "string"
    default = ""
}

variable "cdn_domain_aliases" {
    type = "list"
}

variable "cdn_viewer_protocol_policy" {
    type = "string"
    default = "allow-all"
}

variable "cdn_acm_certificate_arn" {
    type = "string"
    default = ""
}

variable "route53_record_type" {
    default = "A"
}

variable "route53_target_health" {
    default = "true"
}