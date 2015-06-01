/*
- 用户ID  (_id[ObjectID]，用户唯一标识)

- 邮箱     (email[string]，登陆用的账号)
- 密码     (password[string])
- 资料     (profile)
    - 昵称          (nickname[string]，用于显示的昵称)
    - 性别          (gender[string])
    - 生日          (birthdate[string])
    - 学校          (college[string])
    - 积分          (score[int]，可用于悬赏)
    - 提问数         (totalAsk[int])
    - 回答数         (totalAnswer[int])
    - 被赞数         (totalLike[int])
    - 被采纳数       (totalBest[int])
    - 是否上传头像    (uploadHead[bool])
    - 回答过的问题           (answers[ObjectID数组])
    - 提出的问题            (questions[ObjectID数组])
    - 被采纳的回答对应问题    (bests[ObjectID数组])
    - 点赞过的回答           (likes[ObjectID数组])
*/


Template.register.events {
	'submit #register-module': (e, t) !->
		e.prevent-default!

		nickname = t.find '#nickname' .value
		password = t.find '#password' .value
		email = t.find '#email' .value
		console.log name
		console.log password
		console.log email

		Accounts.create-user {email: email, password: password, 
		profile: {nickname: nickname, gender:'male', birthdate: '2000-01-01', college: 'unknown', score: 0,
		totalAsk: 0, totalAnswer: 0, totalLike: 0,totalBest: 0, uploadHead: false,
		answers: [], questions: [], bests: [], likes: []}}, (err)->
			if err then console.log err
			else Router.go '/profile'
}