terraform {
  // required_version = "1.5.1"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "3.29.0"
    }
  }
}

# New Relic provider
provider "newrelic" {
  account_id = var.account_id
  api_key = var.api_key   # usually prefixed with 'NRAK'
  region = var.region     # Valid regions are US and EU
}

# Data source for New Relic entity
data "newrelic_entity" "hostname" {
  name = var.hostname     # This must be an exact match of your entity in New Relic (case-sensitive)
  type = "HOST"
  domain = "INFRA"
}
