#!/usr/bin/env sh

rm tmp/*
cp -f *.rb tmp/
rm tmp/main.rb
chmod -R 755 tmp/*
rm dest/medicalCheckupVacantInformation.zip
cd tmp && zip -r ../dest/medicalCheckupVacantInformation.zip . && cd -
rm tmp/*.rb

aws lambda update-function-code \
  --function-name medical_checkup_vacant_information \
  --zip-file fileb://`pwd`/dest/medicalCheckupVacantInformation.zip

rm dest/medicalCheckupVacantInformation.zip
