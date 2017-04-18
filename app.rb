# Require all gems in Gemfile
require 'bundler'
Bundler.require

require_relative './lib/people' # or ruby -Ilib app.rb

# Set DataMapper
DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.finalize
DataMapper.auto_migrate!

# curl http://localhost:4567; echo
get '/' do
  "Hello World!"
end

# curl http://localhost:4567/people; echo
get '/people' do
  content_type :json

  people = People.all
  people.to_json
end

# curl http://localhost:4567/people/1; echo
get '/people/:id' do
  content_type :json

  person = People.get params[:id]
  person.to_json
end

# curl -d "person[name]=Sergio&person[age]=39" http://localhost:4567/people; echo
post '/people' do
  content_type :json

  person = People.new params[:person]
  if person.save
    status 201
    json 'Person was created'
  else
    status 500
    json person.errors.full_messages
  end
end

# curl -X PUT -d "person[name]=Sergiones" http://localhost:4567/people/1; echo
put '/people/:id' do
  content_type :json

  person = People.get params[:id]
  if person.update params[:person]
    status = 200
    json 'Person was updated'
  else
    status 500
    json 'An error occurs'
  end
end

# curl -X DELETE http://localhost:4567/people/1; echo
delete '/people/:id' do
  content_type :json

  person = People.get params[:id]
  if person.destroy
    status = 200
    json 'Person was removed'
  else
    status 500
    json 'An error occurs'
  end
end
