#!/bin/bash
echo "sudo HAB_PONYSERVE='message=\"Hello, Container Days\"' hab start smith/ponyserve"
sudo HAB_PONYSERVE='message="Hello, Container Days"' hab start smith/ponyserve  

