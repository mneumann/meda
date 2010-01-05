require 'meda/description'

include Meda

class Address
  attr_accessor :street
  attr_accessor :zip
  attr_accessor :place
  attr_accessor :state
end

class Address
  def self.description_street
    StringDescription.new.selector(:street).label('Street').priority(10)
  end

  def self.description_zip
    NumberDescription.new.selector(:zip).label('Zip code').priority(20).min(1000).max(99999)
  end

  def self.description_place
    StringDescription.new.selector(:place).label('Place').priority(30)
  end

  def self.description_state
    SingleOptionDescription.new.selector(:state).label('State').priority(40).
      options(%w(Bayern Hessen Baden-Wuerttemberg ...)).reference(StringDescription.new).sorted(true)
  end
end

#p Address.description_street
#p Address.description_zip
#p Address.description_place
#p Address.description_state

p Address.description_self
