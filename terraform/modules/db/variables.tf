variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "Application zone"
  default     = "europe-west1-b"
}

variable machine_type {
  description = "machine_type"
  default = "g1-small"
}

variable private_key_path {
  description = "Path to the pivate key used for ssh access"
}