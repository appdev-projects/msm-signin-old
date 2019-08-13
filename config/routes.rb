Rails.application.routes.draw do

  match("/", { :controller => "movies", :action => "index", :via => "get"})


  # Routes for the Character resource:

  # CREATE
  match("/insert_character", { :controller => "characters", :action => "create", :via => "post"})
          
  # READ
  match("/characters", { :controller => "characters", :action => "index", :via => "get"})
  
  match("/characters/:rt_character_id", { :controller => "characters", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_character/:rt_character_id", { :controller => "characters", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_character/:rt_character_id", { :controller => "characters", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the Actor resource:

  # CREATE
  match("/insert_actor", { :controller => "actors", :action => "create", :via => "post"})
          
  # READ
  match("/actors", { :controller => "actors", :action => "index", :via => "get"})
  
  match("/actors/:rt_actor_id", { :controller => "actors", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_actor/:rt_actor_id", { :controller => "actors", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_actor/:rt_actor_id", { :controller => "actors", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the Director resource:

  # CREATE
  match("/insert_director", { :controller => "directors", :action => "create", :via => "post"})
          
  # READ
  match("/directors", { :controller => "directors", :action => "index", :via => "get"})
  
  match("/directors/:rt_director_id", { :controller => "directors", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_director/:rt_director_id", { :controller => "directors", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_director/:rt_director_id", { :controller => "directors", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the Movie resource:

  # CREATE
  match("/insert_movie", { :controller => "movies", :action => "create", :via => "post"})
          
  # READ
  match("/movies", { :controller => "movies", :action => "index", :via => "get"})
  
  match("/movies/:rt_movie_id", { :controller => "movies", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_movie/:rt_movie_id", { :controller => "movies", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_movie/:rt_movie_id", { :controller => "movies", :action => "destroy", :via => "get"})

  #------------------------------

  # ==========
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
