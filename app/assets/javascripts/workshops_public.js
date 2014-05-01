$(document).ready(function(){
	$( ".ch-item" ).each(function(){

    var color = '#'+ Math.round(0xffffff * Math.random()).toString(16);

    
    var posx = (Math.random() * ($('.mainsection').width() - 200));
    var posy = (Math.random() * ($('.mainsection').height() - 200));
    
    $(this).css({
        'left':posx+'px',
        'top':posy+'px',
        'background-color': color

    });
	});
        
    }); 


