/*
  FCBKcomplete 1.06
  - Jquery version required: 1.2.x, 1.3.x
  
  Changelog:
  - 1.06 auto heigth fix
  		 event bind on main element for better user frendly experience
  		 filter for items
  		 up/down keys supported from now
  
  - 1.05 bindEvents function fixed thanks to idgnarn
  
  - 1.04 IE7 <em> tag replace fixed
  		 
  - 1.03 IE7 & IE6 crash fixed
  		 IE7 css fixed
  
  - 1.02 json parsing fixed
         remove element fixed
         
  - 1.01: some bugs fixed
  
  - 1.0: migration from prototype
*/

/* Coded by: emposha <admin@emposha.com> */
/* Copyright: Emposha.com <http://www.emposha.com/> - Distributed under MIT - Keep this message! */
/*
* elem - input element id or object
* list - preadded elements
* complete - autocomplete div id or object
* ajax - url to fetch json object
* height - maximum number of element shown before scroll will apear
* usefileter - show/hide filtered items
*/

jQuery.facebooklist = function(elem, list, complete, ajax, feed, height, usefilter) {
	var feed_name = feed;
	var addHiddenInput = function(value) {
    	var input = document.createElement('input');      
        $(input).attr({'type': 'hidden', 'name': (elem.attr('id')+'['+value+']'), 'id': (elem.attr('id')+'['+value+']'), 'value': value});
        return input;
  }
  var getChar = function(e) {
		if(window.event) {
			keynum = e.keyCode;
		} else if(e.which) {
  		keynum = e.which;
  	}
  	if (keynum == 8)
  		return '';
  		
  	return String.fromCharCode(keynum);
  }
  var addItem = function(item, preadded) {
			var title = item.html().replace(/<em>/gi,'').replace(/<\/em>/gi,'');
			var value = (item.attr('val') && item.attr('val') != -1 ? item.attr('val') : title);    	
			var li = document.createElement('li');
			var txt = document.createTextNode(title);
			var aclose = document.createElement('a');
			var input = addHiddenInput(value);
		
        $(li).attr({'val': value, 'class': 'bit-box'});
        $(li).prepend(txt);
        $(aclose).attr({'class': 'closebutton','href': '#'});
        li.appendChild(aclose);
        li.appendChild(input);
        holder.appendChild(li);        
        $(aclose).click(function() {
            $(this).parent('li').fadeOut('fast',function() {
                $(this).remove();
            });
            return false;
        });
        if (!preadded) {        
        	holder.removeChild(document.getElementById(feed_name + '_annoninput'));
        	addInput();
        }
        $('.default').show();                     
        feed.hide();
    }
  var addItemFeed = function(data,input) {
		var counter = 1;
		feed.children('li[fckb=2]').remove();
    $.each(data, function(i, val) {
		  if (val.name) {
		    if (usefilter) {
				  if (val.name.indexOf(input)!= -1) {
					  var li = document.createElement('li');
						$(li).attr({'val': val.id,'fckb': '2'});
						$(li).html(val.name.replace(input, '<em>' + input + '</em>'));
						feed.append(li);
						counter++;
					 }
				}
			else {
				var li = document.createElement('li');
				$(li).attr({'val': val.id,'fckb': '2'});
				$(li).html(val.name.replace(input, '<em>' + input + '</em>'));
				feed.append(li);
				counter++;
			}
	  }           
  });
		if (counter > height) {
			feed.css({'height':(height*24)+'px', 'overflow':'auto'}); 
		} else {
			feed.css('height','auto');
		}   	
  }
  var addTextItemFeed = function(value) {
		feed.children('li[fckb=1]').remove();
		var li = document.createElement('li');	        
		$(li).attr({'val':value,'fckb': '1'});
		$(li).html(value);	        
		feed.prepend(li);
  }
    //thanks to idgnarn for fix
  var bindEvents = function () {
		var nowFocusOn;
		var maininput = $('.maininput');
		feed.children('li').hover(
	      function () {
	        $(this).addClass("auto-focus");
					nowFocusOn=$(this);
	      }, 
	      function () {
	        $(this).removeClass("auto-focus");
					nowFocusOn=null;
	      }
	  );      
    feed.children('li').unbind('click');
    feed.children('li').click(function(){
        addItem($(this));
        complete.hide();
    });
		maininput.unbind('keydown');
		maininput.keydown(function(event){
			if (event.keyCode == 13 && nowFocusOn != null) {
				addItem($(nowFocusOn));
				complete.hide();
				event.preventDefault();
			}
			if (event.keyCode == 40) {
				if (typeof(nowFocusOn) == 'undefined' || nowFocusOn.length == 0) {
					nowFocusOn = $(feed.children('li:first'));
					nowFocusOn.addClass("auto-focus");
				}
				else {
					nowFocusOn.removeClass("auto-focus");
					nowFocusOn = nowFocusOn.next('li');
					nowFocusOn.addClass("auto-focus");
				}
			}
			if (event.keyCode == 38) {
				if (typeof(nowFocusOn) == 'undefined' || nowFocusOn.length == 0) {
					nowFocusOn = $(feed.children('li:last'));
					nowFocusOn.addClass("auto-focus");				
				}
				else {
					nowFocusOn.removeClass("auto-focus");
					nowFocusOn = nowFocusOn.prev('li');
					nowFocusOn.addClass("auto-focus");
				}
			}
			if (event.keyCode == 9){
				complete.hide();
			}
		});
  }
  var addInput = function () {
		var li = document.createElement('li');
		var input = document.createElement('input');
		$(li).attr({'class': 'bit-input', 'id': feed_name + '_annoninput'});
		$(input).attr({'type': 'text', 'class': 'maininput'});
		li.appendChild(input);
		holder.appendChild(li);
		$(input).focus(function() {
	    complete.fadeIn('fast');
    });                         
		$(holder).click(function() {
			$(input).focus();
    });
    $(input).keyup(function(event) {
			if (event.keyCode != 40 && event.keyCode != 38) {
				var etext = $(input).val();
				addTextItemFeed(etext);
				if (ajax) {
	  			$.getJSON(ajax + '?tag=' + etext, null, function(data){
		  			addItemFeed(data, etext);
			  		bindEvents();
  			  });
			  } else {
				 bindEvents();
			  }
			  $('.default').hide();
			  feed.show();
		  } else if(event.keyCode == 9){
			  complete.hide();
		  }            
    });
  }    
  if (typeof(elem) != 'object') elem = $(elem);
  if (typeof(list) != 'object') list = $(list);
  if (typeof(complete) != 'object') complete = $(complete);    
  var feed = $(feed);
  var holder = document.createElement('ul');
  elem.css('display','none');
  $(holder).attr('class', 'holder');        
  if (list && list.children('li').length) {        
      $.each(list.children('li'), function(i, val) {
      	addItem($(list.children('li')[i]),1);           
      });
  }
  addInput();
  elem.before(holder);
}