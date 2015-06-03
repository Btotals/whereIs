Template.browse.helpers {
	nextPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

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
		nowPage = items[3]
		if +nowPage < 2
			return '#'
		items.pop!
		items.push +nowPage-1
		console.log (items.join '/')
		return items.join '/'
}