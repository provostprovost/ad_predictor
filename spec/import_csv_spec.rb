require 'spec_helper'

describe AdPredictor::ImportCSV do
  before do
    @db = AdPredictor.db
    @db.clear
  end

  it 'returns an error if file is not found' do
    result = subject.run(path: './data/doesnt_exist.csv')

    expect(result.error).to eq :file_not_found
  end

  it 'returns an error if the file does not have csv extension' do
    result = subject.run(path: './data/doesnt_exist.xls')

    expect(result.error).to eq :not_a_csv
  end

  it 'imports a CSV' do
    result = subject.run(path: './data/test.csv')

    expect(result.success?).to eq true
    expect(result.records_rejected).to eq 3
    expect(result.records_imported).to eq 17
  end
end
