// Custom Javascrpts go here
jQuery.selectNavLink = function(controller){
	var routeMappings = new Object({
		brand: "settings",
		account: "settings",
		role: "settings",
		medium: "settings",
		mediumtype: "settings",
		organizationtype: "settings",
		tagtypes: "settings",
		section: "settings",
		category: "settings",
		tag: "settings"
	});
	
	$("#nav li").each(function(i){
	  var target = this.innerHTML.match(/"\/(\w+)/)[1];
   	var action = this.innerHTML.match(/\/(\w+)%20/);
    if(action)
      action = action[1];
	  var url = window.location.pathname.match(/\/(\w+)/)[1];
	  if(routeMappings[url])
	    url = routeMappings[url];
	  if(url == target && action != "logout"){
			$("#nav li:eq("+ i +")").addClass("active");
		}               
	});
}