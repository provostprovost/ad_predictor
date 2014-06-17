require 'spec_helper'

describe AdPredictor::GetAd do
  let(:db) { AdPredictor.db }
  before do
    db.clear
    AdPredictor::ImportCSV.run(path: './data/ad_picker_test.csv')
  end

  it "returns the ad with the highest clickthrough" do
    result = subject.run(platform: "iOS")
    expect(result.success?).to eq true
    expect(result.ad).to eq "Candy Smash"
  end
end
