Template.searchUnsolved.helpers {
	nowKeyword: ->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		return items[2]

	totalPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		keyword = items[2]
		
		itemPerPage = 2
		maxPage = parseInt((this.size+itemPerPage-1)/itemPerPage)
		return maxPage

	nextPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		keyword = items[2]
		
		itemPerPage = 2
		maxPage = parseInt((this.size+itemPerPage-1)/itemPerPage)

		nowPage = items[4]
		if +nowPage >= maxPage
			return '#'
		items.pop!
		items.push +nowPage+1
		return items.join '/'

	prevPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		nowPage = items[4]
		if +nowPage < 2
			return '#'
		items.pop!
		items.push +nowPage-1
		return items.join '/'
}

Template.searchSolved.helpers {
	nowKeyword: ->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		return items[2]

	totalPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		keyword = items[2]
		
		itemPerPage = 2
		maxPage = parseInt((this.size+itemPerPage-1)/itemPerPage)
		return maxPage

	nextPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		keyword = items[2]
		
		itemPerPage = 2
		maxPage = parseInt((this.size+itemPerPage-1)/itemPerPage)

		nowPage = items[4]
		if +nowPage >= maxPage
			return '#'
		items.pop!
		items.push +nowPage+1
		return items.join '/'

	prevPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		nowPage = items[4]
		if +nowPage < 2
			return '#'
		items.pop!
		items.push +nowPage-1
		return items.join '/'
}