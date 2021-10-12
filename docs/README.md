# Guide to setting up cheqd node infrastructure on AWS

## Prerequisite steps

1. [Setup AWS CLI](aws-cli-setup.md) (only needed if you don't already have AWS CLI installed on your machine)
2. Install [Terraform](https://www.terraform.io/downloads.html) on your machine (if you don't already have it)
3. Download / clone the `cheqd-infra` Github repo

## Installation steps

### Step 1: Define variables

The variables to be defined are:

* node-key
* priv-validator-key
* genesis

```bash
base64 genesis.json
```

[Secrets Manager Tutorial](https://docs.aws.amazon.com/secretsmanager/latest/userguide/tutorials_basic.html)

Once you set the 3 variables in the AWS Secrets Manager you will be able to continue.

## Step 2: Configure the variables.tf form with your AWS account settings

```text
env = environment value of your project. Example: 'prod'

projectname = name of your project. Example: 'cheqd'

docker_image_url = url of the current docker image. 
```

## Step 3: Initialize Terraform

Run this command in your console:

```bash
terraform init
```

## Step 4:  Plan the changes

Run this command in your console:

```bash
terraform plan
```

The application will ask to fill the following variables:

```text
cidr_block = of your vpc. Example: '10.9.0.0/16'

region = region of your project in aws. Example: 'eu-west-1'

genesis = base64 genesis variable.

node_key = base64 node_key variable.

priv_validator_key = base64 priv_validator_key variable.

genesis_seed = base64 genesis variable for the seed node.

node_key_seed = base64 node_key variable for the seed node.

priv_validator_seed = base64 priv_validator_key variable for the seed node.

```

## Step 5: Apply the changes

Run this command in your console:

```bash
terraform apply
```

The application will ask to fill the following variables:

```text
cidr_block = of your vpc. Example: '10.9.0.0/16'

region = region of your project in aws. Example: 'eu-west-1'

generis = base64 genesis variable.

node_key = base64 node_key variable.

priv_validator_key = base64 priv_validator_key variable.

generis_seed = base64 genesis variable for the seed node.

node_key_seed = base64 node_key variable for the seed node.

priv_validator_seed = base64 priv_validator_key variable for the seed node.

```

## Step 7: Check if the cluster is running

Check the services in ECS, if you can see the cluster, the service and the task running.
