# Author: Btotals 
# Date: Sun May 24 2015 12:08:07 GMT+0800 (CST) 
Router.configure {
	layoutTemplate: 'layout'
}

Router.route '/',  (eee) !->
	top5Users = Meteor.users.find {}, {sort: {'profile.score': -1}, limit: 5}
	top5Questions = Questions.find {}, {sort: {'totalAnswer': -1}, limit: 5}
	new5Questions = Questions.find {}, {sort: {'addTime': -1}, limit: 5}
	this.render 'home', {
		data: -> {
			Users: top5Users,
			tQuestions: top5Questions,
			nQuestions: new5Questions
		}
	}

Router.route '/register', {name: 'register'}

Router.route '/login', {name: 'login'}

Router.route '/logout', !->
	Meteor.logout (err)->
		if err then alert 'fail!'
		Router.go '/login'

Router.route '/profile/:_id', (eee) !->
	this.render 'profile', {
		data: -> {
			User: Meteor.users.findOne this.params._id
		}
	}

Router.route '/addquestion', {name: 'addQuestion'}

Router.route '/questiondetail/:_id', (eee) !->
	this.render 'questionDetail', {
		data: -> {
			Question: Questions.findOne this.params._id
		}
	}

Router.route '/browse/:_category/solved/:_page', (eee) !->
	itemPerPage = 1
	itemMin = itemPerPage*((parseInt this.params._page)-1)
	itemMax = itemPerPage*(parseInt this.params._page)-1

	solvedQues = Questions.find {category: this.params._category, isHandled: true}, {skip: itemMin, limit: itemPerPage}

	if solvedQues.count! is 0
		solvedQues = 0

	this.render 'solvedBrowse', {
		data: -> {
			solvedQuestions: solvedQues
		}
	}

Router.route '/browse/:_category/unsolved/:_page', (eee) !->
	itemPerPage = 1
	itemMin = itemPerPage*((parseInt this.params._page)-1)
	itemMax = itemPerPage*(parseInt this.params._page)-1

	unsolvedQues = Questions.find {category: this.params._category, isHandled: false}, {skip: itemMin, limit: itemPerPage}

	if unsolvedQues.count! is 0
		unsolvedQues = 0

	this.render 'unsolvedBrowse', {
		data: -> {
			unsolvedQuestions: unsolvedQues
		}
	}

Router.route '/search/:_keyword', (eee) !->
	results = searchByKeyword this.params._keyword
	this.render 'searchResults', {
		data: -> {
			Questions: results
		}
	}

searchByKeyword = (keyword) ->
	0

requireLogin = (e)!->
	if !Meteor.user!
		alert 'please login in first!'
		Router.go '/login'
	else
		this.next!

logged = (e)!->
	if Meteor.user!
		Router.go '/'
	else
		this.next!

Router.onBeforeAction requireLogin, {only: 'addQuestion'}

Router.onBeforeAction logged, {only: 'login'}
Router.onBeforeAction logged, {only: 'register'}
