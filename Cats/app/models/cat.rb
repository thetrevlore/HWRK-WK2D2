# == Schema Information
#

# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  COLORS = %w(yellow red orange black gray purple)
  validates_presence_of :birth_date, :color, :name, :sex, :description
  validates :color, inclusion: {in: COLORS,
    message: 'Cats cannot be that color'}
  validates :sex, inclusion: {in: ['M','F'],
    message: 'Just for cats...you have to decide. Just cats.'}
  validates_uniqueness_of :name

  def age
    time_ago_in_words(birth_date)
  end

  has_many :rental_requests,
    class_name: 'CatRentalRequest',
    primary_key: :id,
    foreign_key: :cat_id,
    dependent: :destroy  #if we get rid of this cat we dont want requests for a nonexistent cat
    # always put on the has_many, not the belongs to



end
