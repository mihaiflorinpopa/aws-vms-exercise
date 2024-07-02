### Virtual Machines
locals {
  vm_names = [for i in range(var.instance_count) : format("%s-%d-%s", var.project, i, var.env)]
}

module "vm" {
  source = "./modules/vm"
  count  = var.instance_count

  env                    = var.env
  name                   = local.vm_names[count.index]
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_and_icmp.id]
  user_data              = data.template_file.cloud_init[count.index].rendered
  admin_password         = random_password.admin_password[count.index].result
}

### Ping next VM in index and copy ping_result.log locally from each VM, also renaming it the ping_result_*vm-name*.log
resource "null_resource" "ping_scp" {
  depends_on = [module.vm]
  count      = var.instance_count

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = module.vm[(count.index + 1) % var.instance_count].public_ip
      user     = "ubuntu"
      password = random_password.admin_password[(count.index + 1) % var.instance_count].result
      timeout  = "180s"
    }
    inline = [
      "sleep 10 && ping -c 3 ${module.vm[(count.index + 2) % var.instance_count].public_ip} > /tmp/ping_result.log"
    ]
  }
  provisioner "local-exec" {
    command = "sleep 10 && sshpass -p ${random_password.admin_password[(count.index) % var.instance_count].result} scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.user}@${module.vm[(count.index) % var.instance_count].public_ip}:/tmp/ping_result.log ./ping_results/ping_result_${local.vm_names[(count.index) % var.instance_count]}.log"
  }
}

### Random password generator for OS user
resource "random_password" "admin_password" {
  count = var.instance_count

  length  = 16
  special = false
}

### Cloud-init template to set admin password, enable SSH password authentication on VMs
data "template_file" "cloud_init" {
  count = var.instance_count

  template = file("./cloud-init/cloud-init.tpl")
  vars = {
    admin_password = random_password.admin_password[count.index].result
  }
}