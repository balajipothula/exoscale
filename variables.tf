variable "region" {
  type        = string
  default     = "de-fra-1"
  description = "Exoscale SOS (Simple Object Storage) Region to store Terraform State."
  validation {
    condition     = var.region != null && length(regexall("[^a-z-a-z-0-9]", var.region)) == 0
    error_message = "Error: region value must not null and region must consist of alphabets, hyphens and numbers only."
  }
  sensitive = false
}

variable "exoscale_api_key" {
  type        = string
  default     = null
  description = "Exoscale API Key which is stored in GitHub secrets."
  sensitive   = true
}

variable "exoscale_api_secret" {
  type        = string
  default     = null
  description = "Exoscale API Secret which is stored in GitHub secrets."
  sensitive   = true
}

variable "exoscale_zone" {
  type        = string
  default     = "de-fra-1"
  description = "Exoscale zone to launch your resources."
  validation {
    condition     = var.exoscale_zone != null && length(regexall("[^a-z-a-z-0-9]", var.exoscale_zone)) == 0
    error_message = "Error: zone value must not null and zone must consist of alphabets, hyphens and numbers only."
  }
  sensitive = false
}

# User defined argument.
variable "exoscale_zone_map" {
  type = map(string)
  default = {
    "Frankfurt" = "de-fra-1"
    "Munich"    = "de-muc-1"
    "Vienna"    = "at-vie-1"
    "Geneva"    = "ch-gva-2"
    "Zurich"    = "ch-dk-2"
    "Sofia"     = "bg-sof-1"
  }
  description = "A map of Exoscale zones."
  validation {
    condition     = var.exoscale_zone_map != null && 0 < length(var.exoscale_zone_map) && length(var.exoscale_zone_map) < 7
    error_message = "Error: exoscale_zone_map has at least one or more elements expected upto 6."
  }
  sensitive = false
}
