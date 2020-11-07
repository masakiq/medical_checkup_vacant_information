#!/usr/bin/env sh

rm -rf deploy/tmp/*
cp -f lambda_function.rb deploy/tmp/
mkdir deploy/tmp/domain
mkdir deploy/tmp/infra
mkdir deploy/tmp/usecase
mkdir deploy/tmp/presentation
cp -f domain/*.rb deploy/tmp/domain/
cp -f infra/*.rb deploy/tmp/infra/
cp -f usecase/*.rb deploy/tmp/usecase/
cp -f presentation/*.rb deploy/tmp/presentation/
chmod -R 755 deploy/tmp/*
rm deploy/dest/medicalCheckupVacantInformation.zip
cd deploy/tmp && zip -r ../dest/medicalCheckupVacantInformation.zip . && cd -
rm -rf deploy/tmp/*

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
  --zip-file fileb://`pwd`/deploy/dest/medicalCheckupVacantInformation.zip

rm deploy/dest/medicalCheckupVacantInformation.zip
