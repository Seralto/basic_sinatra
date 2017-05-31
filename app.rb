class App < Sinatra::Base
  set :method_override, true # Enable/disable the POST _method hack
  enable :sessions
  register Sinatra::Flash
  register Sinatra::MultiRoute

  # json
  get '/people.json' do
    content_type :json, charset: 'utf-8'

    people = People.all
    people.to_json
  end

  # Index
  get '/', '/people' do
    @person = People.new
    @people = People.all
    haml :'people/index'
  end

  # Show
  get '/people/:id' do
    @person = People.get params[:id]
    haml :'people/show'
  end

  # Create
  post '/people/' do
    person = People.new params[:person]
    if person.save
      flash[:notice] = "Person was created"
    else
      flash[:alert] = person.errors.full_messages.join(', ')
    end
    redirect '/'
  end

  # Edit
  get '/people/:id/edit' do
    @person = People.get params[:id]
    haml :'people/edit'
  end

  # Update
  put '/people/:id' do
    person = People.get params[:id]
    if person.update params[:person]
      flash[:notice] = "Person was updated"
    else
      flash[:alert] = person.errors.full_messages.join(', ')
    end
    redirect '/'
  end

  # Delete
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
