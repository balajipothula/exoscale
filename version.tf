terraform {

  # Terraform binary version.
  required_version = "1.4.5"

  required_providers {

    # Official terraform provider.
    aws = {
      source  = "hashicorp/aws"
      version = "4.62.0"
    }

    # Partner terraform provider.
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.48.0"
    }

    # Official terraform provider.
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.2"
    }

    # Partner terraform provider.
    github = {
      source  = "integrations/github"
      version = "5.21.1"
    }

    # Community terraform provider.
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.19.0"
    }

  }

  backend "s3" {

    region                      = "de-fra-1"                    # Exoscale region.
    bucket                      = "rstudio-mds"                 # Exoscale SOS (Simple Object Storage) bucket name.
    key                         = "terraform/terraform.tfstate" # Terraform State file name.
    encrypt                     = true                          # Enable server side encryption of the state file.
    endpoint                    = "https://sos-de-fra-1.exo.io" # Exoscale SOS (Simple Object Storage) service endpoint.
    skip_credentials_validation = true                          # Skip the credentials validation via STS API.
    skip_metadata_api_check     = true                          # Skip the AWS Metadata API check.
    skip_region_validation      = true                          # Skip static validation of region name.
    force_path_style            = true                          # A custom endpoint for the S3 API
    #dynamodb_table             = ""                                  # Name of DynamoDB Table to use for state locking and consistency.

  }

}
