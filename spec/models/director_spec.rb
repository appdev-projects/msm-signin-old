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

require "rails_helper"

describe Director, ".youngest" do
  it "returns the youngest director", points: 0 do
    first_director = Director.new
    first_director.dob = 42.years.ago
    first_director.save

    second_director = Director.new
    second_director.dob = 101.years.ago
    second_director.save

    third_director = Director.new
    third_director.dob = 36.years.ago
    third_director.save

    fourth_director = Director.new
    fourth_director.dob = nil
    fourth_director.save

    expect(Director.youngest).to eq(third_director)
  end
end

describe Director, ".eldest" do
  it "returns the eldest director", points: 0 do
    first_director = Director.new
    first_director.dob = 42.years.ago
    first_director.save

    second_director = Director.new
    second_director.dob = 101.years.ago
    second_director.save

    third_director = Director.new
    third_director.dob = 36.years.ago
    third_director.save

    fourth_director = Director.new
    fourth_director.dob = nil
    fourth_director.save

    expect(Director.eldest).to eq(second_director)
  end
end

describe Director, "#filmography" do
  it "returns the movies that belong to the director", points: 0 do
    director = Director.new
    director.save

    other_director = Director.new
    other_director.save

    first_movie = Movie.new
    first_movie.director_id = director.id
    first_movie.save

    second_movie = Movie.new
    second_movie.director_id = other_director.id
    second_movie.save

    third_movie = Movie.new
    third_movie.director_id = director.id
    third_movie.save

    fourth_movie = Movie.new
    fourth_movie.director_id = other_director.id
    fourth_movie.save

    fifth_movie = Movie.new
    fifth_movie.director_id = director.id
    fifth_movie.save

    expect(director.filmography).to match_array([first_movie, third_movie, fifth_movie])
  end
end
