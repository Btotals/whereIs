Template.solvedBrowse.helpers {
	totalPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		category = items[2]
		size = Questions.find {category: category, isHandled: true} .count!
		itemPerPage = 1
		maxPage = (size+itemPerPage-1)/itemPerPage
		return maxPage

	nextPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		category = items[2]
		size = Questions.find {category: category, isHandled: true} .count!
		itemPerPage = 1
		maxPage = (size+itemPerPage-1)/itemPerPage

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

	nowCategory: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		return items[2]
}

Template.unsolvedBrowse.helpers {
	totalPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		category = items[2]
		size = Questions.find {category: category, isHandled: false} .count!
		itemPerPage = 1
		maxPage = (size+itemPerPage-1)/itemPerPage
		return maxPage

	nextPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		category = items[2]
		size = Questions.find {category: category, isHandled: false} .count!
		itemPerPage = 1
		maxPage = (size+itemPerPage-1)/itemPerPage

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

	nowCategory: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		return items[2]
}