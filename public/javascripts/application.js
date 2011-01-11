// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function validate_field(name, value, field) {
  var postData = { };
  postData['field'] = name;
  postData['value'] = value;
  // Denne må endres på dev for at den skal fungere!
  $.post('/dagingaa/www.isfit.org/admission/positions/validate', postData, function(data) {
      if(data.valid==false) {
      $(field).parent('div').removeClass('field_without_errors');
      $(field).parent('div').addClass('field_with_errors');
      }else{
      $(field).parent('div').removeClass('field_with_errors');
      $(field).parent('div').addClass('field_without_errors');
      }                                                        
      }, 'json');        
}


var delay = (function(){
    var timer = 0;
    return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
    };
    })();

Array.prototype.in_array = function(p_val) {
  for(var i = 0, l = this.length; i < l; i++) {
    if(this[i] == p_val) {
      return true;
    }
  }
  return false;
}

$(document).ajaxSend(function(event, request, settings) {
    if (typeof(AUTH_TOKEN) == "undefined") return;
    settings.data = settings.data || "";
    settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
    });


	/*
		Countdown Timer
		Based on the "Count down until any date script" - By JavaScript Kit 		 	
		(www.javascriptkit.com)
		Author: (c) 2009 Elbert Bautista
		URL: http://www.egTheBlog.com
		Licence : Open Source MIT Licence

	*/

	
	var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")

	function countdown(yr,m,d){
		theyear=yr;themonth=m;theday=d
		var today=new Date()
		var todayy=today.getYear()
		if (todayy < 1000)
		todayy+=1900
		var todaym=today.getMonth()
		var todayd=today.getDate()
		var todayh=today.getHours()
		var todaymin=today.getMinutes()
		var todaysec=today.getSeconds()
		var todaystring=montharray[todaym]+" "+todayd+", "+todayy+" "+todayh+":"+todaymin+":"+todaysec
		futurestring=montharray[m-1]+" "+d+", "+yr
		dd=Date.parse(futurestring)-Date.parse(todaystring)
		dday=Math.floor(dd/(60*60*1000*24)*1)
		dhour=Math.floor((dd%(60*60*1000*24))/(60*60*1000)*1)
		dmin=Math.floor(((dd%(60*60*1000*24))%(60*60*1000))/(60*1000)*1)
		dsec=Math.floor((((dd%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1)
		if(dday==0&&dhour==0&&dmin==0&&dsec==1){
			document.getElementById('counter').style.display='none';
			document.getElementById('expired').style.display='block';
			return
		}
		else{
			document.getElementById('countdown_day').innerHTML=dday;
			document.getElementById('countdown_hour').innerHTML=dhour;
			document.getElementById('countdown_min').innerHTML=dmin;
			document.getElementById('countdown_sec').innerHTML=dsec;
			setTimeout("countdown(theyear,themonth,theday)",1000)
			document.getElementById('Days').innerHTML="Days";
			if (dday == 1)
				document.getElementById('Days').innerHTML="Day";
			document.getElementById('Hours').innerHTML="Hours";
			if (dhour == 1)
				document.getElementById('Hours').innerHTML="Hour";
			document.getElementById('Minutes').innerHTML="Minutes";
			if (dmin == 1)
				document.getElementById('Minutes').innerHTML="Minutes";
			document.getElementById('Seconds').innerHTML="Seconds";
			if (dsec == 1)
				document.getElementById('Seconds').innerHTML="Second";
		}
	}

	var deadline=new Date();
	deadline.setDate(deadline.getDate());
	var deadlineYear = deadline.getYear();
	if (deadlineYear < 1000)
	deadlineYear+=1900