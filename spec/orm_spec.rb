require 'spec_helper'

describe AdPredictor::Database::ORM do
  let(:db) { described_class.new }

  before { db.clear }

  describe 'Impressions' do
    it "creates an impression" do
      impression = db.create_impression(date: Time.now,
                                        hour: 20,
                                        ad: 'Clash of Clans',
                                        browser: 'Google Chrome',
                                        platform: 'Android',
                                        region: 'North America',
                                        clicked: true )
      expect(impression).to be_a AdPredictor::Impression
      expect(impression.id).to_not be_nil
      expect(impression.hour).to eq 20
      expect(impression.clicked).to eq true
    end
  end
end
