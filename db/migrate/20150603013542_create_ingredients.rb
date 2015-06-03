class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.text :name 
      t.float :quantity
      t.float :weight
      t.string :edaman_ingr_uri
    end
  end
end
