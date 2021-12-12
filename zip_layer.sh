#!/bin/bash

echo "# Zip packages for lambda layer"

sleep 1

zip -r -9 mylayer.zip ./python

echo "# Done!"