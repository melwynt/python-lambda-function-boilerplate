#!/bin/bash

dir=$(pwd)

echo $(pwd)

AWS_PAGER="" aws lambda publish-layer-version \
    --layer-name "upload-app-python-layer" \
    --description "My Python layer" \
    --license-info "MIT" \
    --zip-file "fileb://${dir}/mylayer.zip" \
    --compatible-runtimes python3.8