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
    $('#widget-twitter-query').html(q);

    // TODO: display all the tweets
    tweets.forEach(function(tweet){
      $('#widget-twitter-results').append(createTweet(tweet));
    });
    
    $('#widget-twitter-article').css("height", "400px");
    $('#widget-twitter-article').css("overflowY", 'scroll');
  }

});


