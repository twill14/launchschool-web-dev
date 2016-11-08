require "sinatra"
require "sinatra/reloader"
require "yaml"

before do
  @psych = Psych.load_file("users.yaml")
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :users
end

get "/:name" do
  name = params[:name].to_sym
  @name = params[:name].capitalize
  @email = @psych[name][:email]
  @interests = @psych[name][:interests].map {|x| x.capitalize}.join(", ")
  erb :user
end

not_found do
  redirect "/users"
end

helpers do
  def counter_interests(item)
    item.reduce(0) do |sum, (name, user)|
      sum + user[:interests].size
     end
   end
end
