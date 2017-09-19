# routes.rb
Rails.application.routes.draw do

  get '/cats/:id/:secret', controller: 'cats', action: :show
  # realistically you'd need to prevent
  # /cats/:id/edit from matching (auto-gen by resources)
  # get '/cats/:id/:secret', controller: 'cats',
  #     action: :show, constraints: {secret: /((?!edit).)*/}
  resources :cats
end

# cats_controller.rb (rails generate scaffold)
class CatsController < ApplicationController
  # set_cat definition omitted for brevity
  before_action :set_cat, only: [:show]

  def show
    @secret_name = params[:secret]
  end
end

# show.html.erb
<%= @secret_name %>