// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery-3.3.1
//= require rails-ujs
//= require activestorage
//= require jquery.mousewheel.pack
//= require jquery.fancybox.pack
//= require jquery.fancybox-buttons
//= require sync
//= require cable
//= require turbolinks
//= require_self
//= require_tree .

(function ($, F) {
F.transitions.resizeIn = function() {
    var previous = F.previous,
        current  = F.current,
        startPos = previous.wrap.stop(true).position(),
        endPos   = $.extend({opacity : 1}, current.pos);
    startPos.width  = previous.wrap.width();
    startPos.height = previous.wrap.height();
    previous.wrap.stop(true).trigger('onReset').remove();
    delete endPos.position;
    current.inner.hide();
    current.wrap.css(startPos).animate(endPos, {
        duration : current.nextSpeed,
        easing   : current.nextEasing,
        step     : F.transitions.step,
        complete : function() {
            F._afterZoomIn();
            current.inner.fadeIn("fast");
        }
    });
};
}(jQuery, jQuery.fancybox));

$(".fancybox")
  .attr('rel', 'gallery')
  .fancybox({parent: "body",
      nextMethod : 'resizeIn',
      nextSpeed  : 250,
      prevMethod : false,
      helpers : {
          title : {
              type : 'inside'
          }
      }
  });
$(".fancybox2").fancybox({
    helpers : {
     overlay: {
      css: {'background-color': '#03C3DC'}
     }
    },
    beforeLoad: function() {
        $(this.href).height('auto');
    },
    beforeChange: function() {
        $(this.href).height('170');
    },
    beforeClose: function() {
        $(this.href).height('170');
    },
    parent: "body",
    width: 1000,
    arrows: false,
    border: 0,
    margin: [0,0,0,0],
    padding: [0,0,0,0],
    closeClick: false,
    openEffect: 'none',
    closeEffect: 'none'
});

function startTime() {
  var today = new Date();
  var d = today.getDate();
  var mo = today.getMonth() + 1;
  var y = today.getFullYear();
  var h = today.getHours();
  var m = today.getMinutes();
  var s = today.getSeconds();
  m = checkTime(m);
  s = checkTime(s);
  document.getElementById('txt').innerHTML =
  d + "-" + mo + "-" + y + " " + h + ":" + m + ":" + s;
  var t = setTimeout(startTime, 500);
}

function checkTime(i) {
  if (i < 10) {i = "0" + i};
  return i;
}

$(document).on('turbolinks:load', function() {
  $(function() {
    $("#tickets_search").change(function() {
      $.get($("#tickets_search").attr("action"), $("#tickets_search").serialize(), null, "script");
      return false;
    });
  });
});

$(document).on('turbolinks:load', function() {
  $(function() {
    $("#users_search").change(function() {
      $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script");
      return false;
    });
  });
});

function display(i) {
  var x = document.getElementById("add");
  if (x.style.display === "none") {
      x.style.display = "block";
  } else {
      x.style.display = "none";
  }
};

$('#tabs').click(function (e) {
	e.preventDefault()
	$("#tabs li").removeClass('active')
	$(this).parent().addClass('active')
	$(this).tab('show')
});

function scrollBoard() {
  var element = document.getElementById("board");
  if (typeof(element) != 'undefined' && element != null) {
    if((element.scrollHeight - element.clientHeight) <= element.scrollTop){
      element.scrollTop = 0;
    }
  }
};

setInterval(scrollBoard,10000);

$(document).on('turbolinks:load', function() {
  $('#selectAll').click(function() {
     if (this.checked) {
         $('.c1').each(function() {
             this.checked = true;
         });
     } else {
        $('.c1').each(function() {
             this.checked = false;
         });
     }
  });
  $('#selectAll1').click(function() {
     if (this.checked) {
         $('.c2').each(function() {
             this.checked = true;
         });
     } else {
        $('.c2').each(function() {
             this.checked = false;
         });
     }
  });
});
