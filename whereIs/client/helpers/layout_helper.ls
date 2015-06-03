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
		return (items.join '/') is '/browse/other'
}