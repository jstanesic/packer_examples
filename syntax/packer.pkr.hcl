# Contains config of packer itself
# Define a plugin
packer {
  required_plugins {
    happycloud = {
      version = ">= 2.7.0"
      source  = "github.com/hashicorp/happycloud"
    }
  }
}
