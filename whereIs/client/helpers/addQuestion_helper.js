Template['addQuestion'].events({
	'submit form': function(e){
		e.preventDefault();

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

		var question = {
			title: $(e.target).find('[name=questionTitle]').val(),
			content: $(e.target).find('[name=questionContent]').val(),
			addTime: time,
			askerID: Meteor.user()._id,
			category: $(e.target).find('[name=questionCategory]:checked').val(),
			reward: $(e.target).find('[name=questionReward]').val(),
			totalAsk: 0,
			isHandled: false,
			answers: []
		};

		question._id = Questions.insert(question);
		console.log(question);
		Router.go('/');
	}
});