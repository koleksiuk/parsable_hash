[![Code Climate](https://codeclimate.com/github/koleksiuk/parsable_hash.png)](https://codeclimate.com/github/koleksiuk/parsable_hash)
[![Build Status](https://secure.travis-ci.org/koleksiuk/parsable_hash.png)](http://travis-ci.org/koleksiuk/parsable_hash)
[![Coverage Status](https://coveralls.io/repos/koleksiuk/parsable_hash/badge.png)](https://coveralls.io/r/koleksiuk/parsable_hash)

# ParsableHash

Allows to parse hash values in easy way, by extending class with hash
strategies.
## Installation

Add this line to your application's Gemfile:

    gem 'parsable_hash'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install parsable_hash

## Usage

    class FooTx
      include ParsableHash

      parse_strategy :transaction_strategy, :date => :date, 
                                            :amount => :big_decimal, 
                                            :id => :integer

      attr_accessor :transaction

      def initialize(raw_transaction = {})
        self.transaction = parse_hash(raw_transaction, with: :transaction_strategy) 
      end
    end

    # Fetch transaction from e.g. queue
    transaction = { :date => '12-12-2013', :amount => '23.22', :id => '124564' }

    tx = FooTx.new(transaction)

    tx.transaction #=> { :date=>#<Date: 2013-12-12 ((2456639j,0s,0n),+0s,2299161j)>, :amount=>23.22, :id=>124564 } 

## Available parsers
    :big_decimal => BigDecimal
    :boolean     => Boolean
    :date        => Date
    :float       => Float
    :integer     => Integer
    :date_time   => DateTime
    :null        => default parser (if parser is missing it simply leaves value as it is)

### Parsing with modules and other features

    # Using strategies from other modules / classes
    module ParseStrategies
      include ParsableHash

      parse_strategy :transaction_strategy, :date => :date, 
                                            :amount => :big_decimal, 
                                            :id => :integer
    end

    class FooTx
      include ParsableHash


      attr_accessor :transaction

      def initialize(raw_transaction = {})
        self.transaction = parse_hash(
                                       raw_transaction,
                                       :with  => :transaction_strategy,
                                       :const => ParseStrategies # must be kind of module/class
                                     )

        # You can also parse hash with Hash#parse_with
        # self.transaction = raw_transaction.parse_with(self, :transaction_strategy)
        # NOTE: self can be also replaced with any class that includes ParsableHash
      end
    end


## Extending with own parsers

    class MyClass
      def self.parse_string(val)
        "foo#{val}"
      end
    end

    module ParsableHash
      module Converters
        class MyClass < Base
          private

          def try_convert
            ::MyClass.parse_string(@value)
          end
        end
      end
    end

And then use ```:my_class``` as parse strategy for key

## Configuration
    ParsableHash::Strategy.fallbacks = true # set to false if you want to raise ParsableHash::MissingStrategy if strategy doesn't exist. 
    # In other case it is empty strategy (you can override it by adding :default to your strategies)

## To-do
* Add support for adding default values
* Add support for configurable fallback to string if key as symbol is missing (&
  vice-versa)
* Add support for extending parsers within other modules and nested
  classes (as it may happen that we have 2 same classes)



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
