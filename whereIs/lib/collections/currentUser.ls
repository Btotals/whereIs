/*
唯一ID	(only[bool]，默认true)
当前用户ID (userId[string]，当前用户ID)
*/

CurrentUser = new Mongo.Collection 'currentUser'

CurrentUser.allow {
	insert: (userId, doc) ->
		!!userId
	update: (userId, post) ->
		!!userId
	remove: (userId, post) -> 
		!!userId
}

root = exports ? @
root.CurrentUser = CurrentUser


Meteor.users.allow {
	update: (userId, docs, fields, modifier) ->
		true
}

Meteor.methods {
	update-current-user: !->
		console.log 'updating...'
		Current-user.update {only: true}, {$set: {user-id: Meteor.user!._id}}
}
