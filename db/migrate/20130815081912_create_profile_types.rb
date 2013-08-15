class CreateProfileTypes < ActiveRecord::Migration
  def change
    create_table :profile_types do |t|
      t.string :name
      t.integer :channel_limit

      t.timestamps
    end
  end
end
