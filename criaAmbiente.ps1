az upgrade

echo ">>> LOGIN NO AZURE"
# az login -u "<user>" -p "<password>"
az login -u rm86499@fiap.com.br -p fiap.20

echo ">>> TERRAFORM PLAN"
.\terraform.exe plan

echo ">>> TERRAFORM APPLY"
.\terraform.exe apply --auto-approve