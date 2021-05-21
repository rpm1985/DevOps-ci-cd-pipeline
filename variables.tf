variable "flavor" { default = "m1.large" }
variable "image" { default = "Cent OS 8.1.1911 20200113" }

variable "name1" { default = "CentOS 1" }
variable "name2" { default = "CentOS 2" }
variable "keypair" { default = "cloudKey" } # you may need to change this
variable "pool" { default = "cscloud_private_floating" }
variable "project_script" { default = "./project.sh" }
variable "jenkins_script" { default = "./jenkins.sh" }
variable "security_description" { default = "Terraform security group" }
variable "security_name" { default = "tf_security" }