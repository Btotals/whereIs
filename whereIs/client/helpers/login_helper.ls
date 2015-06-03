Template.login.events {
	'submit form': (e, t) !->
		e.prevent-default!

		password = t.find '#password' .value
		email = t.find '#email' .value

		Meteor.login-with-password email, password, (err)->
			if err then alert err
			else Router.go '/profile'
}
