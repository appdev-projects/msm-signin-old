class CharactersController < ApplicationController
  def index
    @characters = Character.all.order({ :created_at => :desc })
    
    respond_to do |format|
      format.json do
        render({ :json => @characters.as_json })
      end

      format.html do
        render({ :template => "characters/index.html.erb" })
      end
    end
  end

  def show
    the_id = params.fetch(:rt_character_id)
    @character = Character.where({:id => the_id }).first

    respond_to do |format|
      format.json do
        render({ :json => @character.as_json })
      end

      format.html do
        render({ :template => "characters/show.html.erb" })
      end
    end
  end

  def create
    @character = Character.new

    @character.movie_id = params.fetch(:qs_movie_id, nil)
    @character.actor_id = params.fetch(:qs_actor_id, nil)
    @character.name = params.fetch(:qs_name, nil)

    if @character.valid?
      @character.save
      respond_to do |format|
        format.json do
          render({ :json => @character.as_json })
        end
  
        format.html do
          redirect_to("/characters", { :notice => "Character created successfully."})
        end
      end

    else
      respond_to do |format|
        format.json do
          render({ :json => @character.as_json })
        end
  
        format.html do
          redirect_to("/characters", { :notice => "Character failed to create successfully."})
        end
      end
    end
  end

  def update
    the_id = params.fetch(:rt_character_id)
    @character = Character.where(:id => the_id).at(0)

    @character.movie_id = params.fetch(:qs_movie_id, @character.movie_id)
    @character.actor_id = params.fetch(:qs_actor_id, @character.actor_id)
    @character.name = params.fetch(:qs_name, @character.name)

    if @character.valid?
      @character.save
      respond_to do |format|
        format.json do
          render({ :json => @character.as_json })
        end
  
        format.html do
          redirect_to("/characters/#{@character.id}", {:notice => "Character updated successfully."})
        end
      end
    else
      # render({:template => "/characters/edit_form_with_errors.html.erb"})
      respond_to do |format|
        format.json do
          render({ :json => @character.as_json })
        end
  
        format.html do
          render({ :template => "characters/show.html.erb" })
        end
      end
    end
  end

  def destroy
    the_id = params.fetch(:rt_character_id)
    @character = Character.where({ :id => the_id }).first

    @character.destroy

  respond_to do |format|
    format.json do
      render({ :json => @character.as_json })
    end

    format.html do
      redirect_to("/characters", {:notice => "Character deleted successfully."})
    end
  end
  end
end
