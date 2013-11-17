jQuery(function(){
	var data = {
					condition: ["todo","do","done","finish"]
				};
	console.log(data["condition"]);
	jQuery("#task").tmpl({data: data}).appendTo("#task_area");
});