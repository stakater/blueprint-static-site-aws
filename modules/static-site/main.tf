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

