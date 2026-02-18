output you will see for avialbility zones checkup for data.tf

Changes to Outputs:
  + az_info = {
      + all_availability_zones = null
      + exclude_names          = null
      + exclude_zone_ids       = null
      + filter                 = null
      + group_names            = [
          + "us-east-1-zg-1",
        ]
      + id                     = "us-east-1"
      + names                  = [
          + "us-east-1a",
          + "us-east-1b",
          + "us-east-1c",
          + "us-east-1d",
          + "us-east-1e",
          + "us-east-1f",
        ]
      + state                  = "available"
      + timeouts               = null
      + zone_ids               = [
          + "use1-az4",
          + "use1-az6",
          + "use1-az1",
          + "use1-az2",
          + "use1-az3",
          + "use1-az5",
        ]
    }



for below error we have to give 2 subnet cidrs. i have tested this. i have provided only one cidr at root level public_subnet_cidr in variable.tf 

│ Error: Invalid value for variable
│
│   on main.tf line 7, in module "vpc":
│    7:   public_subnet_cidrs = var.public_subnet_cidrs
│     ├────────────────
│     │ var.public_subnet_cidrs is list of string with 1 element
│
│ please provide 2 valid public subnet CIDR
│
│ This was checked by the validation rule at
│ ..\modules\terraform_vpc\variables.tf:19,5-15.
╵
Releasing state lock. This may take a few moments...

