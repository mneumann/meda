require "meda/accessor"

module Meda

  class Description
  end # class Description

  class ContainerDescription < Description
    def initialize
      super
      @elements = []
    end

    include Enumerable

    def each(&block)
      @elements.each(&block)
    end

    def <<(element)
      @elements << element
    end

    def push(*args)
      @elements.push(*args)
    end
  end # class ContainerDescription

  class ElementDescription < Description
    def initialize
      super
      @conditions = []
    end

    def priority(new_priority)
      @priority = new_priority
      self
    end

    def label(new_label)
      @label = new_label
      self
    end

    def selector(*args)
      @accessor = SelectorAccessor.new(*args)
      self
    end
  
  end # class ElementDescription

  class StringDescription < ElementDescription; end

  class NumberDescription < ElementDescription
    def min(value)
      @min = value
      self
    end

    def max(value)
      @max = value
      self
    end
  end # class NumberDescription

  class ReferenceDescription < ElementDescription
    def reference(ref)
      @reference = ref
      self
    end
  end # class ReferenceDescription

  class OptionDescription < ReferenceDescription
    def options(new_options)
      @options = new_options
      self
    end

    def sorted(bool=true)
      @sorted = bool 
      self
    end
  end # class SingleOptionDescription

  class SingleOptionDescription < OptionDescription
  end # class SingleOptionDescription

  class ::Module
    def description_self
      container = ContainerDescription.new
      #
      # we want mixed in modules
      #
      ancestors.each do |mod|
        next if mod == self or mod.is_a?(Class)
        container.push(*mod.description_self)
      end 

      methods.each do |meth|
        container << send(meth) if meth.to_s =~ /^description_(?!self$)/
      end 

      return container
    end
  end # class ::Module

  class ::Object
    def description_self
      self.class.description_self
    end
  end # class ::Object

end # module Meda
