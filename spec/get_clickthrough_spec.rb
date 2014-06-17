require 'spec_helper'

describe AdPredictor::GetClickthrough do
  let(:db) { AdPredictor.db }
  let(:imp_params) {{ date: Time.now,
                      hour: 20,
                      ad: 'Clash of Clans',
                      browser: 'Google Chrome',
                      platform: 'Android',
                      region: 'North America',
                      clicked: true }}
  before { db.clear }

  before do
    3.times { db.create_impression(imp_params) }
    imp_params[:clicked] = false
    imp_params[:browser] = "Safari"
    2.times { db.create_impression(imp_params) }
  end

  it 'returns error for no input' do
    result = subject.run({})
    expect(result.error).to eq :no_input
  end

  it 'returns clickthrough rate for ad that matches params' do
    result = subject.run(ad: 'Clash of Clans', region: 'North America')
    expect(result.success?).to eq true
    expect(result.clickthrough).to eq 0.6
  end

  it 'returns clickthrough rate for an array of impressions' do
    impressions = db.find_impressions(ad: 'Clash of Clans', region: 'North America')
    result = subject.run(impressions)
    expect(result.success?).to eq true
    expect(result.clickthrough).to eq 0.6
  end
end
