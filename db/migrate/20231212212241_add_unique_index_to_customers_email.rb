# db/migrate/[timestamp]_add_unique_index_to_customers_email.rb
class AddUniqueIndexToCustomersEmail < ActiveRecord::Migration[7.1]
  def change
    add_index :customers, :email_address, unique: true
  end
end
