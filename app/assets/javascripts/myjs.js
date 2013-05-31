
//navbar active highlight
jQuery(document).ready(function($){
    $('.toggle_active').hover(
         function(){ $(this).addClass('active') },
         function(){ $(this).removeClass('active') }
    )
});

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


/*********************** mouseover for container animation height
//mouse inFunction, expands cont to back's size
$(document).ready(function(){
  $(".bp_cont").mouseenter(function(){
    var $this = $(this);
    var $inner = $this.find(".back");
    if ($inner.height() > $this.height() ) { 
    	$this.animate({height: $inner.height() }, {duration:300} );
	}
  });
});

//mouse outFunction, shrinks cont to front's size
$(document).ready(function(){
  $(".bp_cont").mouseleave(function(){
    var $this = $(this);
    var $inner = $this.find(".front");
    if ($inner.height() < $this.height() ) { 
    	$this.delay(1100).animate({height: $inner.height() } );
	}
  });
});
**********************/

//toggle for just the container animation height

$('.bp_card_class').toggle(function() {  //first click
	var $this = $(this);
    var $inner = $this.find(".back");
    if ($inner.height() >= $this.height() ) {  
      var diff = $inner.height() - $this.height();
    	$this.animate( { height: "+="+diff+"px" }, 300 ); //expand cont if back bigger
	}	
    if ($inner.height() < $this.height() ) {   
    	$this.delay(300).animate({height: $inner.height() } );  //shrink cont if back smaller ******
	}
}, function() {   //second click
	var $this = $(this);
    var $inner = $this.find(".front");
    if ($inner.height() < $this.height() ) {   
    	$this.delay(400).animate({height: $inner.height() } );  //shrink cont if front smaller
	}
    if ($inner.height() >= $this.height() ) { 
    	$this.delay(300).animate({height: $inner.height() }, 300 );  //expand cont if front bigger **
	}
});


//rotate card toggle

$('.bp_card_class').toggle(function() {
  $(this).css('transform','rotateY(180deg)');
}, function() {
  $(this).css('transform','rotateY(360deg)');
});

//-webkit-rotate card toggle

$('.bp_card_class').toggle(function() {
  $(this).find('.front').animate( {opacity: 0 }, 450 );
  $(this).find('.back').delay(500).animate( {opacity: 1 }, 1000 );
  $(this).css('-webkit-transform','rotateY(180deg)');
}, function() {
  $(this).find('.front').animate( {opacity: 1 }, 200 );
  //$(this).find('.front').css('visibility', 'visible');
  $(this).css('-webkit-transform','rotateY(360deg)');
});



//combined, toggle rotate and toggle cont exp/shrink
/***************
$('.bp_card_class').toggle(function() {
	var $this = $(this);
    var $inner = $this.find(".back");
    if ($inner.height() > $this.height() ) { 
    	$this.animate({height: $inner.height() }, "fast" );
	}
	$(this).delay(1000).css('transform','rotateY(180deg)');
}, function() {
	$(this).css('transform','rotateY(360deg)');
	var $this = $(this);
    var $inner = $this.find(".front");
    if ($inner.height() < $this.height() ) { 
    	$this.delay(1100).animate({height: $inner.height() } );
	}
});
**************/

/********* Comment Prompt ***********
//expand cont on mouseenter for comment prompt
$(document).ready(function(){
  $(".bp_cont").mouseenter(function(){
    var $this = $(this);
    var $inner = $this.find(".comment_prompt");
    $this.animate({height: $inner.height()+$this.height() }, {duration:300} );
  });
});

//shrink cont on mouseleave for comment prompt
$(document).ready(function(){
  $(".bp_cont").mouseleave(function(){
    var $this = $(this);
    var $inner = $this.find(".comment_prompt"); 
	$this.animate({height: $this.height()-$inner.height() }, {duration:300} );	
  });
});
*******************************/


//allow links to be clicked in card despite toggle event
$('.bp_card_class a').click(function(e){
    e.stopPropagation();
});
//testbox
$('.box').each(function(){
    var $this = $(this);
    var $inner = $this.find(".inner");
    $inner.height( $this.height() );
});
