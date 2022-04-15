class Addcolumn < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :status, :integer
  end
end
