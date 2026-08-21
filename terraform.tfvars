nic = {
nic10 = {
nic_name = "nics10"
nic_rg = "rg1"
location = "centralindia"
nic_vnet = "vnet10"
nic_address  = ["10.0.0.0/16"]
nic_subnet = "frontend-subnet"
nic_subnet_address = ["10.0.1.0/24"]
nic_pip = "nic-pip10"
nic_config = "internal1"
nic_vm = "vm10"
nic_nsg = "nsg10"
rule_name = "SGR1"
nic_priority = "100"
}
nic20 = {
nic_name = "nics20"
nic_rg = "rg2"
location = "centralindia"
nic_vnet = "vnet20"
nic_address  = ["20.0.0.0/16"]
nic_subnet = "backend-subnet"
nic_subnet_address = ["20.0.1.0/24"]
nic_pip = "nic-pip20"
nic_config = "internal2"
nic_vm = "vm20"
nic_nsg = "nsg20"
rule_name = "SGR1"
nic_priority = "101"
}
}