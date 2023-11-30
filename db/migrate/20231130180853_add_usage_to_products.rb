class AddUsageToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :usage, :string
  end
end

