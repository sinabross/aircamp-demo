$(document).ready(
		function() {
			var deviceWidth = $(document).width()
			var indexHomeThumbnail = 0;

			$("#btnLogin").click(clickLoginMenu())

			$("#searchEndDatepicker").focusout(
					function() {
						var sdateHome = $("#searchStartDatepicker").val()
						var dateHomeSplit = sdateHome.split("-")
						var comparSdateHome = dateHomeSplit[0]
								+ dateHomeSplit[1] + dateHomeSplit[2]
						var edateHome = $("#searchEndDatepicker").val()
						var dateHomeSplit = edateHome.split("-")
						var comparEdateHome = dateHomeSplit[0]
								+ dateHomeSplit[1] + dateHomeSplit[2]
						if (comparEdateHome < comparSdateHome) {
							$("#searchEndDatepicker").val("")
							alert("반납일이 대여일보다 앞에 있습니다.")
						}
					})

			$("#searchEndDatepicker").change(
					function() {
						var sdateHome = $("#searchStartDatepicker").val()
						var dateHomeSplit = sdateHome.split("-")
						var comparSdateHome = dateHomeSplit[0]
								+ dateHomeSplit[1] + dateHomeSplit[2]
						var edateHome = $("#searchEndDatepicker").val()
						var dateHomeSplit = edateHome.split("-")
						var comparEdateHome = dateHomeSplit[0]
								+ dateHomeSplit[1] + dateHomeSplit[2]
						if (comparEdateHome < comparSdateHome) {
							$("#searchEndDatepicker").val("")
							alert("반납일이 대여일보다 앞에 있습니다.")
						}
					})
			$("#edateHome").change(
					function() {
						var sdateHome = $("#sdateHome").val()
						var dateHomeSplit = sdateHome.split("-")
						var comparSdateHome = dateHomeSplit[0]
								+ dateHomeSplit[1] + dateHomeSplit[2]
						var edateHome = $("#edateHome").val()
						var dateHomeSplit = edateHome.split("-")
						var comparEdateHome = dateHomeSplit[0]
								+ dateHomeSplit[1] + dateHomeSplit[2]
						if (comparEdateHome < comparSdateHome) {
							$("#edateHome").val("")
							alert("반납일이 대여일보다 앞에 있습니다.")
						}
					})
			$("#edateHome").focusout(
					function() {
						var sdateHome = $("#sdateHome").val()
						var dateHomeSplit = sdateHome.split("-")
						var comparSdateHome = dateHomeSplit[0]
								+ dateHomeSplit[1] + dateHomeSplit[2]
						var edateHome = $("#edateHome").val()
						var dateHomeSplit = edateHome.split("-")
						var comparEdateHome = dateHomeSplit[0]
								+ dateHomeSplit[1] + dateHomeSplit[2]
						if (comparEdateHome < comparSdateHome) {
							$("#edateHome").val("")
							alert("반납일이 대여일보다 앞에 있습니다.")
						}
					})

			$(".box_home_thumnail").click(function() {
				$(this).closest(".block_home_thumnail").show()
			})
			$('.fa-chevron-left').click(function() {
				if (0 < indexHomeThumbnail) {
					indexHomeThumbnail--
					moveHomeThumbnailLeft(indexHomeThumbnail)
				}
			})
			$('.fa-chevron-left').hover(function() {
				if (0 < indexHomeThumbnail) {
					indexHomeThumbnail--
					moveHomeThumbnailLeft(indexHomeThumbnail)
				}
			})
			$('.fa-chevron-right').click(function() {
				if (indexHomeThumbnail < 4) {
					indexHomeThumbnail++
					moveHomeThumbnailRight(indexHomeThumbnail)
				}
			})
			$('.fa-chevron-right').hover(function() {
				if (indexHomeThumbnail < 4) {
					indexHomeThumbnail++
					moveHomeThumbnailRight(indexHomeThumbnail)
				}
			})

		})
function moveHomeThumbnailLeft(param) {
	console.log(param)
	var size = -50 * param
	size += '%'
	$("#homeThumnailWrap").animate({
		left : size
	});
}
function moveHomeThumbnailRight(param) {
	console.log(param)
	var size = -50 * param
	size += '%'
	$("#homeThumnailWrap").removeAttr("left")
	$("#homeThumnailWrap").animate({
		left : size
	});
}