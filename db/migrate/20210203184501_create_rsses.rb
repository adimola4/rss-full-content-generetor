class CreateRsses < ActiveRecord::Migration[6.0]
  def change
    create_table :rsses do |t|
      t.string :original_url
      t.string :title
      t.text :description
      t.string :img_url
      t.string :generated_url

      t.timestamps
    end
  end
end
