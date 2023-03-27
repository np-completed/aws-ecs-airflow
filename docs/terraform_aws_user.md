# create user in AWS for terraform

We want to build infra in AWS using terraform. For this we need an AWS user.

- Create AWS user in IAM and attach policy with admin access
- Select CLI for method of access  
- Save access key and  secret access key

Note that the usual and recommended way to authenticate to AWS when using Terraform is via the AWS CLI, rather than any of the provider options listed above. To do this, first, install the AWS CLI, then type `aws configure`.

- invoke poetry virtual environment  

The best terraform tutorial https://www.youtube.com/watch?v=iRaai1IBlB0 This includes set up for aws config with vscode.

--------

## Check .aws folder

The config file keeps are secret and key.

```shell
aws sts get-caller-identity

{
    "UserId": "AIDAYMYFUCQM7K2RD9DDD",
    "Account": "111147549871",
    "Arn": "arn:aws:iam::111147549871:user/myself"
}
```


## Install Terraform

[hashicorp terraform install docs](https://developer.hashicorp.com/terraform/downloads)

```shell
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

## Environment Variables

Authenticate to AWS account using terraform user.

To use the environment variables option to authenticate, credentials can be provided by using the `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and optionally `AWS_SESSION_TOKEN` environment variables. The region can be set using the `AWS_REGION` or `AWS_DEFAULT_REGION` environment variables.

In this case, the provider configuration options block would be empty, as the credentials needed for authentication are supplied at the system level (i.e., these are local to the system you are running Terraform from). This is safer than hardcoding your secrets and tokens in the configuration files.

`provider "aws" {}`
In the command shell, the environment variables are set as follows:

```shell
export AWS_ACCESS_KEY_ID="my-access-key"
export AWS_SECRET_ACCESS_KEY="my-secret-key"
export AWS_REGION="us-east-1"
```

Alternatively, a token can be used instead of Key ID and Access Key:

`$ export AWS_SESSION_TOKEN="my-token"`

This might be a useful option when running Terraform from a build agent in a [CI/CD pipeline](https://spacelift.io/blog/ci-cd-pipeline).

### Terraform provider.tf

Use environment variables for AWS auth

```json
provider "aws" {
  region  =  "us-east-1"
}

/* provider "aws" {
  region     = "us-east-1"
  access_key = " "
  secret_key = " "
} */
```

> If you look carefully in the provider block then we have only defined `region` while the credentials are being fetched from environment variables.
