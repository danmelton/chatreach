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
			$("select#text_content_category_ids").append("<option value='"+data.id+"' selected=true>"+data.name+"</option>");
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
			$("select#text_content_"+data.list+"").append("<option value='"+data.name+"' selected=true>"+data.name+"</option>");
		}
	});
	return false;
});

