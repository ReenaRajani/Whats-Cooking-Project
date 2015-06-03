# == Schema Information
#
# Table name: ingredients
#
#  id              :integer          not null, primary key
#  name            :text
#  quantity        :float
#  weight          :float
#  edaman_ingr_uri :string
#

class Ingredient < ActiveRecord::Base
end
