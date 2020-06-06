class AddAddressToCities < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :address, :string
  end
end
