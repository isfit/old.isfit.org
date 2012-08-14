// $('#ideas-wrapper').ready(function(){
	
// 	var url = "https://api.facebook.com/method/fql.query?query=select%20total_count,like_count,comment_count,share_count,click_count%20from%20link_stat%20where%20url='http://isfit.org/ideas/5'&format=json";

// 	$.get(url, fuckit);

// 	// Display all
// 	$('#ideas-wrapper').css('opacity', '1');
// });

// function fuckit(data) {
// 	console.log(data);
// }

function checkFacebook() {
	if(window.FB!==undefined) {
		FB.Event.subscribe('edge.create',
		    function(response) {
		    	var temp = response.split('/');
		    	facebookExperiment(temp[temp.length-1]);
		    }
		);
	}
	else {
		console.log('not ready');
		window.setTimeout(checkFacebook, 20); // Resonable delay?
	}
}

checkFacebook();

function facebookExperiment(id) {
	var url = 'http://www.isfit.org/ideas/'+ id +'/update';
	$.get(url, function(data){console.log('pinged!')});
}