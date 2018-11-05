module "s3bucket_host" {
  source = "github.com/stakater/blueprint-storage-aws.git//modules/s3/public/host"
  name = "${format("%s%s", "www.", var.domain_name)}"
  acl = "${var.bucket_acl}"
  policy = "${var.bucket_policy}"
}
module "s3bucket_redirect" {
  source = "github.com/stakater/blueprint-storage-aws.git//modules/s3/public/redirect"
  name = "${var.domain_name}"
  acl = "${var.bucket_acl}"
  redirect_all_requests_to = "${module.s3bucket_host.bucket_name}"
}
module "cloudfront_s3" {
    source = "github.com/stakater/blueprint-utilities-aws.git//modules/cloudfront"
    bucket-domain-name = "${module.s3bucket_host.bucket_domain_name}"
    bucket-id = "${module.s3bucket_host.bucket_name}"
    enabled = "${var.cdn_enabled}"
    ipv6-enabled= "${var.cdn_ipv6_enabled}"
    default-root-object = "${var.cdn_default_root}"
    domain-aliases = "${var.cdn_domain_aliases}"
    viewer-protocol-policy = "${var.cdn_viewer_protocol_policy}"
    acm-certificate-arn = "${var.cdn_acm_certificate_arn}"
}
module "route53_hostedzone" {
    source = "github.com/stakater/blueprint-utilities-aws.git//modules/route53/public"
    public_domain = "${module.s3bucket_redirect.bucket_name}"
}
module "route53_record_redirect_bucket" {
  source = "github.com/stakater/blueprint-utilities-aws.git//modules/route53/record"
  zone_id = "${module.route53_hostedzone.zone_id}"
  name = "${module.s3bucket_redirect.bucket_name}"
  type = "${var.route53_record_type}"
  alias_name = "${module.s3bucket_redirect.website_domain}"
  alias_zone_id = "${module.s3bucket_redirect.hosted_zone_id}"
  target_health = "${var.route53_target_health}"
}
module "route53_record_cloudfront-host" {
  source = "github.com/stakater/blueprint-utilities-aws.git//modules/route53/record"
  zone_id = "${module.route53_hostedzone.zone_id}"
  name = "${module.s3bucket_host.bucket_name}"
  type = "${var.route53_record_type}"
  alias_name = "${module.cloudfront_s3.cloudfront_domain_name}"
  alias_zone_id = "${module.cloudfront_s3.hosted_zone_id}"
  target_health = "${var.route53_target_health}"
}