###*
Populate DB with sample data on server start
to disable, edit config/environment/index.js, and set `seedDB: false`
###

'use strict'

Thing = require '../api/thing/thing.model'
User = require '../api/user/user.model'
Absence = require '../api/absence/absence.model'
Allowance = require '../api/allowance/allowance.model'


Absence.find({}).remove -> console.log "finished removing absences"
# Allowance.find({}).remove -> console.log "finished remove allowances"

Thing.find({}).remove ->
  Thing.create
    name: 'Development Tools'
    info: 'Integration with popular tools such as Bower, Grunt, Karma, Mocha, JSHint, Node Inspector, Livereload, Protractor, Jade, Stylus, Sass, CoffeeScript, and Less.'
  ,
    name: 'Server and Client integration'
    info: 'Built with a powerful and fun stack: MongoDB, Express, AngularJS, and Node.'
  ,
    name: 'Smart Build System'
    info: 'Build system ignores `spec` files, allowing you to keep tests alongside code. Automatic injection of scripts and styles into your index.html'
  ,
    name: 'Modular Structure'
    info: 'Best practice client and server structures allow for more code reusability and maximum scalability'
  ,
    name: 'Optimized Build'
    info: 'Build process packs up your templates as a single JavaScript payload, minifies your scripts/css/images, and rewrites asset names for caching.'
  ,
    name: 'Deployment Ready'
    info: 'Easily deploy your app to Heroku or Openshift with the heroku and openshift subgenerators'

User.find({}).remove ->
  User.create
    provider: 'local'
    name: 'Test User'
    email: 'test@test.com'
    password: 'test'
    allowances:
      year: 1992
      amount: 3
    taken:
      reason: 'why not'
      from: new Date('December 17, 1995 03:24:00')
      to: new Date()
  ,
    provider: 'local'
    role: 'admin'
    name: 'Admin'
    email: 'admin@admin.com'
    password: 'admin'
  , ->
    console.log 'finished populating users'
