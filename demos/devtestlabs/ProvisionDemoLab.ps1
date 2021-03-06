$ErrorActionPreference = "stop"

# -------------------------------------------------------------------------
# Change these values to your own

$labName = "DevLab"
$ResourceGroupName = "ResourceGroup-$labName"
$ResourceGroupLocation = "West Europe"
$vstsAgentPoolName = "Default"
$vmUsername = "devops"
$vmPassword = ConvertTo-SecureString "ADP#2018" -AsPlainText -Force
$subscriptionName = "<YourSubscriptionName>"
$vstsAgentVmName = "<YourVmName>"
$vstsAccountName = "<YourVstsAccountName>"
$vstsPAT = "<YourPat>"

# -------------------------------------------------------------------------

# Login and select subscription
try {
    $sub = Get-AzureRmContext
    if ($sub.Subscription.Name -eq $subscriptionName) {
        "Found subscription $($sub.Subscription.Name)"
    }
    else {
        throw "SubscriptionNotFound"
    }
} catch {
    "Did not find subscription in current context, please login..."
    Login-AzureRmAccount
    Select-AzureRmSubscription -SubscriptionName $subscriptionName
}

"Creating new resource group for the lab..."
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Force

"Start deploying the lab using the ARM templates..."
$deployment = New-AzureRmResourceGroupDeployment `
    -Name "Deploy-$labName" `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile .\azuredeploy.json `
    -TemplateParameterFile .\azuredeploy.parameters.json `
    -labName $labName `
    -vstsAccountName $vstsAccountName `
    -vstsAgentPoolName $vstsAgentPoolName `
    -vstsPassword $vstsPAT `
    -vstsAgentVmName $vstsAgentVmName `
    -vmUsername $vmUsername `
    -vmPassword $vmPassword `
    -Verbose -OutVariable $deploymentOutput

"Lab id:"
$deployment.Outputs.labId.Value