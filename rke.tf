variable "rancher_agent_token" {}
variable "rancher_agent_version" {
  default = ""
}
variable "rancher_url" {}

variable "cluster_name" {}
variable "cluster_cp_count" {
  default = 1
  type    = number
}

variable "cluster_worker_count" {
  default = 0
  type    = number
}

resource "hcloud_server" "downstream_cp" {
  count = var.cluster_cp_count

  name        = "${var.cluster_name}${count.index + 1}"
  image       = "debian-11"
  location    = "fsn1"
  server_type = "cx21"
  ssh_keys    = [data.hcloud_ssh_key.markus.id]

  # lifecycle {
  #   ignore_changes = [
  #     user_data,
  #   ]
  # }

  user_data = templatefile("rancher-agent.user-data.yml", {
    rancher_agent_token   = var.rancher_agent_token,
    rancher_url           = var.rancher_url,
    rancher_agent_version = var.rancher_agent_version,
    rancher_agent_cp      = true,
    rancher_agent_worker  = true,
  })
}


resource "hcloud_server" "downstream_worker" {
  count = var.cluster_worker_count

  name        = "${var.cluster_name}-worker${count.index + 1}"
  image       = "debian-11"
  location    = "fsn1"
  server_type = "cx21"
  ssh_keys    = [data.hcloud_ssh_key.markus.id]

  # lifecycle {
  #   ignore_changes = [
  #     user_data,
  #   ]
  # }

  user_data = templatefile("rancher-agent.user-data.yml", {
    rancher_agent_token   = var.rancher_agent_token,
    rancher_url           = var.rancher_url,
    rancher_agent_version = var.rancher_agent_version,
    rancher_agent_cp      = false,
    rancher_agent_worker  = true,
  })
}
