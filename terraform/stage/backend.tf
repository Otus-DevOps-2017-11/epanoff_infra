terraform {
  backend "gcs" {
    bucket  = "infra-terraform-state-file"
    path    = "/terraform.tfstate"
  }
}
