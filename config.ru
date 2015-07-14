$:.unshift File.expand_path("../", __FILE__)
require 'sinatra'
require "app"

map '/' do
  run App
end