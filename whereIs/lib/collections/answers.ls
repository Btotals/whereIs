Answers = new Mongo.Collection 'answers'

Answers.allow {
	insert: (userId, doc) ->
		!!userId
	update: (userId, post) ->
		!!userId
	remove: (userId, post) -> 
		!!userId
}

root = exports ? this
root.Answers = Answers
