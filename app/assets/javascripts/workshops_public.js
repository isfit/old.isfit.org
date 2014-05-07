$(document).ready(function(){

    $('body aside').remove();
    $('#content').attr('class', 'span12');

    

	$( ".outer" ).each(function(){

    //var color = '#'+ Math.round(0xffffff * Math.random()).toString(16);
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    var counter = 0;
    for (var i = 0; i < 6; i++ ) {
        var colorLetter = letters[Math.round(Math.random() * 15)];
        if((color.indexOf('F') != -1 && colorLetter === 'F') || ((i === 0 || i === 1)&& color.indexOf('F') != -1)){
            var newLetters = '0123456789ABCDE'.split('');
            var colorLetter = letters[Math.round(Math.random() * 15)];
        }
        color += colorLetter;


    }



    var tempRank = $(this).attr('rank');
   
    //if(tempRank > 10){
        
    var rank = ((18-$(this).attr('rank'))/18) + 0.3;
        //var tempReSize = ((18-$(this).attr('rank'))/18) + 0.8;
    //}
    //else{
        //var rank = tempReSize;
    //}
    var width = $(this).width() * rank;
    var height = $(this).height() * rank;
    var workshopNameLength = $(this).children().text().length;

    if($(this).children().text().trim() == "The Picture") {
        width += 50;
        height += 50;
    }

    if($(this).children().text().trim() == "?") {
        width += 150;
        height += 150;
    }

    if(workshopNameLength > 20 && width < 150){
        width +=100;
        height +=100;
    }
   //var width1 = $(this).parent().width() * rank;
   //var height1 = $(this).parent().height() * rank;



    var posx = (Math.random() * ($('.well').width() - 400));
    var posy = (Math.random() * (600));

    
    $(this).css({
        'background-color': color,
        //'left':posx+'px',
        //'bottom':posy+'px',
        'height': height,
        'width': width,
        'line-height': height + 'px'

    });
    posx = 0;
    posy = 0;
	});

        
    }); 


