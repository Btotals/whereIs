Template.questionDetail.helpers {
	bestAnswer: !->
		for answer in this.Question.answers
			if answer.isBest is true
				return answer
		return 0

	otherAnswers: !->
		answers = []
		for answer in this.Question.answers
			if answer.isBest is false
				answers.push answer
		return answers
}

Template.answerItem.helpers {
	isAuthorAndHasNoBest: !->
		curUrl = Router.current! .url
		items = curUrl.split '/' 
		questionId = items[items.length-1]
		question = Questions.findOne questionId

		return (Meteor.user!._id is question.askerID) and !question.isHandled
}