* Execute on local

```sh
gem install pry
gem install pry-byebug
gem install aws-sdk-dynamodb
```

```sh
development=true ruby execute_on_development.rb
```

* Execute test

```sh
ruby execute_test.rb
```

* Deploy to Production

```sh
./deploy.sh production
```

* Deploy to Staging

```sh
./deploy.sh staging
```
