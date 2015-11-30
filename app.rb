require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'json'
require 'net/http'


get '/' do
    erb :form
end
get '/result' do
    @number = params[:number]
    uri = URI("http://pokeapi.co/api/v1/pokemon/" + @number + "/")
    res = Net::HTTP.get_response(uri)
    json = JSON.parse(res.body)
    @pokemon = json["name"]
    @sprite = json["sprites"][0]["resource_uri"]
    image_uri = URI("http://pokeapi.co/" + @sprite)
    image_res = Net::HTTP.get_response(image_uri)
    image_json = JSON.parse(image_res.body)
    @image = "http://pokeapi.co/" + image_json["image"]
    erb :index
end
