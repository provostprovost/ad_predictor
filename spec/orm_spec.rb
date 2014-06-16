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
  end
end
