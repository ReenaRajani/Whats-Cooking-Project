# == Schema Information
#
# Table name: diets
#
#  id         :integer          not null, primary key
#  diet_type  :text
#  created_at :datetime
#  updated_at :datetime
#

class Diet < ActiveRecord::Base
  has_and_belongs_to_many :recipes
end
