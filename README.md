# cheqd-infra

## Description

This repo cointains the AWS services needed to recreate the nodes infrastructure.

## Prerequisites

- AWS account with secret key and access key.
- aws configure (command line)

```
aws configure
 ```

## Step 1:

Download the repo:
 ```
git clone git@github.com:cheqd/cheqd-infra.git
 ```

## Step 2:

Configure the variables.tf form with your AWS account settings.

```
env = environment of your project.

cidr_block = of your vpc.

region = region of your project in aws.

projectname = name of your project.

docker_image_url = url of the current docker image.

generis_secret_arn = arn of your genesis variable set in secrets manager.

node_key_secret_arn = arn of your node_key variable set in secrets manager.

priv_validator_key_secret_arn = arn of your priv_validator_key variable set in secrets manager.

```

## Step 3:

Copy the folder with the "node_configs" into the root of the repo.

## Step 4:

Initialize Terraform
```
terraform init
 ```

## Step 5:

Plan the changes
```
terraform plan
 ```

## Step 6:

Apply the changes
```
terraform apply
 ```

## Step 7:

Check the services in ECS
