//testbox
$('.box').each(function(){
    var $this = $(this);
    var $inner = $this.find(".inner");
    $inner.height( $this.height() );
});

//navbar
jQuery(document).ready(function($){
    $('.toggle_active').hover(
         function(){ $(this).addClass('active') },
         function(){ $(this).removeClass('active') }
    )
});

//example
function resizeElementHeight(element) {
  var height = 0;
  var body = window.document.body;
  if (window.innerHeight) {
      height = window.innerHeight;
  } else if (body.parentElement.clientHeight) {
      height = body.parentElement.clientHeight;
  } else if (body && body.clientHeight) {
      height = body.clientHeight;
  }
  element.style.height = ((height - element.offsetTop) + "px");
}

//flip resize, front card height takes back card height if nec
/*
$('.bp_cont').each(function(){
    var $this = $(this);
    var $inner = $this.find(".back");
    if ($inner.height() > $this.height() ) { 
    	$this.height( $inner.height() );
	}
});
*/
/* //flip resize, shrinks cont to front's size
$('.bp_cont').each(function(){
    var $this = $(this);
    var $inner = $this.find(".front");
    if ($inner.height() < $this.height() ) { 
    	$this.height( $inner.height() );
	}
});
*/

/*
$(document).ready(function(){
  $(".bpost_").mouseenter(function(){
    $('.bpost_').each(function(){ //mouse inFunction, expands cont to back's size
	    var $this = $(this);
	    var $inner = $this.find(".back");
	    if ($inner.height() > $this.height() ) { 
	    	$this.animate({height: $inner.height() } );
		}
    });
  });
});
*/

//mouse inFunction, expands cont to back's size
$(document).ready(function(){
  $(".bp_cont").mouseenter(function(){
    var $this = $(this);
    var $inner = $this.find(".back");
    if ($inner.height() > $this.height() ) { 
    	$this.animate({height: $inner.height() } );
	}
  });
});

//mouse outFunction, shrinks cont to front's size
$(document).ready(function(){
  $(".bp_cont").mouseleave(function(){
    var $this = $(this);
    var $inner = $this.find(".front");
    if ($inner.height() < $this.height() ) { 
    	$this.delay(3000).animate({height: $inner.height() } );
	}
  });
});