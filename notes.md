# Getting started

Course done at Hinge. Udemy course [here](https://matchgroup.udemy.com/course/terraform-beginner-to-advanced/learn/lecture/32417372#overview)

## Choosing the right Infrastructure as code tool
- chef, puppet, terraform, ansible are all infrastructure as code candidates.
- ansible, chef, puppet are mainly config management tools which means that they are primarily designed to install and manage software on existing servers
- terraform, cloudformation (aws) are infra orchestration tools which means they can provision the servers themselves, not setup the software on the servers.
- config management CAN do some infra provisioning but terraform is better.
- terraform can create ec2 instances in AWS. a response is sent back to terraform when it succeeds (see image below).

![terraform1](images/terraform1.png)

- terraform can then call ansible to install software or an application once ec2 instance is provisioned. neat huh?
- so infrastructure as code (IAC) can support configuration management tools like Ansible.


Questions to ask when choosing the right tool?
1. are you vendor specific like AWS? If so maybe use CloudFormation?
2. Are you planning multi-cloud? Then maybe don't use CloudFormation?
3. How well was your IAC with Configuration Management tools
4. cost? Terraform is free.

Terraform is great for all of the above. Terraform supports multiple platforms like AWS, Heroku, Akamai, Google Cloud, Pagerduty, Grafana, etc.


## Installation

- download binary, use it. it's from Hashicorp.
- or install using brew.

# Deploying Infrastructure with Terraform

let's write some terraform!

The core Terraform workflow consists of three stages:

Write: You define resources, which may be across multiple cloud providers and services. For example, you might create a configuration to deploy an application on virtual machines in a Virtual Private Cloud (VPC) network with security groups and a load balancer.

Plan: Terraform creates an execution plan describing the infrastructure it will create, update, or destroy based on the existing infrastructure and your configuration.

Apply: On approval, Terraform performs the proposed operations in the correct order, respecting any resource dependencies.

## Creating first EC2 instance with Terraform

Let's think about:
1. How will you auth to AWS?
2. Which region does the resource need to be launched?
3. what resource?

You can use static creds like this in your terraform file:

```terraform
provider "aws" {
  region  = "us-west-2"
}
```

The provider block configures the specified provider, in this case aws. A provider is a plugin that Terraform uses to create and manage your resources.

You can use multiple provider blocks in your Terraform configuration to manage resources from different providers. You can even use different providers together. 


Once you setup the `first_ec2.tf` file fully, you can run:

`terraform init` which will read the provider and setup aws and install hashicorp/aws.

then run `terraform plan`. It will list out what terraform will try to create based on your resources blocks.

then run `terraform apply`. You can then accept to create the resources. it will actually create the resources (the ec2 instance in this case.)


### Points to remember:

- each provider has its own resources. For ex, AWS has several different resources (ec2, lambda, rds, etc.) than can be created with Terraform.

- resources like ec2 have different arguments to configure. required or optional arguments.

### Commands:

1. `terraform init`
2. `terraform plan`
3. `terraform apply`

## Understanding Providers and Resources

Terraform supports a lot of providers: GCP, AWS, Alibaba cloud, kubernetes, Azure
you need to make use of these providers if you want different infrastructure from different providers. 750 providers.

`terraform init` downloads the plugins for that provider.

Resources: they are a reference to the services that the provider has to offer. Ex: aws_instance, cloudfront, aws_alb, iam_user

One note: from Terraform 0.13 onwards, you need to specify the resource of the provider using different syntax:

```terraform
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}
```


## Understanding Providers and Resources Part 2

Github is also a provider

You can create repos using Terraform. Branches team, user ssh keys, etc.
