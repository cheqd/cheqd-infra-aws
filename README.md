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
