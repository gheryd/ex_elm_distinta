# ex_elm_distinta
example elm spa

require: elm 0.19, nodejs, json -server

install:
- \# npm install -g json-server
- \# npm install
- \# elm install
- \# elm make src/client/Main.elm --output=dist/main.js

start: 
- json-server -w db.json
- npm start

links: 
- http://localhost:3000 (json db)
- http://localhost:3001 (elm app)
