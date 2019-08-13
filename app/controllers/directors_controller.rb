class DirectorsController < ApplicationController
  def index
    @directors = Director.all.order({ :created_at => :desc })
    
    respond_to do |format|
      format.json do
        render({ :json => @directors.as_json })
      end

      format.html do
        render({ :template => "directors/index.html.erb" })
      end
    end
  end

  def show
    the_id = params.fetch(:rt_director_id)
    @director = Director.where({:id => the_id }).first

    respond_to do |format|
      format.json do
        render({ :json => @director.as_json })
      end

      format.html do
        render({ :template => "directors/show.html.erb" })
      end
    end
  end

  def create
    @director = Director.new

    @director.name = params.fetch(:qs_name, nil)
    @director.dob = params.fetch(:qs_dob, nil)
    @director.bio = params.fetch(:qs_bio, nil)
    @director.image_url = params.fetch(:qs_image_url, nil)

    if @director.valid?
      @director.save

      respond_to do |format|
        format.json do
          render({ :json => @director.as_json })
        end
  
        format.html do
          redirect_to("/directors", { :notice => "Director created successfully."})
        end
      end
    else
      respond_to do |format|
        format.json do
          render({ :json => @director.as_json })
        end
  
        format.html do
          redirect_to("/directors", { :notice => "Director failed to create successfully."})
        end
      end
    end
  end

  def update
    the_id = params.fetch(:rt_director_id)
    @director = Director.where(:id => the_id).at(0)

    @director.name = params.fetch(:qs_name, @director.name)
    @director.dob = params.fetch(:qs_dob, @director.dob)
    @director.bio = params.fetch(:qs_bio, @director.bio)
    @director.image_url = params.fetch(:qs_image_url, @director.image)

    if @director.valid?
      @director.save

      respond_to do |format|
        format.json do
          render({ :json => @director.as_json })
        end
  
        format.html do
          redirect_to("/directors/#{@director.id}", {:notice => "Director updated successfully."})
        end
      end
    else
      respond_to do |format|
        format.json do
          render({ :json => @director.as_json })
        end

        format.html do
          render({ :template => "directors/show.html.erb" })
        end
      end
    end
  end

  def destroy
    the_id = params.fetch(:rt_director_id)
    @director = Director.where({ :id => the_id }).first

    @director.destroy

    respond_to do |format|
      format.json do
        render({ :json => @director.as_json })
      end

      format.html do
        redirect_to("/directors", {:notice => "Director deleted successfully."})
      end
    end
  end
end
