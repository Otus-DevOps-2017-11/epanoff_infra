terraform {
  backend "gcs" {
    bucket  = "infra-terraform-state"
    path    = "/terraform.tfstate"
  }
}
