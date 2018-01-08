variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Application zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Path to the private key used for provisoners  ssh access"
}

variable google_compute_instance_zone {
  description = "zone for google_compute_instance_zone app"
  default     = "europe-west1-b"
}

variable public_key {
	description = "the public key used for ssh access"
}

variable name {
  description = "Name for the forwarding rule and prefix for supporting resources"
  default     = "epanoff-infra"
}
