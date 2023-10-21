
# ebase-project

To provision the infrastructure, confirm that you have the aws cli installed and your access keys configured.
To install the aws cli, head to the documentation link below to install the CLI on Linux

`https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html`

Configure your access keys with the below command on your linux machine

`aws configure`











## Bash Script

The bash script, provisions the EKS cluster by provisioning the Terraform infrasctructure. It performs this by first installing `kubectl` on the linux machine, then provision the EKS infrasctructure, by executing the terraform commands to apply the infrasctructure.

Finnally, to run the python application on the alreacy provisioned infrasctructure, the bash script applies a kubernetes `deployment`, and then applies a `service` to expose the pods to the outside world. 
Finnally, run `kubectl get svc` to see the service provisioned. you'll find a load balancer link in `External Ip` of the service. Access the link on you browser to veiw the python application.    