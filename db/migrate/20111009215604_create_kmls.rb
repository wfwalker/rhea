class CreateKmls < ActiveRecord::Migration
  def self.up
    create_table :kmls do |t|
      t.string :source_url
      t.string :description
      t.string :original_filename
      t.text :contents

      t.timestamps
    end
  end

  def self.down
    drop_table :kmls
  end
end
