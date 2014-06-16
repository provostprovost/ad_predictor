class CorrectSpelling < ActiveRecord::Migration
  def change
    drop_table :impressions

    create_table :impressions do |t|
      t.datetime  :date
      t.integer   :hour
      t.string    :ad
      t.string    :browser
      t.string    :platform
      t.string    :region
      t.boolean   :clicked
    end
  end
end
