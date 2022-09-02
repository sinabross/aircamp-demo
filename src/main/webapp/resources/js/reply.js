console.log("Reply Module..................");

var replyService = (function() {
	
	// 등록
	function add(reply, callback, error) {
		
		console.log("reply=============================");

		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {	
				if (callback) {
					console.log("==================================================");
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
		
	}

	// 목록
	function getList(param, callback, error) {

		var c_id = param.c_id;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + c_id + "/" + page + ".json",
				function(data) {
					if (callback) {
						//callback(data);
						callback(data.replyCnt, data.list)
					}
				}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}

	// 삭제
	function remove(r_id, m_id, callback, error) {
		
		console.log("=================================================="+m_id);
		console.log("=================================================="+r_id);
		
		$.ajax({
			type : 'delete',
			url : '/replies/' + r_id,
			data : JSON.stringify({r_id:r_id, m_id:m_id}),
			contentType : "application/json; charset=utf-8",
			success : function(deleteResult, status, xhr) {
				if (callback) {
					console.log("=================================================="+deleteResult);
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					console.log("=================================================="+error);
					error(er);
				}
			}
		});
	}

	// 수정
	function update(reply, callback, error) {

		console.log("r_id==================" + reply.r_id);

		$.ajax({
			type : 'put',
			url : '/replies/' + reply.r_id,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
					console.log("====================");
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					console.log("====================");
					error(er);
				}
			}
		});
	}

	// 조회
	function get(r_id, callback, error) {
		
		$.get("/replies/" + r_id + ".json", function(result) {
			if (callback) {
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}

	// 날짜 변환
	function displayTime(timeValue) {
		
		var today = new Date();

		var gap = today.getTime() - timeValue;

		var dateObj = new Date(timeValue);
		var str = "";

		if (gap < (1000 * 60 * 60 * 24)) {

			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();

			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 99 ? '' : '0') + dd ].join('');
		}
		;	
	}
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	}
	;
})();