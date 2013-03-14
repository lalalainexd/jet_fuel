class CreatePremiumUrls < ActiveRecord::Migration
  def change
    create_table :premium_urls do |t|
      t.references :user
      t.string :original
      t.string :short
      t.integer :visits
      t.timestamps
    end
  end
end
