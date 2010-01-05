module Meda

  class Accessor; end

  class SelectorAccessor < Accessor
    def initialize(read_symbol, write_symbol=:"#{read_symbol}=")
      @read_symbol, @write_symbol = read_symbol, write_symbol
    end

    def [](object)
      object.send(@read_symbol)
    end

    def []=(object, value)
      object.send(@write_symbol, value)
    end
  end

end # module Meda
