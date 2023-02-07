module "project_hub" {
  source = "../modules/project"
  parent = var.hub_folder
  prefix = var.prefix
  name   = lower("${local.name_project_hub}-proj-hub") 
  billing_account = var.billing_account
  labels = local.labels_project_hub
  services = var.apis_activated
}
