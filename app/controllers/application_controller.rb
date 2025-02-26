class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(:id => params[:id])
  
    erb :show
  end

 # load the edit form by matching the recipe id
 get "/recipes/:id/edit" do
  @recipe = Recipe.find_by(:id => params[:id])
  erb :edit
end

patch "/recipes/:id" do
  @recipe = Recipe.find(params[:id])
  if @recipe.update(params)
    redirect to "/recipes/#{@recipe.id}"
  end
end


 delete '/recipes/:id' do
  @recipe = Recipe.find_by_id(params[:id])
  @recipe.delete
  
  redirect to '/recipes'
 end

end
