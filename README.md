# azure-create-app-registrations-using-terraform
Create app registrations in Azure using terraform and github workflow

# How code works

* This repo uses terraform to create app registration and service principal in Azure.

# parameters used

| input name | description | type | mandatory |
|------------|------------|-----|-------------|
| app_registration_name | Azure App registration name | string | :heavy_check_mark: |
| app_registration_owner | App registration owners names | string | :heavy_check_mark: |
| app_registration_description | App registration description | string | |
| app_registation_expiry | App registration secret expiry | Choice - `30`,`60`,`90`,`120`,`150`,`180`,`270`,`360` | :heavy_check_mark: |

# Terraform commands and How to run the code locally

1. Clone the repo and switch to the folder
2. cd azure-create-app-registrations-using-terraform
3. Then run `terraform init`
4. run `terraform validate`
5. then `terraform plan`
6. provide the values when popped up
7. then `terraform apply` and provide `yes` as confirmation

## Conditions

* Azure active directory user should have a proper mail id available

# How to run as a github workflow

1. Go to your cloned repo and then to actions tab

2. Choose the workflow `azure-create-app-registrations-using-terraform.yaml` on left side

3. Next click on `Run Workflow` on right side top and enter the input parameters required

4. Click on `Run Workflow` (green one)

5. After the job is completed, The app registration and sp will be created with owners

# Credentials needed

**Authentication to Azure is done using service principal**

```
env:
    ARM_CLIENT_ID: ${{ secrets.APP_ID }}
    ARM_CLIENT_SECRET: ${{ secrets.APP_SECRET }}
    ARM_TENANT_ID: ${{ secrets.TENANT_ID }}
    ARM_SUBSCRIPTION_ID: ${{ secrets.SUBSCRIPTION_ID }}
```

`ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID` are required Environment variables.

I used GitHub secrets on the workflow for authentication. 


##### This creates a secret with specified validity and updates the same on keyvault

```
<SP name>-SECRET
<SP name-APPID>
<SP name-TENANT>
```
* when creating Keyvault secrets, SP names will be converted to all capital letters


#References
* [using-secrets-in-github-actions](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)
* [azuread_application_password](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password)
* [azuread_service_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal)