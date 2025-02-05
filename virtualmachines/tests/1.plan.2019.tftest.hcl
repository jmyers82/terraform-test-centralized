run "setup_network" {
  module {
    source = "./tests/setup"
  }
}


run "plan_2019_vm" {
  module {
    source  = "app.terraform.io/hashiconf24/vm-windows/azurerm"
    version = "2.0.0"
  }
  command = plan
  variables {
    vm_name     = "hashitalk-2019-vm"
    image_sku   = "2019-Datacenter"
    rg_name     = run.setup_network.rg_name
    rg_location = run.setup_network.rg_location
    vm_subnet   = run.setup_network.vm_subnet
  }
}