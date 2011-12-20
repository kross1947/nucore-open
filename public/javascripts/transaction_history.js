$(function() {
	$("select[multiple]").chosen();
	
	$(".datepicker").datepicker({maxDate: new Date()});
	// call trigger("change") to make sure that it updates on page load
	$(".datepicker[name=start_date]").change(DatePickerRange.updateEndMaxDate).trigger("change");
	$(".datepicker[name=end_date]").change(DatePickerRange.updateStartMinDate).trigger("change");
	
	
	
});

var DatePickerRange = {
	updateEndMaxDate: function() {
		$val = $(this).val();
		if ($val) {
			var start = Date.parse($val);
			$(".datepicker[name=end_date]").datepicker("option", {minDate: start });
		}
	},
	updateStartMinDate: function() {
		$val = $(this).val();
		if ($val) {
			var end = Date.parse($val);
			$(".datepicker[name=start_date]").datepicker("option", {maxDate: end});
		}
	}
		
}

$(function() {
	$("#facilities").change(function() {
		var facilitiesValues = $(this).val();
		if (facilitiesValues == null || facilitiesValues.length == 0) {
			$("#products option").each(function() {
				$(this).removeAttr("disabled");
			});
		} else {
			$("#products option").each(function() {
				if (facilitiesValues.indexOf($(this).attr("data-facility")) > -1) {
					$(this).removeAttr("disabled");
				} else {
					$(this).attr("disabled", "disabled").removeAttr("selected");
				}
			});
		}
		$("#products").trigger("liszt:updated")
	});
});