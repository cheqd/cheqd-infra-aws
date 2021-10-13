# cheqd: DevOps & Infrastructure Docs

**cheqd** is a purpose-built network for decentralised identity.

[**`cheqd-node`**](https://github.com/cheqd/cheqd-node) is the server/node portion of the cheqd network stack, built using [Cosmos SDK](https://github.com/cosmos/cosmos-sdk) and [Tendermint](https://github.com/tendermint/tendermint).

**`cheqd-infra`** is set of infrastructure & DevOps tooling assets for accelerating the deployment of complex `cheqd-node` installations in cloud hosting providers.

Currently, AWS is the only supported cloud platform supported in this set of DevOps assets. We hope to support other cloud platforms in the future and welcome contributions from the open source-community from anyone who wants to contribute automation assets.

## Usage

Our [guide to using cheqd-infra on AWS](docs/README.md) gives a walkthrough of the steps needed to deploy cheqd nodes on existing cheqd networks such as the cheqd testnet.

### Currently supported functionality

* Deploy `cheqd-node` using AWS Fargate on AWS Elastic Container Service (ECS)
* Deploy all associated Virtual Private Cloud configuration (subnets, load balancers, etc) in AWS region of your choice
* Logging through AWS CloudWatch
* Storing secrets via AWS Secrets Manager

### Upcoming functionality

A non-exhaustive list of future planned functionality (not necessarily in order of priority) is highlighted below:

* Deploying nodes in multiple regions
* Air-gapping validator nodes behind external-facing sentry nodes
* Monitoring and alerting

We plan on adding new functionality rapidly and on a regular basis. We are also exploring mechanisms to showcase our product roadmap and gather feedback from our community members. We welcome feedback on our [cheqd Community Slack](http://cheqd.link/join-cheqd-slack) workspace.

## Community

The [**cheqd Community Slack**](http://cheqd.link/join-cheqd-slack) is our chat channel for the open-source community, software developers, and node operators.

Please reach out to us there for discussions, help, and feedback on the project.

### Social media

Follow the cheqd team on our social channels for news, announcements, and discussions.

* [@cheqd\_io](https://twitter.com/cheqd_io) on Twitter
* [@cheqd](https://t.me/cheqd) on Telegram \(with a separate [announcements-only channel](https://t.me/cheqd_announcements)\)
* [Medium](https://blog.cheqd.io/) blog
* [LinkedIn](http://cheqd.link/linkedin)
