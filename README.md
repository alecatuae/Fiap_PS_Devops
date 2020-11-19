# FIAP Disrupt (PS) 
#### Grupo Hero
#### Trabalho de DevOps
#### Professor João Menk


# Prepara a infraestrutura na Azure para o subir a aplicação

## Ferramentas
### Terraform
Terraform é uma ferramenta open source de provisionamento de infraestrutura, criada pela HashiCorp, que permite criar nossa infraestrutura como código(IaC), usando uma linguagem simples e declarativa.

### PowerShell
O PowerShell é uma estrutura multiplataforma de gerenciamento de configuração e de automação de tarefas, que consiste em um shell de linha de comando e em uma linguagem de script. Ao contrário da maioria dos shells, que aceitam e retornam texto, o PowerShell é criado com base no CLR (Common Language Runtime) do .NET e aceita e retorna objetos .NET. Essa mudança fundamental traz ferramentas e métodos totalmente novos para a automação.

### Pré-Requisitos

1. Ter uma conta valida no Azure Cloud
```https://azure.microsoft.com/en-us/```

2. Instalar módulo do Azure PowerShell
```https://docs.microsoft.com/pt-br/powershell/azure/azurerm/install-azurerm-ps?view=azurermps-6.13.0```

3. Criar um pasta de trabalho para ser o repositorio local dos scripts do Terraform e Powershell

4. Baixar a última versão do Terraform na pasta criada
```https://www.terraform.io/downloads.html```

5. execute o Git Clone na pasta criada
```git clone https://github.com/alecatuae/Fiap_PS_Devops.git```

### Subir o Ambiente
1. Abra o Powershell e navegue até a pasta criada. 
2. Autentique no azure como o commando ```az login``` e entre com suas credencias
3. Valide o plano de execução como o comando ```./terraform plan```
4. Caso não hava nenhum erro, execute o comando ```./terraform apply```

### Destroir o ambiente no Azure
1. Abra o Powershell e navegue até a pasta criada. 
2. Autentique no azure como o commando ```az login``` e entre com suas credencias
3. Caso não hava nenhum erro, execute o comando ```./terraform destroy```

