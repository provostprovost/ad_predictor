module AdPredictor
  class GetClickthrough < UseCase
    def run(inputs)
      return failure(:no_input) if inputs == {}

      db = AdPredictor.db

      if inputs.class == Array
        impressions = inputs
      else
        impressions = db.find_impressions(inputs)
      end

      clicks = impressions.count { |impression| impression.clicked }

      clickthrough = clicks.to_f / impressions.count

      success clickthrough: clickthrough
    end
  end
end
