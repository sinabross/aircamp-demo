	//페이지번호랑 전체 글 수 번호 
var actionForm = $("#actionForm");

$(".paginate_button a").on("click",function(e) {
	e.preventDefault();

	console.log("click");
	console.log($("#searchLocation").val());

	actionForm.find("input[name = 'pageNum']").val($(this).attr("href"));
	actionForm.submit();
});