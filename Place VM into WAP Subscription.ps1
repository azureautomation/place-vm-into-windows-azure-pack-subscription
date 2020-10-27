# Place VM into WAP Subscription
# Author Robert Smit
# Company @ClusterMVP
# Date April 10, 2015
# Version 1.0

#Set your SCVMM server and use -ForOnBehalfOf to make use of Service Provider Foundation. 
Import-Module -Name virtualmachinemanager
$VMMSERVER = Get-SCVMMServer -ComputerName YOUR-VMM-SERVER -ForOnBehalfOf 

#Select WAP Cloud
$Cloud = Get-SCCloud -Name (Get-SCCloud | select Name | Out-GridView -Title "Select WAP Cloud" -PassThru).Name

#Select Select WAP User Subscription
$User = (Get-SCUserRole | Where-Object Cloud -Match $Cloud).Name | Out-GridView -PassThru -Title "Select WAP User Subscription" 

# Show WAP Subscription User 
$WAPUserrole = Get-SCUserRole | Where-Object Cloud -Match $Cloud | Where-Object Name -Like $User* 
$WAPUserrole |ft name

# Select Single VM to WAP
$WAPVM = (Get-SCVirtualMachine ($Cloud | Get-SCVirtualMachine | select Name | Out-GridView -Title "Select Single VM to WAP" -PassThru).Name)

# show Selected VM to WAP Subscription
$WAPVM|ft name

#Place VM in WAP Subscription
Set-SCVirtualMachine -VM $WAPVM –UserRole $WAPUserrole –Owner $User

