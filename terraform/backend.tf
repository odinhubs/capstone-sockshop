terraform {
  backend "s3" {
    bucket         = "neyo-capstone-remote-backend"
    key            = "terraform-aws-eks-workshop.tfstate"
    region         = "eu-west-2"
  }
}
