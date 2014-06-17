module AdPredictor
  class GetAd < UseCase
    def run(inputs)
      return failure(:no_input) if inputs == {}

      db = AdPredictor.db
      # All impressions that match params
      impression_matches = db.find_impressions(inputs)

      # Get all unique ad names in impressions
      ads = impression_matches.uniq { |impression| impression.ad }

      # Map ads array to ad name and clickthrough percentage
      clickthroughs = []

      ads.each do |impression|
        ad_matches = impression_matches.select { |impression_match| impression_match.ad == impression.ad }
        clickthroughs.push(ad: impression.ad, clickthrough: AdPredictor::GetClickthrough.run(ad_matches).clickthrough)
      end

      if clickthroughs != []
        clickthroughs.sort_by! { |pair| pair[:clickthrough] }
        best_ad = clickthroughs.last[:ad]
        best_clickthrough = clickthroughs.last[:clickthrough]
      end

      # Return name of ad with highest clickthrough
      success ad: best_ad, clickthrough: best_clickthrough
    end
  end
end
