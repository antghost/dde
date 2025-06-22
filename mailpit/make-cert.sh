#!/bin/bash
mkdir -p data/cert && chmod -R 777 data
echo 'mailpit:mailpit' > ./data/authfile
openssl req -x509 -newkey rsa:4096 \
-nodes -keyout ./data/cert/key.pem -out ./data/cert/cert.pem \
-sha256 -days 3650
