terraform {
  backend "s3" {
    bucket       = "usecases-terraform-state-bucket"
    key          = "custom-usecase/statefile.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    # use_lockfile = true
  }
}