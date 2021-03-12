class AddIsreadyToRsses < ActiveRecord::Migration[6.0]
  def change
    add_column :rsses, :isready, :boolean
  end
end
