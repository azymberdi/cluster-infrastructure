## For set-env.sh script configurations
environment                     =   "dev"
region                          =   "us-east-1"
s3_bucket                       =	"fuchicorp"
s3_folder_region                =	"us-east-1"
s3_folder_project               =   "fuchicorp"
s3_folder_type                  =   "eks"
s3_tfstate_file                 =   "infrastructure.tfstate"

## After deployment of VPC you should have two security groups
security_group_ids = [
    "sg-0a54eeef73bcd0812",
    "sg-0eed094d5266aa574",
]

## Public Subnets for EKS 
public_subnets     = [
    "subnet-01d3fb52ab72ebc7b",
    "subnet-0a22ac955d82c430f",
    "subnet-04bc8caf7340e35d5",
    "subnet-0b6a7b9d8bd1faf2c",
    ]

## Private Subnets for EKS 
private_subnets     = [
    "subnet-06dd58631906ff870",
    "subnet-063d775af8c1a0690",
    "subnet-0e1b6507a37417261",
    "subnet-01ad9894683ae9d9e",
    ]
