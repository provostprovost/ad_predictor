require 'spec_helper'

describe AdPredictor::Database::ORM do
  let(:db) { described_class.new }
  let(:imp_params) {{ date: Time.now,
                      hour: 20,
                      ad: 'Clash of Clans',
                      browser: 'Google Chrome',
                      platform: 'Android',
                      region: 'North America',
                      clicked: true }}

  before { db.clear }

  describe 'Impressions' do
    it "creates an impression" do
      impression = db.create_impression(imp_params)
      expect(impression).to be_a AdPredictor::Impression
      expect(impression.id).to_not be_nil
      expect(impression.hour).to eq imp_params[:hour]
      expect(impression.clicked).to eq imp_params[:clicked]
    end

    it "gets an impression" do
      impression = db.create_impression(imp_params)
      retrieved_impression = db.get_impression(impression.id)
      expect(retrieved_impression.ad).to eq 'Clash of Clans'
    end

    it "finds impressions that match params" do
      3.times { db.create_impression(imp_params) }
      impression1 = db.create_impression( date: Time.now,
                                          hour: 14,
                                          ad: 'Candy Crush',
                                          browser: 'Safari',
                                          platform: 'iOS',
                                          region: 'Europe',
                                          clicked: true )
      retrieved_clicks = db.find_impressions(clicked: true)
      expect(retrieved_clicks.size).to eq 4

      retrieved_combo = db.find_impressions(ad: 'Clash of Clans', platform: 'Android')
      expect(retrieved_combo.size).to eq 3
    end
  end
end
