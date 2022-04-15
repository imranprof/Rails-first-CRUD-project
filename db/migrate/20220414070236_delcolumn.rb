class Delcolumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :blogs, :status
  end
end
