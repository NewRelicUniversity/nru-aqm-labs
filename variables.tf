# your New Relic account ID 
variable "account_id" {
  default = "XXXXXX"
}

# your User API key
variable "api_key" {
  default = "XXXXXX"
}

# valid regions are US and EU
variable "region" {
  default = "US"
}

# hostname reporting to New Relic 
variable "hostname" {
  default = "nru-aqm-lab"
}

# your email address to send notification 
variable "email" {
  default = "username@example.com"
}