$('a#createCat').click(function(){
        $('#cat').show();
		return false;
});

$('#categorybutton').click(function(){
	$('#cat').hide();	
	$.ajax({
		url: "/categories",
		global: false,
		type: "POST",
		data: ({'category[name]' : $("#addCat_input").val()}),
		dataType: "json",
		success: function(data) {
			$("ul#categories").append("<li><input type='checkbox' value='"+data.id+"' name='article[category_ids][]' id='category_ids' checked=true /><label for='category_ids'>"+data.name+"</label></li>");
		}
	});
	return false;
});

$('a#createTag').click(function(){
        $('#tag').show();
		return false;
});

$('#tagbutton').click(function(){
	
	$('#tag').hide();	
	$.ajax({
		url: "/tags",
		global: false,
		type: "POST",
		data: ({'tag[name]' : $("#addTag_input").val()}),
		dataType: "json",
		success: function(data) {
			$("ul#tags").append("<li><input type='checkbox' value='"+data.name+"' name='article["+data.list+"][]' id='"+data.list+"' checked=true /><label for='"+data.list+"'>"+data.name+"</label></li>");
		}
	});
	return false;
});

