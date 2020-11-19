# Prepara a infraestrutura na Azure para o subir a aplicação
# versão 1.0
# Grupo Hero 
# Disrupt 2020
# FIAP

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

#Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.azvarresourcegroupname
  location = var.azvarlocation
}

# VNet
# A Rede Virtual do Azure (VNet) é o bloco de construção fundamental de sua rede privada no Azure. ... 
# Ela permite vários tipos de recursos do Azure, como VMs (Máquinas Virtuais) do Azure, a fim de se 
# comunicar de forma segura com a Internet, com as redes locais e com outras VMs
resource "azurerm_virtual_network" "vnet" {
  name                = "herovnet"
  address_space       = [var.azvarvnetaddress]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}

# SubNet
# As sub-redes permitem que você segmente a rede virtual em uma ou mais sub-redes e aloque uma parte do espaço 
# de endereço da rede virtual para cada sub-rede. Em seguida, você pode implantar recursos do Azure em uma 
# sub-rede específica. Você pode então implantar recursos do Azure em uma sub-rede específica.
resource "azurerm_subnet" "subnet" {
  name                  = "vnetprod"
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  address_prefixes      = ["192.168.0.0/24"]
}

# IP Publico 
# Endereços IP públicos permitem recursos de Internet para comunicar a entrada para recursos do Azure. 
# Os endereços IP públicos permitem que os recursos da Internet se comuniquem com os recursos do Azure. ... 
resource "azurerm_public_ip" "publicip" {
  name                = "snetprod"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

# NSG
# Um Grupo de Segurança de Rede (NSG) contém uma lista de regras de segurança que permitem ou negam o 
# tráfego de rede de entrada ou saída com base no endereço IP de origem ou destino, na porta e no protocolo
resource "azurerm_network_security_group" "nsg" {
  name                = "NSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # A porta 22 (SSH) permite o gerenciamento dos servidores
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "2222"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "ssh-for-vm-management"
  }
}

# APPNIC01
# Uma interface de rede permite que uma VM do Azure se comunique com a Internet, com o Azure e com recursos locais.
resource "azurerm_network_interface" "appnic01" {
  name                = "appnic01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
 
  ip_configuration {
    name                            = "appip01"
    subnet_id                       = azurerm_subnet.subnet.id
    private_ip_address_allocation   = "static"
    private_ip_address              = "192.168.0.10"
    public_ip_address_id            = azurerm_public_ip.publicip.id
  }
}

# VM
# Pode ser definida como “uma duplicata eficiente e isolada de uma máquina real”
resource "azurerm_virtual_machine" "vm" {
    name                  = "heroapp01"
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    vm_size               = var.vmsize
    network_interface_ids = [azurerm_network_interface.appnic01.id]
 
 
    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
    storage_os_disk {
        name              = "heroapp01OSDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    os_profile {
        computer_name  = "heroapp01"
        admin_username = "heroadmin"
        admin_password = var.vmsenha
    }
    os_profile_linux_config {
        disable_password_authentication = "false"
    }
    provisioner "remote-exec" {
        inline = [
          "sudo apt update",
          "sudo apt upgrade -y",
          "sudo apt install mysql-server -y",
          "curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -",
          "sudo apt update",
          "sudo apt-get install -y nodejs",
          "sudo apt-get install -y apt-transport-https",
          "sudo apt-get install -y software-properties-common wget",
          "wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -",
          "echo 'deb https://packages.grafana.com/oss/deb stable main' | sudo tee -a /etc/apt/sources.list.d/grafana.list",
          "sudo apt-get update",
          "sudo apt-get install grafana"
        ]
        connection {
          type      = "ssh"
          user      = "heroadmin"
          password  = var.vmsenha
          host      = azurerm_public_ip.publicip.ip_address
        }
    }
}

data "azurerm_public_ip" "ip" {
  name                = azurerm_public_ip.publicip.name
  resource_group_name = azurerm_virtual_machine.vm.resource_group_name
  depends_on          = [azurerm_virtual_machine.vm]
}