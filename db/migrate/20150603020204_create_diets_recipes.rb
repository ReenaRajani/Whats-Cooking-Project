class CreateDietsRecipes < ActiveRecord::Migration
  def change
    create_table :diets_recipes , :id => false do |t|
      t.integer :diet_id
      t.integer :recipe_id
    end
  end
end
