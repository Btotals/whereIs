Template['addQuestion'].events({
	'submit form': function(e){
		e.preventDefault();


		// 积分足够才能发布
		var thisReward = +($(e.target).find('[name=questionReward]').val());
		var myScore = Meteor.user().profile.score;
		if (thisReward > myScore) {
			alert("积分不足!");
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


		// 新增问题
		var question = {
			title: $(e.target).find('[name=questionTitle]').val(),
			content: $(e.target).find('[name=questionContent]').val(),
			addTime: time,
			askerID: Meteor.user()._id,
			askerNickname: Meteor.user().profile.nickname,
			category: $(e.target).find('[name=questionCategory]:checked').val(),
			reward: +($(e.target).find('[name=questionReward]').val()),
			totalAnswer: 0,
			isHandled: false,
			answers: []
		};
		question._id = Questions.insert(question);


		//发布者的questions中加入该问题
		var myQuestions = Meteor.user().profile.questions;

		var question2 = {
			questionId: question._id,
			title: question.title,
			addTime: question.addTime,
			category: question.category,
			reward: question.reward,
			isHandled: false
		};
		myQuestions.push(question2);

		var count = Meteor.user().profile.totalAsk+1;
		Meteor.users.update(Meteor.user()._id, {
			$set: {'profile.questions': myQuestions, 'profile.totalAsk': count, 'profile.score': myScore-thisReward}
		}, function(error) {
			if (error) {
				console.log("发布者的questions中加入该问题失败");
			} else {
				console.log("发布者的questions中加入该问题成功");
			}
		});


		Router.go('/questiondetail/'+question._id);
	}
});