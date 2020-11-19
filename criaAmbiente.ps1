az upgrade

echo ">>> LOGIN NO AZURE"
az login -u "<user>" -p "<password>"

echo ">>> TERRAFORM PLAN"
.\terraform.exe plan > plan.log

echo ">>> TERRAFORM APPLY"
.\terraform.exe apply --auto-approve > apply.log