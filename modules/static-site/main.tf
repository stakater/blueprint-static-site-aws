module "s3bucket_gocarbook" {
  source = "github.com/stakater/blueprint-storage-aws.git//modules/s3/public"
  name = "${var.name}"
  acl = "${var.acl}"
  policy = "${var.policy}"
  index_document = "${var.index_document}"
  redirect_all_requests_to = "${var.redirect_all_requests_to}"
}