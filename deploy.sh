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
rm tmp/execute_test.rb
chmod -R 755 tmp/*
rm dest/medicalCheckupVacantInformation.zip
cd tmp && zip -r ../dest/medicalCheckupVacantInformation.zip . && cd -
rm -rf tmp/*

env=$1
if [ "$env" = 'production' ]; then
  lambda_function_name='medical_checkup_vacant_information'
elif [ "$env" = 'staging' ]; then
  lambda_function_name='medical_checkup_vacant_information_staging'
else
  echo 'Specify staging or poduction.'
  exit 1
fi
aws lambda update-function-code \
  --function-name $lambda_function_name \
  --zip-file fileb://`pwd`/dest/medicalCheckupVacantInformation.zip

rm dest/medicalCheckupVacantInformation.zip
