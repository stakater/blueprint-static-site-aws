module "s3bucket_www_gocarbook" {
  source = "github.com/stakater/blueprint-storage-aws.git//modules/s3/public/host"
  name = "${var.bucket_wwwgocarbook_name}"
  acl = "${var.bucket_wwwgocarbook_acl}"
  policy = "${var.bucket_wwwgocarbook_policy}"
}
module "s3bucket_gocarbook" {
  source = "github.com/stakater/blueprint-storage-aws.git//modules/s3/public/redirect"
  name = "${var.bucket_gocarbook_name}"
  acl = "${var.bucket_gocarbook_acl}"
  redirect_all_requests_to = "${module.s3bucket_www_gocarbook.bucket_name}"
}

module "cloudfront_gocarbook" {
    source = "github.com/stakater/blueprint-utilities-aws.git//modules/cloudfront"
    bucket-domain-name = "${module.s3bucket_www_gocarbook.bucket_domain_name}"
    bucket-id = "${module.s3bucket_www_gocarbook.bucket_name}"
    enabled = "${var.cloudfront_enabled}"
    ipv6-enabled= "${var.cloudfront_ipv6_enabled}"
    default-root-object = "${var.cloudfront_default_root_object}"
    domain-aliases = "${var.cloudfront_domain_aliases}"
    viewer-protocol-policy = "${var.cloudfront_viewer_protocol_policy}"
    acm-certificate-arn = "${var.cloudfront_acm_certificate_arn}"
}

module "route53_hostedzone_gocarbook" {
    source = "github.com/stakater/blueprint-utilities-aws.git//modules/route53/public"
    public_domain = "${module.s3bucket_gocarbook.bucket_name}"
}

module "route53_record_gocarbook" {
  source = "github.com/stakater/blueprint-utilities-aws.git//modules/route53/record"
  zone_id = "${module.route53_hostedzone_gocarbook.zone_id}"
  name = "${module.s3bucket_gocarbook.bucket_name}"
  type = "${var.route53_record_gocarbook_type}"
  alias_name = "${module.s3bucket_gocarbook.website_domain}"
  alias_zone_id = "${module.s3bucket_gocarbook.hosted_zone_id}"
  target_health = "${var.route53_record_gocarbook_target_health}"
}

module "route53_record_www_gocarbook" {
  source = "github.com/stakater/blueprint-utilities-aws.git//modules/route53/record"
  zone_id = "${module.route53_hostedzone_gocarbook.zone_id}"
  name = "${module.s3bucket_www_gocarbook.bucket_name}"
  type = "${var.route53_record_www_gocarbook_type}"
  alias_name = "${module.cloudfront_gocarbook.cloudfront_domain_name}"
  alias_zone_id = "${module.cloudfront_gocarbook.hosted_zone_id}"
  target_health = "${var.route53_record_www_gocarbook_target_health}"
}