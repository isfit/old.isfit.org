// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
    $("#stuff_item_id").change(function() {
      temp = $(this).val();
      str = "/~skjervum/internal.isfit.org/2011/public/images/article/photos/original_pictures/"+temp+"/thumb.jpg"; 
      //    temp2 = $("#img_pre").attr("src");
      $("#img_pre").attr("src", str);
      url = "##pic "+temp+" 1 pic##"
      $("#img_full").html(url)
      url = "##pic "+temp+" 2 pic##"
      $("#img_right").html(url)
      url = "##pic "+temp+" 3 pic##"
      $("#img_left").html(url)
      //$.post("update_picture.js", $(this).serialize(), null, "script");
      return false;
      })
    })

