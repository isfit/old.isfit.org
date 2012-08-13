var q = 'http://isfit.org/';

$('#widget-twitter-article').ready(function(){
  var searchUrl = 'http://search.twitter.com/search.json?callback=?&q=';
  var url = searchUrl + q;
  var data = '';
  
  $.ajax({
    url: url,
    dataType: 'jsonp',
    data: data,
    success: callback
  });
  function callback(data) {
    var tweets = data.results;
    document.getElementById('widget-twitter-query').innerHTML = q;

    // TODO: display all the tweets
    console.log(tweets);
    tweets.forEach(function(tweet){
      document.getElementById('widget-twitter-results').appendChild(createTweet(tweet));
    });
    
    document.getElementById('widget-twitter-article').style.height = '400px';
    document.getElementById('widget-twitter-article').style.overflowY = 'scroll';
  }

});


