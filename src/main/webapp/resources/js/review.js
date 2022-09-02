var reviewService = (function(){
	
	function add(review, callback, error){
		//console.log("review add..........................");
		
		$.ajax({
			type:'post',
			url: '/review/addReview',
			data: JSON.stringify(review),
			contentType: "application/json; charset=UTF-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr,status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	function addMypage(review, callback, error){
		//console.log("review add..........................");
		
		$.ajax({
			type:'post',
			url: '/review/addMypageReview',
			data: JSON.stringify(review),
			contentType: "application/json; charset=UTF-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr,status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	function getStarScore(param, callback, error){
		//console.log("getStarScore.......................");
		
		var i_id = param.i_id;
		
		$.getJSON("/review/getStarScore/" + i_id + ".json",
				function(data){
					if(callback){
						callback(data);
					}
				}).fail(function(xhr, status, err){
					if(error){
						error();
					}
				});
	}
	
	function getList(param, callback, error){
		//console.log("review getList........................");
		
		var i_id = param.i_id;
		var page = param.page || 1;
		
		$.getJSON("/review/getReviewList/" + i_id + "/" + page + ".json",
				function(data){
					if(callback){
						//callback(data);
						callback(data.reviewCnt, data.reviewList);
					}
				}).fail(function(xhr, status, err){
					if(error){
						error();
					}
				});
	}
	
	function get(s_id, callback, error){
		$.get("/review/" + s_id + ".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	function update(review, callback, error){
		//console.log("s_id: "+ review.s_id);
		
		$.ajax({
			type:'put',
			url: '/review/'+ review.s_id,
			data: JSON.stringify(review),
			contentType: "application/json; charset=utf-8",
			success: function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr,status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function remove(review, callback, error){	
		//console.log(review);
		
		$.ajax({
			type:'post',
			url: '/review/deleteReview',
			data: JSON.stringify(review),
			contentType: "application/json; charset=utf-8",
			success: function(deleteResult,status,xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error: function(xhr,status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	return { 
		add: add,
		getStarScore : getStarScore,
		getList : getList,
		get : get,
		update : update,
		remove : remove
	};
	
})();