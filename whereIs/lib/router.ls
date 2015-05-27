# Author: Btotals 
# Date: Sun May 24 2015 12:08:07 GMT+0800 (CST) 
Router.configure {
	layoutTemplate: 'layout'
}

Router.route '/', {name: 'home'}

Router.route '/register', {name: 'register'}

Router.route '/login', {name: 'login'}

Router.route '/logout', !->
	Meteor.logout (err)->
		if err then alert 'fail!'
		else Router.go '/'

Router.route '/profile', {name: 'profile'}

Router.route '/addquestion', {name: 'addQuestion'}

Router.route '/questiondetail/:_id', (eee) !->
	this.render 'questionDetail', {
		data: -> {
			Question: Quesitions.findOne this.params._id
		}
	}

Router.route '/browse/:_category', (eee) !->
	ques = Questions.find {category: this.params._category}
	if ques.count! is 0
		ques = 0
	this.render 'browse', {
		data: -> {
			Question: ques
		}
	}

Router.route '/search/:_keyword', (eee) !->
	results = searchByKeyword this.params._keyword
	this.render 'searchResults', {
		data: -> {
			Question: results
		}
	}

searchByKeyword = (keyword) ->
	0

requireLogin = (e)!->
	if !Meteor.user!
		alert('please login in first!');
		Router.go('/login')
	else
		this.next();

Router.onBeforeAction(requireLogin, {only: 'profile'});
Router.onBeforeAction(requireLogin, {only: 'addQuestion'});
