Template.login.events {
	'submit #login-module': (e, t) !->
		e.prevent-default!

		password = t.find '#password' .value
		email = t.find '#email' .value

		Meteor.login-with-password email, password, (err)->
			if err then alert 'error'
			else Router.go '/profile'
}
