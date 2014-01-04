Hash.class_eval do
  define_method :parse_with do |object, strategy|
    if object.is_a? Module
      raise ParsableHash::NotDefinedError.new unless object.include?(ParsableHash)

      ParsableHash::Parser.new(self, object.parse_strategies[strategy]).call
    else
      object.parse_hash(self, :with => strategy)
    end
  end
end
