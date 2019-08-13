class ActorsController < ApplicationController
  def index
    @actors = Actor.all.order({ :created_at => :desc })
    
    respond_to do |format|
      format.json do
        render({ :json => @actors.as_json })
      end

      format.html do
        render({ :template => "actors/index.html.erb" })
      end
    end
  end

  def show
    the_id = params.fetch(:rt_actor_id)
    @actor = Actor.where({:id => the_id }).first

    respond_to do |format|
      format.json do
        render({ :json => @actor.as_json })
      end

      format.html do
        render({ :template => "actors/show.html.erb" })
      end
    end
  end

  def create
    @actor = Actor.new

    @actor.name = params.fetch(:qs_name, nil)
    @actor.dob = params.fetch(:qs_dob, nil)
    @actor.bio = params.fetch(:qs_bio, nil)
    @actor.image_url = params.fetch(:qs_image_url, nil)

    if @actor.valid?
      @actor.save
      respond_to do |format|
        format.json do
          render({ :json => @actor.as_json })
        end
  
        format.html do
          redirect_to("/actors", { :notice => "Actor created successfully."})
        end
      end

    else
      respond_to do |format|
        format.json do
          render({ :json => @actor.as_json })
        end
  
        format.html do
          redirect_to("/actors", { :notice => "Actor failed to create successfully."})
        end
      end
    end
  end

  def update
    the_id = params.fetch(:rt_actor_id)
    @actor = Actor.where(:id => the_id).at(0)

    @actor.name = params.fetch(:qs_name, @actor.name)
    @actor.dob = params.fetch(:qs_dob, @actor.dob)
    @actor.bio = params.fetch(:qs_bio, @actor.bio)
    @actor.image_url = params.fetch(:qs_image_url, @actor.image)

    if @actor.valid?
      @actor.save
      respond_to do |format|
        format.json do
          render({ :json => @actor.as_json })
        end
  
        format.html do
          redirect_to("/actors/#{@actor.id}", {:notice => "Actor updated successfully."})
        end
      end
    else
      # render({:template => "/actors/edit_form_with_errors.html.erb"})
      respond_to do |format|
        format.json do
          render({ :json => @actor.as_json })
        end
  
        format.html do
          render({ :template => "actors/show.html.erb" })
        end
      end
    end
  end

  def destroy
    the_id = params.fetch(:rt_actor_id)
    @actor = Actor.where({ :id => the_id }).first

    @actor.destroy

  respond_to do |format|
    format.json do
      render({ :json => @actor.as_json })
    end

    format.html do
      redirect_to("/actors", {:notice => "Actor deleted successfully."})
    end
  end
  end
end
