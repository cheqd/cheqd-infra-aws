# cheqd-infra

## Description

This repo cointains the AWS services needed to recreate the nodes infrastructure.

## Prerequisites

### AWS account access key ID and secret access key. [Link](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-creds)

Access key ID and secret access key
Access keys consist of an access key ID and secret access key, which are used to sign programmatic requests that you make to AWS. If you don't have access keys, you can create them from the AWS Management Console. As a best practice, do not use the AWS account root user access keys for any task where it's not required. Instead, create a new administrator IAM user with access keys for yourself.

The only time that you can view or download the secret access key is when you create the keys. You cannot recover them later. However, you can create new access keys at any time. You must also have permissions to perform the required IAM actions. For more information, see Permissions required to access IAM resources in the IAM User Guide.

To create access keys for an IAM user

Sign in to the AWS Management Console and open the [IAM console at](https://console.aws.amazon.com/iam/).

In the navigation pane, choose Users.

Choose the name of the user whose access keys you want to create, and then choose the Security credentials tab.

In the Access keys section, choose Create access key.

To view the new access key pair, choose Show. You will not have access to the secret access key again after this dialog box closes. Your credentials will look something like this:

```bash
Access key ID: AKIAIOSFODNN7EXAMPLE

Secret access key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

To download the key pair, choose Download .csv file. Store the keys in a secure location. You will not have access to the secret access key again after this dialog box closes.

Keep the keys confidential in order to protect your AWS account and never email them. Do not share them outside your organization, even if an inquiry appears to come from AWS or Amazon.com. No one who legitimately represents Amazon will ever ask you for your secret key.

After you download the .csv file, choose Close. When you create an access key, the key pair is active by default, and you can use the pair right away.

### Install in your asset the [aws_cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

Quick configuration with aws configure
For general use, the aws configure command is the fastest way to set up your AWS CLI installation. When you enter this command, the AWS CLI prompts you for four pieces of information:

* Access key ID

* Secret access key

* AWS Region

* Output format

The AWS CLI stores this information in a profile (a collection of settings) named default in the credentials file. By default, the information in this profile is used when you run an AWS CLI command that doesn't explicitly specify a profile to use. For more information on the credentials file, see Configuration and credential file settings

The following example shows sample values. Replace them with your own values as described in the following sections.

Example:

```bash
$ aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json
```

## Step 1

Download the repo:

 ```bash
git clone git@github.com:cheqd/cheqd-infra.git
 ```

## Step 2

Configure the variables.tf form with your AWS account settings.

```bash
env = environment of your project.

cidr_block = of your vpc.

region = region of your project in aws.

projectname = name of your project.

docker_image_url = url of the current docker image.

generis_secret_arn = arn of your genesis variable set in secrets manager.

node_key_secret_arn = arn of your node_key variable set in secrets manager.

priv_validator_key_secret_arn = arn of your priv_validator_key variable set in secrets manager.

```

## Step 3

Copy the folder with the "node_configs" into the root of the repo.

## Step 4

Initialize Terraform

```bash
terraform init
 ```

## Step 5

Plan the changes

```bash
terraform plan
 ```

## Step 6

Apply the changes

```bash
terraform apply
 ```

## Step 7

Check the services in ECS
