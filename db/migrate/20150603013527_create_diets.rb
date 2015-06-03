class CreateDiets < ActiveRecord::Migration
  def change
    create_table :diets do |t|
      t.text :diet_type
      t.timestamps
    end
  end
end
