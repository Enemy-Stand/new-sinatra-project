class VideogamesController < ApplicationController

  get '/videogames' do
    # redirect_if_not_logged_in
    @user = current_user
    erb :'videogames/index'
  end

  get '/videogames/new' do
    @user = current_user
    erb :'videogames/new'
  end

  post '/videogames/new' do
    if params[:title] == ""
      redirect '/videogames/new'
    else
      @videogame = Videogame.create(:title => params[:title],
        :system => params[:system],
        :publisher => params[:publisher],
        :release_date => params[:release_date])
        @videogame.user = current_user
        @videogame.save
      redirect to "/videogames/#{@videogame.id}"
    end
  end

  get '/videogames/:id' do
    @videogame = Videogame.find_by_id(params[:id])
    erb :'videogames/show'
  end

  get '/videogames/:id/edit' do
    @videogame = Videogame.find_by_id(params[:id])
    if @videogame.user != current_user
      redirect "/account"
    else
      erb :'videogames/edit'
    end
  end

  patch '/videogames/:id' do
    @videogame = Videogame.find_by_id(params[:id])
    if @videogame.user != current_user || params[:title] == ""
      redirect '/videogames/:id'
    else
      @videogame.title = params[:title]
      @videogame.system = params[:system]
      @videogame.publisher = params[:publisher]
      @videogame.release_date = params[:release_date]
      @videogame.save
      redirect to "/videogames/#{@videogame.id}"
    end
  end

  delete '/videogames/:id' do
    videogame = Videogame.find_by_id(params[:id])
    if videogame.user != current_user
      redirect '/videogames/:id'
    else
      videogame.delete
      redirect to '/videogames'
    end
  end

  get '/search/:title' do
    @videogame = Videogame.find_by(title: params[:title])
    if @videogame
      redirect to "/videogames/#{@videogame.id}"
    else
      'Title not found.'
    end
  end
end
