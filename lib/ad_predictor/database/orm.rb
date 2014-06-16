require 'active_record'
require 'yaml'
require 'pry'

module AdPredictor
  module Database
    class ORM
      def initialize
        configs = YAML.load_file('db/config.yml')
        ActiveRecord::Base.establish_connection(configs['test'])
      end

      def clear
        Impression.delete_all
      end

      class Impression < ActiveRecord::Base
      end

      def create_impression(attrs)
        impression = Impression.create(attrs)
        AdPredictor::Impression.new(id: impression.id,
                                    date: impression.date,
                                    hour: impression.hour,
                                    ad: impression.ad,
                                    browser: impression.browser,
                                    platform: impression.platform,
                                    region: impression.region,
                                    clicked: impression.clicked )
      end

      def get_impression(id)
        impression = Impression.find(id)
        AdPredictor::Impression.new(id: impression.id,
                                    date: impression.date,
                                    hour: impression.hour,
                                    ad: impression.ad,
                                    browser: impression.browser,
                                    platform: impression.platform,
                                    region: impression.region,
                                    clicked: impression.clicked )
      end

      def find_impressions(attrs)
        impressions = Impression.where(attrs)
        array = []
        impressions.each do |impression|
          array.push(AdPredictor::Impression.new(
                                    id: impression.id,
                                    date: impression.date,
                                    hour: impression.hour,
                                    ad: impression.ad,
                                    browser: impression.browser,
                                    platform: impression.platform,
                                    region: impression.region,
                                    clicked: impression.clicked ))
        end
        array
      end
    end
  end
end
