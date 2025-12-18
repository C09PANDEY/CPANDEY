resource "azurerm_network_security_group" "nsg" {
  for_each = var.vm

  name                = each.value.nsg_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  security_rule {
    name                       = "allow-ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-http"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  for_each = var.vm

  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = data.azurerm_subnet.subnet[each.key].id
      public_ip_address_id          = data.azurerm_public_ip.pip[each.key].id
      private_ip_address_allocation = "Dynamic"
    }
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vm

  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  admin_username                  = data.azurerm_key_vault_secret.admin_username[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.admin_password[each.key].value
  disable_password_authentication = each.value.disable_password_authentication
  size                            = each.value.size
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  dynamic "os_disk" {
    for_each = each.value.os_disk
    content {
      caching = os_disk.value.caching
      storage_account_type = os_disk.value.storage_account_type
    }
  }

  dynamic "source_image_reference" {
    for_each = each.value.source_image_reference
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }
  custom_data = each.value.custom_data != null ? base64encode(each.value.custom_data) : null

}
