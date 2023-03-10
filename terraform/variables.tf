variable "region_GRA11" {
  default = "GRA11"
  type    = string
}

variable "region_SBG5" {
  default = "SBG5"
  type    = string
}

variable "regions" {
   default = ["SBG5","GRA11"]
   type    = list
}

variable"i" {
   type = number
   default = 3
}

variable "instance_name_front" {
  type     = string 
  default  = "front_eductive22"
}

variable "instance_name_gra" {
  type     = string 
  default  = "backend_eductive22_gra"
}

variable "instance_name_sbg" {
  type    = string
  default = "backend_eductive22_sbg"
}

variable "image_name"{
  type    = string 
  default = "Debian 11"
}

variable "flavor_name" {
  type    = string 
  default = "s1-2"
}

variable "service_name" {
  type    = string
}
variable "vlan_id" {
  type    = number
  default = 22
}
variable "vlan_dhcp_start" {
  type = string
  default = "192.168.22.100"
}
variable "vlan_dhcp_end" {
  type = string
  default = "192.168.22.200"
}
variable "vlan_dhcp_network" {
  type = string
  default = "192.168.22.0/24"
}
