terraform {
  backend "gcs" {
    bucket  = "infra-189214"
    path    = "/terraform.tfstate"
    project = "infra-189214"
  }
}
