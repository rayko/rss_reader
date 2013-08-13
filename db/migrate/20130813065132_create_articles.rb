class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :link
      t.text :description, :default => ''
      t.datetime :pub_date
      t.text :comment, :default => ''
      t.boolean :starred, :default => false
      t.integer :channel_id

      t.timestamps
    end
  end
end
