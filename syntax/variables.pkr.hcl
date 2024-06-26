# variables.pkr.hcl
variable "foo" {
  type        = string
  default     = "the default value of the `foo` variable"
  description = "description of the `foo` variable"
  sensitive   = false
  # When a variable is sensitive all string-values from that variable will be
  # obfuscated from Packer's output.
}
