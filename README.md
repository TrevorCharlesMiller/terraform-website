# Terraform Website Module

## Table of Contents
- [Terraform Website Module](#terraform-website-module)
  - [Table of Contents](#table-of-contents)
  - [About The Project](#about-the-project)
    - [Built With](#built-with)
    - [Architecture](#architecture)
  - [Getting Started](#getting-started)
  - [Usage](#usage)
  - [Contributing](#contributing)
  - [License](#license)
  - [Limitation of Liability](#limitation-of-liability)

## Introduction
This repository contains a reusable Terrform module to create infrastructure on AWS and Cloudflare for a website.

## About


### Built With
- (AWS Command Line Interface 2.8.5) [https://aws.amazon.com/cli/]
- (Terraform 1.5.3)[https://www.terraform.io]

### Architecture
![Architecture](architecture.png)

## Getting Started

### Prerequisites
Ensure that you have the AWS CLI installed and configured correctly. Also ensure that you have installed Terraform.

You should be able to run the following command without error
```sh
aws s3 ls
```

### Create Infrastructure on AWS

Register your domain through AWS Route 53. Once your domain is registered a new Hosted Zone will be created with two default records. There is no need for this hosted zone and so you can go ahead an delete this as it may add to your monthly costs.

[Terraform](https://www.terraform.io) is used to create the necessary infrastructure on AWS.


### Steps to Run Terraform

This section will give you a quick rundown of the various Terraform commands.

To initialize Terraform
```sh
terraform init
```

Now run plan to see what changes Terraform will apply.
```sh
terraform plan
```

If you are happy with the changes you can apply them
```sh
terraform apply
```

You can destroy all the resources created if you no longer need them
```sh
terraform destroy
```

Note that DNS propagation can take a while so your website might not be reachable through the domain name until the newly created DNS records have propagated through the system. This can take up to 24h hours but usually takes about an hour or so.

## Usage

### Variables file
Create a variables.tf file as follows
```
variable "env" {}
variable "cloudflare_api_token" {}
variable "website_domain_name" {}
variable "website_cf_records" {
    type = list(string)
}
variable "website_cf_zone_id" {}
variable "cdn_min_ttl" {}
variable "cdn_default_ttl" {}
variable "cdn_max_ttl" {}
```

### Terraform tfvars file
Consider this example terraform.tfvars file
```
env                     = "prod"
cloudflare_api_token    = "..."
website_domain_name     = "example.com"
website_cf_records      = ["@", "www"]
website_cf_zone_id      = "..."
cdn_min_ttl             = "5"
cdn_default_ttl         = "60"
cdn_max_ttl             = "120"
```

### Main terrform file
Now in your main.tf file you can use the module as follow
```
module "website" {
  source = "https://github.com/trevorcharlesmiller/terraform-website"

  env=var.env
  domain_name=var.website_domain_name
  aliases=["${var.website_domain_name}","www.${var.website_domain_name}"]
  subject_alternative_names=["${var.website_domain_name}","www.${var.website_domain_name}"]
  web_acl_id=""
  cf_zone_id=var.website_cf_zone_id
  cf_records=var.website_cf_records
  min_ttl=var.cdn_min_ttl
  default_ttl=var.cdn_default_ttl
  max_ttl=var.cdn_max_ttl
}
```

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

## Limitation of Liability

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.