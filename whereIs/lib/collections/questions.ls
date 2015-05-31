/*
问题ID (_id[ObjectID]，问题唯一标识)
题目 (title[string]，问题题目)
描述 (content[string]， 问题内容)
提问时间 (addTime[string])
提问者 (askerID[ObjectID]，提问者的ID)
所属类别 (category[string])
悬赏分数 (reward[int])
回答数 (totalAsk[int])
是否已解决 (isHandled[bool])
所有回答 (answers[Object数组])3
*/

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
