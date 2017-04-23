class App < Sinatra::Base
  set :method_override, true # Enable/disable the POST _method hack
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @people = People.all
    haml :index
  end

  get '/people' do
    @people = People.all
    haml :index
  end

  get '/people.json' do
    content_type :json

    people = People.all
    people.to_json
  end

  get '/people/:id' do
    @person = People.get params[:id]
    haml :show
  end

  post '/people' do
    person = People.new params[:person]
    if person.save
      flash[:notice] = "Person was created"
    else
      flash[:alert] = person.errors.full_messages.join(', ')
    end
    redirect '/'
  end

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

  delete '/people/:id' do
    person = People.get params[:id]
    if person.destroy
      flash[:notice] = "Person was destroyed"
    else
      flash[:alert] = person.errors.full_messages.join(', ')
    end
    redirect '/'
  end
end
