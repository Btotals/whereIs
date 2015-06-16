Template.layout.helpers {
	isEatCloth: ->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		items.pop!
		return ((items.join '/') is '/browse/eatCloth/unsolved') or ((items.join '/') is '/browse/eatCloth/solved')

	isLiveWalk: ->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		items.pop!
		return (items.join '/') is '/browse/liveWalk/unsolved' or (items.join '/') is '/browse/liveWalk/solved'

	isStudy: ->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		items.pop!
		return (items.join '/') is '/browse/study/unsolved' or (items.join '/') is '/browse/study/solved'

	isOther: ->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''
		
		items.pop!
		return (items.join '/') is '/browse/other/unsolved' or (items.join '/') is '/browse/other/solved'
}

Template.layout.events {
	'click #goSearch': (e, t) !->
		keyWord = $ '#keyWord' .val!
		if !keyWord
			return
		Router.go('/search/'+keyWord+'/unsolved/1')
}

# Template.layout.onRendered !->
# 	$ '.ui.dropdown' .dropdown!
