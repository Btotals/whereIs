/*
内容 (content[string]，回答内容)
回答时间 (addTime[string])
热度 (heat[int]，被赞+1，被踩-1)
回答者ID (answererID[ObjectID]，回答者的ID)
回答者nickname (answererNickname[string]，回答者的nickname)
评价过这条回答的人ID (viewers[ObjectID数组])
是否被采纳 (isBest[bool])
*/

Template['questionDetail'].events({
	'click #selectBest': function(e) {
		e.preventDefault();

		var answererId = $("#selectBest").attr("answerer");

		var curUrl = Router.current().url;
		var items = curUrl.split('/');
		var questionId = items[items.length-1];


		var question = Questions.findOne(questionId);


		// 当前问题isHandled，问题中当前回答isBest
		var answers = question.answers;

		for (var i = 0; i < answers.length; i++) {
			if (answers[i].answererId == answererId) {
				answers[i].isBest = true;
			}
		}

		Questions.update(questionId, {
			$set: {answers: answers, isHandled: true}
		}, function(error) {
			if (error) {
				alert("失败");
			} else {
				alert("成功");
			}
		});


		// 回答者totalBest加一，answers中该问题isBest，积分加悬赏分
		var answerer = Meteor.users.findOne(answererId);

		var answererScore = answerer.profile.score;
		var answererBest = answerer.profile.totalBest;
		var answererAnswers = answerer.profile.answers;

		for (i = 0; i < answererAnswers.length; i++) {
			if (answererAnswers[i].questionId == questionId) {
				answererAnswers[i].isBest = true;
				break;
			}
		}
		
		Meteor.users.update(answererId, {
			$set: {'profile.score': answererScore+question.reward, 'profile.totalBest': answererBest+1, 'profile.answers': answererAnswers}
		}, function(error) {
			if (error) {
				console.log("处理回答者失败");
			} else {
				console.log("处理回答者成功");
			}
		});


		// 提问者当前问题isHandled
		var asker = Meteor.users.findOne(question.askerID);
		var askerQuestions = asker.profile.questions;

		for (i = 0; i < askerQuestions.length; i++) {
			if (askerQuestions[i].questionId == questionId) {
				askerQuestions[i].isHandled = true;
				break;
			}
		}

		Meteor.users.update(question.askerID, {
			$set: {'profile.questions': askerQuestions}
		}, function(error) {
			if (error) {
				console.log("处理提问者失败");
			} else {
				console.log("处理提问者成功");
			}
		});
	},

	'submit form': function(e) {
		e.preventDefault();


		// 每个问题只能回答一次，不能回答自己的问题
		var answers = this.Question.answers;
		for (var i = 0; i < answers.length; i++) {
			if (answers[i].answererId == Meteor.user()._id) {
				alert("你已回答过此问题!");
				return;
			}
		}

		if (this.Question.askerID == Meteor.user()._id) {
			alert("不能回答自己的问题!");
			return;
		}


		// 获取当前时间
		var formatDate = function(date, format) {
			var o = { 
				"M+" : date.getMonth()+1, //month 
				"d+" : date.getDate(), //day 
				"h+" : date.getHours(), //hour 
				"m+" : date.getMinutes(), //minute 
				"s+" : date.getSeconds(), //second 
				"q+" : Math.floor((date.getMonth()+3)/3), //quarter 
				"S" : date.getMilliseconds() //millisecond 
			} 

			if(/(y+)/.test(format)) { 
				format = format.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length)); 
			} 

			for(var k in o) { 
				if(new RegExp("("+ k +")").test(format)) { 
					format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
				} 
			}
			return format;
		}

		var now = new Date();
		var time = formatDate(now, "yyyy-MM-dd hh:mm");


		// 当前问题的answers中加入该回答
		var answer = {
			content: $(e.target).find('[name=answerContent]').val(),
			addTime: time,
			heat: 0,
			answererId: Meteor.user()._id,
			answererNickname: Meteor.user().profile.nickname,
			viewers: [],
			isBest: false
		};

		var count = this.Question.totalAnswer + 1;
		
		answers.push(answer);
		
		Questions.update(this.Question._id, {
			$set: {answers: answers, totalAnswer: count}
		}, function(error) {
			if (error) {
				alert("失败");
			} else {
				alert("成功,,获得5积分！");
			}
		});


		// 回答者的answers中加入该问题
		var myAnswers = Meteor.user().profile.answers;

		var targetQuestion = {
			questionId: this.Question._id,
			title: this.Question.title,
			addTime: this.Question.addTime,
			category: this.Question.category,
			reward: this.Question.reward,
			isBest: false              // whether this user's answer is selected to be the best one
		}
		myAnswers.push(targetQuestion);

		var count = Meteor.user().profile.totalAnswer+1;
		var score = Meteor.user().profile.score;
		Meteor.users.update(Meteor.user()._id, {
			$set: {'profile.answers': myAnswers, 'profile.totalAnswer': count, 'profile.score': score+5}
		}, function(error) {
			if (error) {
				console.log("回答者的answers中加入该问题失败");
			} else {
				console.log("回答者的answers中加入该问题成功");
			}
		});
	}
});