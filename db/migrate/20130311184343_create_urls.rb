class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :original
      t.string :short
      t.integer :visits
    end
  end
end
