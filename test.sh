#!/bin/bash

# Runs some validation tests on the scripts

terraform -chdir=test init
terraform -chdir=test validate
