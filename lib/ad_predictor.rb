require 'active_model'

module AdPredictor
  def self.db
    @db = Database::ORM.new
  end
end

require_relative 'ad_predictor/database/orm.rb'

require_relative 'ad_predictor/entities/entity.rb'
require_relative 'ad_predictor/entities/impression.rb'

require_relative 'ad_predictor/use_cases/use_case.rb'
require_relative 'ad_predictor/use_cases/get_ad.rb'
require_relative 'ad_predictor/use_cases/get_clickthrough.rb'
require_relative 'ad_predictor/use_cases/import_csv.rb'



