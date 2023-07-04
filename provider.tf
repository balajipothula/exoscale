# aws provider information.
provider "aws" {

  #alias = "exoscale_de-fra-1"

  region                      = "de-fra-1"              # Exoscale SOS (Simple Object Storage) Zone.
  access_key                  = var.exoscale_api_key    # Exoscale Cloud API Key.
  secret_key                  = var.exoscale_api_secret # Exoscale Cloud API Secret.
  max_retries                 = 5                       # The maximum number of times an API request is retried on retryable failure.
  skip_credentials_validation = true                    # Skip credentials validation via the STS API.
  skip_region_validation      = true                    # Skip validation of provided region name.
  skip_requesting_account_id  = true                    # Skip requesting the account ID.
  endpoints {                                           # Exoscale SOS (Simple Object Storage) Service Endpoint.
    s3 = "https://sos-de-fra-1.exo.io"                  # Custom endpoint for the AWS S3 API.
    #dynamodb = ""                                      # Custom endpoint for the AWS DynamoDB API.
  }
  default_tags {
    tags = {
      Developer      = "Balaji Pothula"
      DeveloperEmail = "balaji.pothula@techie.com"
    }
  }

}

# exoscale provider information.
provider "exoscale" {

  key     = var.exoscale_api_key    # Exoscale Cloud API Key.
  secret  = var.exoscale_api_secret # Exoscale Cloud API Secret.
  timeout = 300                     # Global async operations waiting time in seconds.

}

# postgresql provider information.
provider "postgresql" {

  alias            = "admin"    # Define multiple configurations for the same provider.
  host             = ""         # The address for the postgresql server connection.
  port             = 5432       # The port for the postgresql server connection.
  database         = "postgres" # Database to connect to. 
  username         = ""         # Username for the server connection.
  password         = ""         # Password for the server connection.
  superuser        = false      # PostgreSQL superuser.
  sslmode          = "require"  # Set the priority for an SSL connection to the server.
  connect_timeout  = 180        # Maximum wait for connection, in seconds.
  max_connections  = 20         # Set the maximum number of open connections to the database.
  expected_version = 14         # PostgreSQL Version.

}

# postgresql provider information.
provider "postgresql" {

  alias            = "readonly" # Define multiple configurations for the same provider.
  host             = ""         # The address for the postgresql server connection.
  port             = 5432       # The port for the postgresql server connection.
  database         = "postgres" # Database to connect to. 
  username         = "readonly" # Username for the server connection.
  password         = ""         # Password for the server connection.
  superuser        = false      # PostgreSQL superuser.
  sslmode          = "require"  # Set the priority for an SSL connection to the server.
  connect_timeout  = 180        # Maximum wait for connection, in seconds.
  max_connections  = 20         # Set the maximum number of open connections to the database.
  expected_version = 14         # PostgreSQL Version.

}
