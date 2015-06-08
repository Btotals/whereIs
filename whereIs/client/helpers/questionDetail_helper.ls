Template.questionDetail.helpers {
	bestAnswer: !->
		theBest = []
		for answer in this.Question.answers
			if answer.isBest is true
				theBest.push answer
				return theBest
		return 0

	otherAnswers: !->
		answers = []
		for answer in this.Question.answers
			if answer.isBest is false
				answers.push answer
		return answers

	category: !->
		if this.Question.category is 'eatCloth'
			return "衣食"
		if this.Question.category is 'liveWalk'
			return "住行"
		if this.Question.category is 'study'
			return "学习"
		if this.Question.category is 'other'
			return "其它"

	# is-not-author: ->
	# 	cur-url = Router.current! .url
	# 	items = curUrl.split '/' 
	# 	question-id = items[items.length-1]
	# 	question-owner-id = Questions.find-one question-id .asker-id
	# 	Meteor.user!._id != question-owner-id

}

Template.answerItem.helpers {
	isAuthorAndHasNoBest: !->
		if Meteor.user!
			curUrl = Router.current! .url
			items = curUrl.split '/' 
			questionId = items[items.length-1]
			question = Questions.findOne questionId

			return (Meteor.user!._id is question.askerID) and !question.isHandled
		else
			return false
}
