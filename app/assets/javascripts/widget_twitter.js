// When Twitter widget has loaded, do stuff

function createTweet(tweet) {
  var div = document.createElement('div');
  div.className = 'widget-twitter-tweet';

  var tr = document.createElement('tr');
  var tdProfileImage = document.createElement('td');
  var imgProfileImage = document.createElement('img');
  imgProfileImage.src = tweet.profile_image_url;
  var pText = document.createElement('p');
  pText.innerHTML = processTweetLinks(tweet.text);

  var cite = document.createElement('cite');
  var aFromUser = document.createElement('a');
  cite.innerHTML = tweet.from_user_name + ' (<a href="http://twitter.com/' + tweet.from_user +'">@' + tweet.from_user + '</a>)';

  div.appendChild(imgProfileImage);

  var tdFromUser = document.createElement('td');
  aFromUser.href = 'http://twitter.com/' + tweet.from_user;
  tdFromUser.appendChild(aFromUser);


  var tdCreatedAt = document.createElement('td');
  tdCreatedAt.innerHTML = tweet.created_at;

  tr.appendChild(tdProfileImage);
  tr.appendChild(tdFromUser);
  div.appendChild(pText);
  pText.appendChild(cite);
  tr.appendChild(tdCreatedAt);

  return div;
}

// Source: http://stackoverflow.com/questions/8020739/regex-how-to-replace-twitter-links
function processTweetLinks(text) {
  var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/i;
  text = text.replace(exp, "<a href='$1' target='_blank'>$1</a>");
  exp = /(^|\s)#([\wæøåÆØÅ]+)/g;
  text = text.replace(exp, "$1<a href='http://search.twitter.com/search?q=%23$2' target='_blank'>#$2</a>");
  exp = /(^|\s)@([\wæøåÆØÅ]+)/g;
  text = text.replace(exp, "$1<a href='http://www.twitter.com/$2' target='_blank'>@$2</a>");
  return text;
}
