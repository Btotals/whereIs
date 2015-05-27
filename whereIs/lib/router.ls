# Author: Btotals 
# Date: Sun May 24 2015 12:08:07 GMT+0800 (CST) 


Router.route '/', !->
	if Meteor.user! then @.render 'home', {} else @.render 'login', {}

Router.route '/login', !->
	@.render 'login', {}

Router.route '/register', !->
	@.render 'register', {}

Router.route '/home', !->
	@render 'home', {}

Router.route '/logout', !->
	Meteor.logout (err)->
		if err then alert 'fail!'
		else Router.go '/'

Router.route '/result', !->
	@render 'result', {}

Router.route '/profile', !->
	@render 'profile', {}

Router.route '/question', !->
	@render 'question', {}

