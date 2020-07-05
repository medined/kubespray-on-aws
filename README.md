# KubeSpray On AWS

This project uses an AWS jump box in order to provision a Kubernetes cluster using KubeSpray. Terraform is used to spin up a CentOS server (jump box), then that server is used to provision the cluster nodes and install kubernetes.

A note of caution. The cluster state is stored on the jump box. So don't terminate it before destroying the cluster. You can use `./run-99-destroy-playbook.sh`. 

This work is being done at the request of the Enterprise Container Working Group (ECWG) of the Office of Information and Technology (OIT - https://www.oit.va.gov/) at the Department of Veteran Affairs.

## Current Failure

The project is currently failing because of the following issue when the `playbook-02-kubespray.yml` playbook is run.

```
TASK [download_file | Download item] **********************************************************************************************************************************************************************
Sunday 05 July 2020  15:04:26 +0000 (0:00:00.163)       0:02:26.273 *********** 
fatal: [kubernetes-flooper-master0]: FAILED! => {"msg": "'hostvars' is undefined"}
```

## Clone

```bash
git clone https://github.com/medined/kubespray-on-aws.git
cd kubespray-on-aws
```

## Configure

Copy the example, then edit the file to enter your specific values.

```bash
cp variables.tf.example variables.tf
```

## Python Setup (Local)

```bash
sudo yum install -y python3 python3-pip
pip3 install --user pipenv
python3 -m venv venv
source venv/bin/activate
pip install wheel ansible netaddr
```

## Terraform

* Intialize terraform.

```bash
terraform init
```

* Apply the terraform plan. This is creates all of the AWS infrastructure that is needed; including creating a VPC.

```bash
terraform apply --auto-approve
```

## KubeSpray

```bash
./run-02-kubespray-playbook.sh
```

**It's during this step that you'll see the hostvars error.**

You can use `ssh-to-server.sh` to SSH to the jump box.

