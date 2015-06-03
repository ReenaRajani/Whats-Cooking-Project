class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.text :title
      t.text :image_url
      t.text :source_url
      t.text :edamaam_uri
      t.text :summary
      t.float :total_time
      t.float :prep_time
      t.float :cooking_time
      t.integer :no_of_serves
      t.float :rating
      t.string :difficulty_level
      t.text :ingredient_lines
      t.timestamps
    end
  end
end
