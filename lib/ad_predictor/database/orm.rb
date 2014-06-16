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
        attrs[:id] = impression.id
        AdPredictor::Impression.new(attrs)
      end

      def get_impression(id)
      end

      def find_impressions(attrs)
      end
    end
  end
end
