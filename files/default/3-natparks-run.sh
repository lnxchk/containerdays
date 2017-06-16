#!/bin/bash
echo "sudo hab start nathenharvey/national-parks --peer 127.0.0.1 --bind database:mongodb.default"
sudo hab start nathenharvey/national-parks --peer 127.0.0.1 --bind database:mongodb.default
