# == Schema Information
#
# Table name: recipes
#
#  id               :integer          not null, primary key
#  title            :text
#  image_url        :text
#  source_url       :text
#  edamaam_uri      :text
#  summary          :text
#  total_time       :float
#  prep_time        :float
#  cooking_time     :float
#  no_of_serves     :integer
#  rating           :float
#  difficulty_level :string
#  ingredient_lines :text
#  created_at       :datetime
#  updated_at       :datetime
#

class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :diets
  validates_presence_of :title
end
