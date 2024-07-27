variable "env" {
    description = "Environment name, can be used to create a test or prod environment"
}

variable "domain_name" {
    description = "Domain name of the website to create"
}

variable "aliases" {
    type = list(string)
    description = "Alias domains to use for Cloudfront distribution"
}

variable "subject_alternative_names" {
    type = list(string)
    description = "SANs to use for the ACM certificate"
}

variable "web_acl_id" {
    description = "ID of an AWS WAF web acl to only allow traffic from Cloudflare"
}

variable "cf_zone_id" {
    description = "Cloudflare zone id to create DNS records in"
}

variable "cf_records" {
    type = list(string)
    description = "List of all the cloudflare dns records to create"
}

variable "min_ttl" {
    description = "Minimum TTL in seconds for the cloudfront cache"
}
variable "default_ttl" {
    description = "Default TTL in seconds for the cloudfront cache"
}
variable "max_ttl" {
    description = "Maximum TTL in seconds for the cloudfront cache"
}

variable "public_api_gw_deployment_invoke_url" {
    description = "API Gateway invoke URL used as cloudfront origin mapped to /api path"
}