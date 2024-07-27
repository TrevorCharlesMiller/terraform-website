THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Terraform Website Module

## Introduction
This repository contains a reusable Terrform module to create infrastructure on AWS and Cloudflare for a website.

## About


### Built With
- (AWS Command Line Interface 2.8.5) [https://aws.amazon.com/cli/]
- (Terraform 1.5.3)[https://www.terraform.io]

## Architecture
![Architecture](architecture.png)

## Getting Started

### Prerequisites
Ensure that you have the AWS CLI installed and configured correctly. Also ensure that you have installed Terraform.

You should be able to run the following command without error
```sh
aws s3 ls
```

### Create Infrastructure on AWS

Register your domain through AWS Route 53. Once your domain is registered a new Hosted Zone will be created with two default records. There is no need for this hosted zone and so you can go ahead an delete this as it will cost you $0.50c a month.

[Terraform](https://www.terraform.io) is used to create the necessary infrastructure on AWS.


### Steps to Run Terraform

You will need to update your domain name and hosted zone id in the terraform variables file: `terraform.tfvars`.

Change into the `infrastructure` directory and initialize Terraform
```sh
cd infrastructure
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
