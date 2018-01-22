variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable machine_type {
  description = "machine_type"
  default     = "g1-small"
}

variable private_key_path {
  description = "Path to the private key used for provisoners  ssh access"
}

variable db_address {
  default = "127.0.0.1"
}
