$(document).ready(function(){

    $('body aside').remove();
    $('#content').attr('class', 'span12');

    

	$( ".ch-item" ).each(function(){

    var color = '#'+ Math.round(0xffffff * Math.random()).toString(16);


   var rank = 1/$(this).attr('rank');
   var width = $(this).width() * rank;
   var height = $(this).height() * rank;
   var width1 = $(this).parent().width() * rank;
   var height1 = $(this).parent().height() * rank;

    $(this).parent().css({
        'height': height1,
        'width': width1    
    });

    var posx = (Math.random() * ($('.mainsection').width() - 200));
    var posy = (Math.random() * ($('.mainsection').height() - 200));
    
    $(this).css({
        //'left':posx+'px',
        //'margin-top':posy+'px',
        'background-color': color,
        'height': height,
        'width': width

    });
    posx = 0;
    posy = 0;
	});

        
    }); 


