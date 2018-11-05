# blueprint-static-site-aws
A repo for creating a static web site deployment stack using aws s3 bucket, route53, and cloudfront. 

Cotains the following modules:

* **s3bucket_host** = creates a s3 bucket with name www.domainname, and will contain the static website to host

* **s3bucket_redirect** = creates a s3 bucket with name domainname, and will only be used to redirect users to www.domainname

* **cloudfront_s3** = creates a cloudfront distribution for the created host bucket

* **route53_hostedzone** = creates a hosted zone for the domain

* **route53_record_redirect_bucket** = creates a record entry in the above created zone for redirect bucket

* **route53_record_cloudfront-host** = creates a record entry in the above created zone for cloud front