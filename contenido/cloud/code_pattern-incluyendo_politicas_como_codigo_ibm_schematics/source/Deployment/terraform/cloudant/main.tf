terraform {
    required_providers {
        ibm = {
            source = "IBM-Cloud/ibm"
            version = "~> 1.31.0"
        }             
    }
}

provider "ibm" {
    region = "us-south"
}


data "ibm_resource_group" "group" {
  name = var.resource_group
}

resource "ibm_resource_instance" "ecommerce_cloudant" {
  name              = "${var.base_name}-cloudant"
  service           = "cloudantnosqldb"
  plan              = var.plan
  location          = var.region
  resource_group_id = data.ibm_resource_group.group.id
  tags              = (var.tags != null ? var.tags : [])
}

resource "ibm_resource_key" "cloudant_resourcekey" {
  name                 = "cloudant_resourcekey"
  role                 = "Writer"
  resource_instance_id = ibm_resource_instance.ecommerce_cloudant.id
}


resource "ibm_resource_key" "cloudant_resourcekey2" {
  name                 = "cloudant_resourcekey2"
  role                 = "Writer"
  resource_instance_id = ibm_resource_instance.ecommerce_cloudant.id
}

resource "ibm_resource_key" "cloudant_dbcreator" {
  name                 = "cloudant_dbcreator"
  role                 = "Manager"
  resource_instance_id = ibm_resource_instance.ecommerce_cloudant.id
}