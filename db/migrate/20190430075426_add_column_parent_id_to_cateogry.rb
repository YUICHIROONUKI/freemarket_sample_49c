class AddColumnParentIdToCateogry < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :parent, index: true, null: false
    add_foreign_key :categories, :categories, column: :parent_id
  end
end
