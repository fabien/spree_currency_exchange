# Spree Currency Exchange extension

The Spree Currency Exchange extension enables multiple currencies.

## Installation

1. Add the following to your Gemfile
  gem "spree_currency_exchange"

2. run `bundle install`

3. copy over assets and migrations via the rake task: `rake spree_currency_exchange:install`
4. run the migrations: `rake db:migrate`

