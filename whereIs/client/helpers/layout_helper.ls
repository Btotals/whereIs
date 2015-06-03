Template.layout.helpers {
	isEatCloth: ->
		curUrl = Router.current! .url
		items = curUrl.split '/'
		items.pop!
		return (items.join '/') is '/browse/eatCloth'

	isLiveWalk: ->
		curUrl = Router.current! .url
		items = curUrl.split '/'
		items.pop!
		return (items.join '/') is '/browse/liveWalk'

	isStudy: ->
		curUrl = Router.current! .url
		items = curUrl.split '/'
		items.pop!
		return (items.join '/') is '/browse/study'

	isOther: ->
		curUrl = Router.current! .url
		items = curUrl.split '/'
		items.pop!
<<<<<<< HEAD
		return (items.join '/') is '/browse/other/unsolved' or (items.join '/') is '/browse/other/solved'
}

# Template.layout.onRendered !->
# 	$ '.ui.dropdown' .dropdown!
=======
		return (items.join '/') is '/browse/other'
}
>>>>>>> cee88a2d2837fb3f79fda0a5746bf47c554c11cd
