Basic Sinatra APP
=================

Run the app: `$ ruby app.rb`  
And try one of the following commands:  
* curl http://localhost:4567/people
* curl -d "person[name]=John&person[age]=30" http://localhost:4567/people
* curl http://localhost:4567/people/1
* curl -X PUT -d "person[name]=Joe" http://localhost:4567/people/1
* curl -X DELETE http://localhost:4567/people/1
