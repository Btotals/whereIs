Template.register.events {
	'submit #register-module': (e, t) !->
		e.prevent-default!

		nickname = t.find '#nickname' .value
		password = t.find '#password' .value
		email = t.find '#email' .value
		console.log name
		console.log password
		console.log email

		Accounts.create-user {email: email, password: password, profile: {nickname: nickname}}, (err)->
			if err then console.log err
			else console.log 'success'
}