// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require ambassadors
//= require bootstrap
//= require underscore
//= require backbone
//= require workshops_public


// TABS
$(document).ready(function(){
	$('li.dropdown').hover(function(e) {
		$(e.currentTarget).toggleClass('open');
	});
});

function loadVideo() {
	var video = '<iframe src="http://player.vimeo.com/video/47441322?title=0&amp;byline=0&amp;portrait=0&amp;color=d6351a" width="100%" height="100%" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>';
	$('#video-replacement').replaceWith(video);
}