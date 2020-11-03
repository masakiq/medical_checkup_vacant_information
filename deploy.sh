#!/usr/bin/env sh

rm -rf tmp/*
cp -f *.rb tmp/
mkdir tmp/domain
mkdir tmp/infra
mkdir tmp/usecase
cp -f domain/*.rb tmp/domain/
cp -f infra/*.rb tmp/infra/
cp -f usecase/*.rb tmp/usecase/
rm tmp/execute_on_development.rb
chmod -R 755 tmp/*
rm dest/medicalCheckupVacantInformation.zip
cd tmp && zip -r ../dest/medicalCheckupVacantInformation.zip . && cd -
rm -rf tmp/*

aws lambda update-function-code \
  --function-name medical_checkup_vacant_information \
  --zip-file fileb://`pwd`/dest/medicalCheckupVacantInformation.zip

rm dest/medicalCheckupVacantInformation.zip
