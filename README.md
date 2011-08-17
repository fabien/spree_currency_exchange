# Spree Currency Exchange extension

The Spree Currency Exchange extension enables multiple currencies.

## Installation

1. Add the following to your Gemfile
  gem "spree\_currency\_exchange", :git => 'git://github.com/fabien/spree\_currency\_exchange.git'

2. run `bundle install`

3. copy over assets and migrations via the rake task: `rake spree_currency_exchange:install`
4. run the migrations: `rake db:migrate`

## Notes

This extension was largely based on Pronix' [spree\_multi\_currency][1].

[1]: http://spreecommerce.com/extensions/94-spree-multi-currency