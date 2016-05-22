$(document).ready(function() {
	$("a.add-flag-data").on("click", function()
	{
		var flag_id = $(this).attr("data-flag-id");
		console.log(flag_id);
		if ($("input#new-data-key-input").length > 0)
		{
			var newKey = $("input#new-data-key-input").val();
			var newValue = $("input#new-data-value-input").val();

			var request = new XMLHttpRequest();
			request.onload = callback;
			request.open("post", "/flags/add_data");
			request.setRequestHeader("Content-Type", "application/json");
			request.send('{"flag_id":"' + flag_id + '","key":"' + newKey + '","value":"' + newValue + '"}');
			return;
		}
		$(this).closest("tr").before("<tr><td class='col-md-2'><input type='text' class='form-control' id='new-data-key-input' placeholder='Key'></input></td><td class='col-md-10'><input type='text' class='form-control' id='new-data-value-input' placeholder='Value'></input></td></tr>");
	});
	function callback () {
		if (this.responseText == "success")
		{
			var newKey = $("input#new-data-key-input").val();
			var newValue = $("input#new-data-value-input").val();

			$("input#new-data-value-input").closest("tr").remove();

			$("table#flag-data-table a.add-flag-data").closest("tr").before("<tr><td class='col-md-2'>" + newKey + "</td><td class='col-md-10'>" + newValue + "</td></tr>");
		}
	};
})
