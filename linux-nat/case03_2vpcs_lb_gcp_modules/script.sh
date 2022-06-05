#!/bin/bash
echo "replacing version in file .terraform/modules/vpc_creation/modules/vpc/versions.tf"
echo "from 0.126 to ~> 1.1.0"  
sed -i 's/required_version = \"~> 0.12.6\"/required_version = \"~> 1.1.0\"/' .terraform/modules/vpc_creation/modules/vpc/versions.tf
echo "replacement completed"