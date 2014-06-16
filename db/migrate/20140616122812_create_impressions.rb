class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions do |t|
      t.datetime  :date
      t.integer   :hour
      t.string    :ad
      t.string    :browser
      t.string    :platorm
      t.string    :region
      t.boolean   :clicked
    end
  end
end
