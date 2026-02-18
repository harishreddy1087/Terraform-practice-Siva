.
├── main.tf                 # Root module (The orchestrator)
├── variables.tf            # Root variables
├── modules/
│   ├── vpc/
│   │   ├── main.tf         # VPC, Subnets, IGW, NAT, Routes
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── sg/
│   │   ├── main.tf         # Security Groups
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ec2/
│       ├── main.tf         # EC2 Instance & User Data
│       ├── variables.tf
│       └── outputs.tf