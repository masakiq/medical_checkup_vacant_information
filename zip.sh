#!/usr/bin/env sh

cp -f *.rb tmp/
rm tmp/main.rb
chmod -R 755 tmp/*
rm dest/medicalCheckupVacantInformation.zip
cd tmp && zip -r ../dest/medicalCheckupVacantInformation.zip . && cd -
rm tmp/*.rb
