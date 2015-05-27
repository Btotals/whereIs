Questions = new Mongo.Collection 'questions'

Questions.allow {
	insert: (userId, doc) ->
		!!userId
	update: (userId, post) ->
		!!userId
	remove: (userId, post) -> 
		!!userId
}

root = exports ? this
root.Questions = Questions
