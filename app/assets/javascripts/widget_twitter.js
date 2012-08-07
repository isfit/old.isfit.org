// When Twitter widget has loaded, do stuff
$('#widget-twitter').ready(function(){
	var searchUrl = 'http://search.twitter.com/search.json?callback=?&q=';
	var q = 'http://isfit.org';
	var url = searchUrl + q;
	var data = '';
	

	$.ajax({
		url: url,
		dataType: 'jsonp',
		data: data,
		success: callback
	});
});
function callback(data) {

	// TODO: display all the tweets
	var tweet = 0;

	var tr = document.createElement('tr');
	var tdProfileImage = document.createElement('td');
	var imgProfileImage = document.createElement('img');
	imgProfileImage.src = data.results[tweet].profile_image_url;
	tdProfileImage.appendChild(imgProfileImage);

	var tdFromUser = document.createElement('td');
	var aFromUser = document.createElement('a');
	aFromUser.innerHTML = '@' + data.results[tweet].from_user;
	aFromUser.href = 'http://twitter.com/' + data.results[tweet].from_user;
	tdFromUser.appendChild(aFromUser);

	var tdText = document.createElement('td');
	tdText.innerHTML = data.results[tweet].text;
	
	var tdCreatedAt = document.createElement('td');
	tdCreatedAt.innerHTML = data.results[tweet].created_at;

	tr.appendChild(tdProfileImage);
	tr.appendChild(tdFromUser);
	tr.appendChild(tdText);
	tr.appendChild(tdCreatedAt);

	document.getElementById('widget-twitter-results').appendChild(tr);
}