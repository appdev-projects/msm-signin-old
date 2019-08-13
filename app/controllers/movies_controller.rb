class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order({ :created_at => :desc })
    
    respond_to do |format|
      format.json do
        render({ :json => @movies.as_json })
      end

      format.html do
        render({ :template => "movies/index.html.erb" })
      end
    end
  end

  def show
    the_id = params.fetch(:rt_movie_id)
    @movie = Movie.where({:id => the_id }).first

    respond_to do |format|
      format.json do
        render({ :json => @movie.as_json })
      end

      format.html do
        render({ :template => "movies/show.html.erb" })
      end
    end
  end

  def create
    @movie = Movie.new

    @movie.title = params.fetch(:qs_title, nil)
    @movie.year = params.fetch(:qs_year, nil)
    @movie.duration = params.fetch(:qs_duration, nil)
    @movie.description = params.fetch(:qs_description, nil)
    @movie.image_url = params.fetch(:qs_image_url, nil)
    @movie.director_id = params.fetch(:qs_director_id, nil)

    if @movie.valid?
      @movie.save
      respond_to do |format|
        format.json do
          render({ :json => @movie.as_json })
        end
  
        format.html do
          redirect_to("/movies", { :notice => "Movie created successfully."})
        end
      end

    else
      respond_to do |format|
        format.json do
          render({ :json => @movie.as_json })
        end
  
        format.html do
          redirect_to("/movies", { :notice => "Movie failed to create successfully."})
        end
      end
    end
  end

  def update
    the_id = params.fetch(:rt_movie_id)
    @movie = Movie.where(:id => the_id).at(0)

    @movie.title = params.fetch(:qs_title, @movie.title)
    @movie.year = params.fetch(:qs_year, @movie.year)
    @movie.duration = params.fetch(:qs_duration, @movie.duration)
    @movie.description = params.fetch(:qs_description, @movie.description)
    @movie.image_url = params.fetch(:qs_image_url, @movie.image)
    @movie.director_id = params.fetch(:qs_director_id, @movie.director_id)

    if @movie.valid?
      @movie.save
      respond_to do |format|
        format.json do
          render({ :json => @movie.as_json })
        end
  
        format.html do
          redirect_to("/movies/#{@movie.id}", {:notice => "Movie updated successfully."})
        end
      end
    else
      respond_to do |format|
        format.json do
          render({ :json => @movie.as_json })
        end
  
        format.html do
          render({ :template => "movies/show.html.erb" })
        end
      end
    end
  end

  def destroy
    the_id = params.fetch(:rt_movie_id)
    @movie = Movie.where({ :id => the_id }).first

    @movie.destroy

    respond_to do |format|
      format.json do
        render({ :json => @movie.as_json })
      end

      format.html do
        redirect_to("/movies", {:notice => "Movie deleted successfully."})
      end
    end
  end
end
