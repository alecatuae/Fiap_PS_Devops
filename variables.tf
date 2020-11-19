variable "azvarlocation" {
  type = string
  default = "eastus2"
  description = "Região aonde será criado o recurso"
}
variable "azvarresourcegroupname" {
  type = string
  default = "rghero"
  description = "O Resource Group tem como finalidade agrupar os recursos do Azure com um objetivo específico. Esse agrupamento permite o administrador realizar a criação, monitoramento, controle de acessos e de custo de cada grupo de recursos."
}
variable "azvarvnetaddress" {
  type = string
  default = "192.168.0.0/24"
  description = "A Rede Virtual do Azure (VNet) é o bloco de construção fundamental de sua rede privada no Azure. ... Ela permite vários tipos de recursos do Azure, como VMs (Máquinas Virtuais) do Azure, a fim de se comunicar de forma segura com a Internet, com as redes locais e com outras VMs"
}
variable "azvarsnetadress" {
  type = string
  default = "192.168.0.0/24"
  description = "As sub-redes permitem que você segmente a rede virtual em uma ou mais sub-redes e aloque uma parte do espaço de endereço da rede virtual para cada sub-rede. Em seguida, você pode implantar recursos do Azure em uma sub-rede específica. Você pode então implantar recursos do Azure em uma sub-rede específica."
}
variable "vmsize" {
  type = string
  default = "Standard_A2_v2"
  description = "Tamanhos das máquinas virtuais no Azure"
}
variable "vmsenha" {
  type = string
  default = "herouser@123"
  description = "Senha padrao"
}