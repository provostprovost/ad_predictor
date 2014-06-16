module AdPredictor
  class Impression < Entity
    attr_accessor :id, :date, :hour, :ad, :browser, :platform, :region, :clicked

    validates_presence_of :date, :hour, :ad, :clicked, :id
  end
end
