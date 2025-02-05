run "setup_network" {
  module {
    source = "./tests/setup"
  }
}


run "plan_2016_vm" {
  module {
    source  = "app.terraform.io/hashiconf24/vm-windows/azurerm"
    version = "1.0.0"
  }
  command = plan
  variables {
    vm_name     = "hashitalk-2016-vm"
    image_sku   = "2016-Datacenter"
    rg_name     = run.setup_network.rg_name
    rg_location = run.setup_network.rg_location
    vm_subnet   = run.setup_network.vm_subnet
  }
}