#!/bin/bash
var=$(for i in $(cat vars.txt);do echo "-var $i";done)
vars=$(echo $var | tr '\n' ' ')
terraform destroy $vars -auto-approve
