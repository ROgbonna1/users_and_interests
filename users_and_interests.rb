require 'pry'
require 'sinatra'
require 'psych'
require "sinatra/reloader"
# require "tilt/erubis"

before do
  @data = Psych.load_file("data/users.yaml")
  @users = @data.keys.map(&:to_s)
  @interests = @data.map { |user, user_data| user_data[:interests] }.flatten
end

get '/' do
  @title = "Home Page"
  erb :home
end

get '/:user' do
  redirect '/' unless @users.include? params[:user]
  @user = params[:user]
  @title = "#{@user.capitalize}'s Page"
  erb :user
end

