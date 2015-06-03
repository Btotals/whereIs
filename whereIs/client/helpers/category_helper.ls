<<<<<<< HEAD
Template.solvedBrowse.helpers {
	totalPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		category = items[2]
		size = Questions.find {category: category, isHandled: true} .count!
		itemPerPage = 2
		maxPage = parseInt((size+itemPerPage-1)/itemPerPage)
		return maxPage

	nextPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		items = items.slice -4
		items.splice 0, 0, ''

		category = items[2]
		size = Questions.find {category: category, isHandled: true} .count!
		itemPerPage = 2
		maxPage = parseInt((size+itemPerPage-1)/itemPerPage)

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
		itemPerPage = 2
		maxPage = parseInt((size+itemPerPage-1)/itemPerPage)
		return maxPage

=======
Template.browse.helpers {
>>>>>>> cee88a2d2837fb3f79fda0a5746bf47c554c11cd
	nextPage: !->
		curUrl = Router.current! .url
		items = curUrl.split '/'

		category = items[2]
<<<<<<< HEAD
		size = Questions.find {category: category, isHandled: false} .count!
		itemPerPage = 2
		maxPage = parseInt((size+itemPerPage-1)/itemPerPage)
=======
		size = Questions.find {category: category} .count!
		itemPerPage = 1
		maxPage = (size+itemPerPage-1)/itemPerPage
>>>>>>> cee88a2d2837fb3f79fda0a5746bf47c554c11cd

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