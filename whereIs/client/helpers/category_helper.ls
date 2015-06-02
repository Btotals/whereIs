Template.browse.helpers {
	totalPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -3
		items.splice 0, 0, ''

		category = items[2]
		size = Questions.find {category: category} .count!
		itemPerPage = 1
		maxPage = (size+itemPerPage-1)/itemPerPage
		return maxPage

	nextPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -3
		items.splice 0, 0, ''

		category = items[2]
		size = Questions.find {category: category} .count!
		itemPerPage = 1
		maxPage = (size+itemPerPage-1)/itemPerPage

		nowPage = items[3]
		if +nowPage is maxPage
			return '#'
		items.pop!
		items.push +nowPage+1
		return items.join '/'

	prevPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -3
		items.splice 0, 0, ''

		nowPage = items[3]
		if +nowPage < 2
			return '#'
		items.pop!
		items.push +nowPage-1
		return items.join '/'
}