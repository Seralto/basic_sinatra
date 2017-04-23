class App < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

   # http://localhost:4567
  get '/' do
    @people = People.all
    haml :index
  end

  # curl http://localhost:4567/people; echo
  get '/people.json' do
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
    person = People.new params[:person]
    if person.save
      flash[:notice] = "Person was created"
    else
      flash[:notice] = person.errors.full_messages.join(', ')
    end
    redirect '/'
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
end
