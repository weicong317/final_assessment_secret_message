class AddCategoryToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :category, :integer
  end
end
