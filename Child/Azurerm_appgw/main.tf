resource "azurerm_subnet" "subnet-appgw" {


 for_each = var.rgx
 name =  each.value.subnetgw
 resource_group_name = each.value.rg
 virtual_network_name = each.value.vnet
 address_prefixes = each.value.subnet_appgw
}

resource "azurerm_application_gateway" "appgw" {
          depends_on = [ azurerm_subnet.subnet-appgw ]
 for_each = var.rgx
  name                = each.value.appgw
  resource_group_name = each.value.rg
  location            = each.value.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.subnet_appgw[each.key].id
  }

frontend_ip_configuration {
  name                 = "frontend-ip"
  public_ip_address_id = data.azurerm_public_ip.pip_id[each.key].id

}

frontend_port {
  name = "port80"
  port = 80
}

backend_address_pool {
  name = "backendpool"

}

backend_http_settings {
  name                  = "http-settings"
  cookie_based_affinity = "Disabled"
  port                  = 80
  protocol              = "Http"
  request_timeout       = 20
}

http_listener {
  name                           = "listener"
  frontend_ip_configuration_name = "frontend-ip"
  frontend_port_name             = "port80"
  protocol                       = "Http"
}

request_routing_rule {
  name                       = "rule1"
  rule_type                  = "Basic"
  http_listener_name         = "listener"
  backend_address_pool_name  = "backendpool"
  backend_http_settings_name = "http-settings"
  priority                   = 102
}


}

data "azurerm_public_ip" "pip_id" {
  for_each = var.rgx
  name                = each.value.pip
  resource_group_name = each.value.rg
}

data "azurerm_subnet" "subnet_appgw" {
            depends_on = [ azurerm_subnet.subnet-appgw ]

  for_each = var.rgx
  name                 = each.value.subnetgw
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.rg
}