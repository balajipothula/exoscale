locals {

  zone             = "de-fra-1"
  ssh_pub_key_name = "balaji@significo.com"
  ssh_pub_key_path = "./pub/balaji@significo.com.pub"

  labels = {
    "Organization"   = "Significo"
    "Application"    = "Medical Data Science"
    "Division"       = "Digital Health"
    "Developer"      = "Balaji Pothula"
    "DeveloperEmail" = "balaji@significo.com"
  }

}

# Ubuntu 22.04 LTS (Jammy Jellyfish) OS Image.
data "exoscale_template" "jammy_jellyfish_template" {

  zone       = local.zone                      # Required argument.
  name       = "Linux Ubuntu 22.04 LTS 64-bit" # Optional argument, 🤜💥🤛 conflicts with `id`
  visibility = "public"                        # Optional argument.

}

# SSH Key.
module "significo_ssh_key" {

  source = "./terraform/exoscale/ssh_key"

  name       = local.ssh_pub_key_name       # Required argument, ❗ modification creates new resource.
  public_key = file(local.ssh_pub_key_path) # Required argument.

}

# Please keep `start_ip` 4ᵗʰ Octet decimal value must be greater than or equal to 5.
# Please keep `end_ip`   4ᵗʰ Octet decimal value must be less    than or equal to 250.
module "significo_private_network" {

  source = "./terraform/exoscale/private_network"

  zone        = local.zone                  # Required argument, ❗ modification creates new resource.
  name        = "significo-private-network" # Required argument.
  start_ip    = "10.0.0.5"                  # Required argument.
  end_ip      = "10.0.0.250"                # Required argument.
  netmask     = "255.255.255.0"             # Required argument.
  description = "Significo Private Network" # Optional argument.

}

# RStudio Medical Data Science Security Group.
module "rstudio_mds_security_group" {

  source = "./terraform/exoscale/security_group"

  name             = "rstudio-mds-sg"             # Required argument.
  description      = "RStudio MDS Security Group" # Optional argument.
  external_sources = ["0.0.0.0/0"]                # Optional argument.  

}

# RStudio Medical Data Science Security Group Rule for SSH (Secure SHell)
# and HTTPS (HyperText Transfer Protocol Secure) traffic.
module "rstudio_mds_ssh_https_sg_rule" {

  source = "./terraform/exoscale/security_group_rule"

  # This module depends on `mds_security_group` module.
  depends_on = [module.rstudio_mds_security_group]

  # Set of port numbers to be open.
  for_each = toset(["22", "80", "443", "8787"])

  security_group_id = module.rstudio_mds_security_group.id  # Required argument.
  type              = "INGRESS"                             # Required argument.
  protocol          = "TCP"                                 # Required argument.
  description       = "RStudio MDS Dev SSH, HTTPS SG Rule." # Optional argument, ❗ modification creates new resource.
  cidr              = "0.0.0.0/0"                           # Optional argument, 🤜💥🤛 conflicts with `user_security_group_id`.
  start_port        = each.key                              # Optional argument, 🤜💥🤛 conflicts with `icmp_code`.
  end_port          = each.key                              # Optional argument, 🤜💥🤛 conflicts with `icmp_code`, `icmp_type`.

}

# RStudio Medical Data Science Compute Instance.
module "rstudio_mds_compute_instance" {

  source = "./terraform/exoscale/compute_instance"

  zone               = local.zone                                         # Required argument,❗ modification creates new resource.
  name               = "rstudio-mds.significo.dev"                        # Required argument.
  template_id        = data.exoscale_template.jammy_jellyfish_template.id # Required argument,❗ modification creates new resource.
  type               = "standard.large"                                   # Required argument.
  disk_size          = 10                                                 # Optional argument,❗ modification stops or restarts instance.
  ipv6               = false                                              # Optional argument, ✓ but keep it.
  labels             = local.labels                                       # Optional argument, ✓ but keep it.
  state              = "running"                                          # Optional argument, ✓ but keep it.
  private            = false                                              # Optional argument, ✓ but keep it.
  security_group_ids = toset(module.rstudio_mds_security_group.*.id)      # Optional argument, ✓ but keep it. 
  ssh_key            = local.ssh_pub_key_name                             # Optional argument, ✓ but keep it.
  reverse_dns        = null                                               # Optional argument, ✓ but keep it.
  # Optional block, ✓ but keep it.
  network_interface_block = [{
    network_id = module.significo_private_network.id
    ip_address = "10.0.0.10"
  }]
  # Optional argument, ✓ but keep it. EOT (End of Transmission)
  user_data = file("./sh/install_docker.sh")

}

/*
# Copy Medical Data Science Team Member's SSH Public Keys into
# RStudio MDS Compute Instance  `authorized_keys` file.
resource "null_resource" "copy_ssh_authorized_keys" {

  depends_on = [module.rstudio_mds_compute_instance]

  provisioner "local-exec" {
    command = <<-EOT
      readonly USR=ubuntu
      readonly HOST=${module.rstudio_mds_compute_instance.public_ip_address}
      readonly PORT=22
      readonly PEM=$HOME/balaji@significo.com.pem
      # Note: Update new public key name.
      readonly PUB=./pub/martin@significo.com.pub
      cat $PUB | ssh -o CheckHostIP=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $PEM $USR@$HOST -p $PORT "cat >> ~/.ssh/authorized_keys"
    EOT
  }

  triggers = {
    # Note: Update new public key name.
    append_public_key = "martin@significo.com.pub"
  }

}
*/
