#!/bin/bash

echo "Fix decimal separator (comma instead of dot)"
sudo echo "export LC_NUMERIC=C" >> ~/.bashrc
