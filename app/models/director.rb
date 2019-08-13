# == Schema Information
#
# Table name: directors
#
#  id         :integer          not null, primary key
#  bio        :text
#  dob        :string
#  image_url  :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Director < ApplicationRecord
  validates(:name, { :presence => true })

  def Director.youngest
    return Director.order({ :dob => :desc }).at(0)
  end

  def Director.eldest
    return Director.where.not({ :dob => nil }).order({ :dob => :asc }).at(0)
  end

  def filmography
    return Movie.where({ :director_id => self.id })
  end

  def as_json
    if self.errors.any?
      validation_messages = {
        :errors => self.errors,
        :full_messages => self.errors.full_messages
      }

      super.merge(validation_messages)
    else
      super
    end
  end
end
