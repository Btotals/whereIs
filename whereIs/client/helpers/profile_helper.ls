Template['profile'].onRendered !->
	this.$ '#datetimepicker' .datetimepicker {
		format: 'YYYY-MM-DD'
	}

Template['profile'].helpers {
	birthdate : !->
		if Meteor.user!
			return Meteor.user().profile['birthdate']

	nickname : !->
		if Meteor.user!
			return Meteor.user().profile['nickname']

	isMale : !->
		if Meteor.user!
			return Meteor.user().profile['gender'] is 'male'

	college : !->
		if Meteor.user!
			return Meteor.user().profile['college']

	score : !->
		if Meteor.user!
			return Meteor.user().profile['score']

	totalLike: !->
		if Meteor.user!
			return Meteor.user().profile['totalLike']

	totalAsk: !->
		if Meteor.user!
			return Meteor.user().profile['totalAsk']

	totalAnswer: !->
		if Meteor.user!
			return Meteor.user().profile['totalAnswer']

	totalBest: !->
		if Meteor.user!
			return Meteor.user().profile['totalBest']

	bestRate: !->
		if Meteor.user!
			totalBest = +(Meteor.user().profile['totalBest'])
			totalAsk = +(Meteor.user().profile['totalAsk'])
			if totalAsk is 0
				return '0%'
			return (totalBest/totalAsk).toFixed(1)*100 + '%'

}

Template['profile'].events {
	'click #saveProfile': (e, t) !->
		e.prevent-default!

		nickname = t.find '#nickname' .value
		birthdate = t.find '#datetimepicker' .value
		college = $ '#college option:selected' .val!
		gender = $ '[name="gender"]:checked' .val!

		UserProperties = {
			'profile.nickname': nickname,
			'profile.birthdate': birthdate,
			'profile.college': college,
			'profile.gender': gender
		}

		Meteor.users.update Meteor.user!._id, {$set: UserProperties}, (error) !->
			if error
				$ '#failBox' .text '更新成功'
				alert "更新失败"
				#$ '.personalInfo' .append '<div class="alert alert-danger" role="alert">更新失败！</div>'
			else
				alert "更新成功"
				#$ '.personalInfo' .append '<div class="alert alert-info" role="alert">更新成功！</div>'

	'keyup #newAgain': (e, t) !->
		e.prevent-default!

		newP = $ '#newPassword' .val!
		again = $ '#newAgain' .val!

		if newP is again and newP isnt ''
			$ '#changePassword' .remove-attr 'disabled' 
		else
			$ '#changePassword' .attr 'disabled' 'disabled'

	'keyup #newPassword': (e, t) !->
		e.prevent-default!

		newP = $ '#newPassword' .val!
		again = $ '#newAgain' .val!

		if newP is again and newP isnt ''
			$ '#changePassword' .remove-attr 'disabled' 
		else
			$ '#changePassword' .attr 'disabled' 'disabled'

	'click #changePassword': (e, t) !->
		e.prevent-default!

		oldP = $ '#oldPassword' .val!
		newP = $ '#newPassword' .val!

		Accounts.changePassword oldP, newP, (err)!->
			if err
				alert '修改密码失败！'
			else
				alert '修改密码成功！'
}
