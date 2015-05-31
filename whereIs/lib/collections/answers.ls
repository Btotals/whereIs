/*
回答ID (_id[ObjectID]，回答唯一标识)
内容 (content[string]，回答内容)
回答时间 (addTime[string])
热度 (heat[int]，被赞+1，被踩-1)
回答者 (answererID[ObjectID]，回答者的ID)
对应问题 (questionID[ObjectID]，对应问题的ID)
是否被采纳 (isBest[bool])
*/

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
