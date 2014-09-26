
# -*- coding: utf-8 -*-
require 'twitter'
require 'sinatra'

require './configure'

get '/' do
  @todo_tweet = []
  @name = ''
  @number = 0		
  erb :twitter
end

post '/' do
  @todo_tweet = []
  client = my_twitter_client() 
  @name = params[:firstname] || ''
  @number = params[:n].to_i
  @number = 1 if @number <= 0
  if client.user? @name 
    #ultimos_t = client.user_timeline(@name,{:count=>@number.to_i})
    #@todo_tweet =(@todo_tweet != '') ? ultimos_t.map{ |i| i.text} : ''

    @usuario = Hash.new
    siguiendo = client.friend_ids(@name).attrs[:ids].take(@number)
    puts "ID amigos a comparar #{siguiendo}"
    siguiendo.each do |sig|
      usu = client.user(sig) 
      begin
      if (usu.protected.to_s != "true") #Mientras no sea un usuario protegido
         @usuario[usu.screen_name.to_s] = usu.followers_count #Usuario X tiene tantos seguidores
	 puts "#{usu.screen_name.to_s} cuenta con #{usu.followers_count} followers" 
      end
      rescue
         puts "Se ha producido un error por favor intentelo de nuevo"
      end

end


  end

  erb :twitter
end

