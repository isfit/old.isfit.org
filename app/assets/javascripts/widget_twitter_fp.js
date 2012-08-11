var displayTimeout = 10000; //in ms
var numberOfTweets = 15; //set by the twitter search api. Changeable?

$('widget-twitter-fp').ready(function() {
	var query = '@isfit%20OR%20#isfit';
	var searchUrl = 'http://search.twitter.com/search.json?callback=?&q=';
	var url = searchUrl + query;
	var data = '';

	$.ajax({
		url: url,
		dataType: 'jsonp',
		data: data,
		success: callback
	});

	//window.setTimeout(moveLeft, displayTimeout);
});

function callback(data) {
	var tweets = data.results;

	tweets.forEach(function(tweet){
		var article = document.createElement('article');
		article.className = 'tweet';
		article.appendChild(createTweet(tweet));
		document.getElementById('widget-twitter-fp').getElementsByClassName('twitter-widget-fp-content')[0].appendChild(article);
	})
}

var twt = 0;
function moveLeft() {
	var l = $('#widget-twitter-fp .twitter-widget-fp-content');
	l.css('left', -279*twt);
	if(twt==14){
		twt=0;
	}
	else {
		twt++;
	}

	window.setTimeout(moveLeft, displayTimeout);
}