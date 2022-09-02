$(document)
		.ready(
				function() {
					var checkForm_id = 0;
					var checkForm_email = 0;
					var checkForm_cemail = 0;
					var checkForm_title = 0;
					var checkForm_content = 0;
					var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

					var deviceWidth = $(document).width()
					console.log(deviceWidth)

					$(".text_contactus_err").hide()
					$("input[name='m_id']").focusout(
							function() {
								console.log("m_id")
								console.log($(this).val())
								if ($(this).val() == "") {
									console.log("이름을 입력하세요")
									$(this).next(".text_contactus_err").css(
											"display", "block")
									checkForm_id = 0
								} else {

									$(this).next(".text_contactus_err").css(
											"display", "none")
									checkForm_id = 1
								}

							})
					$("input[name='q_email']").focusout(
							function() {
								console.log("q_email")
								console.log($(this).val())

								if ($(this).val() == ""
										|| $(this).val() == null) {
									$(this).next(".text_contactus_err").text(
											"email주소를 입력하세요.").show()
									checkForm_email = 0
								} else if (!emailRule.test($(this).val())) {

									$(this).next(".text_contactus_err").text(
											"유효한 email 형식이 아닙니다").show()
									checkForm_email = 0
								} else {
									$(this).next(".text_contactus_err").hide()

									checkForm_email = 1
								}
							})
					$("input[name='q_email_confirm']").focusout(
							function() {
								console.log("q_email_confirm")
								console.log($(this).val())
								if ($(this).val() == "") {
									$(this).next(".text_contactus_err").text(
											"email주소를 입력하세요.").show()
									checkForm_cemail = 0
								} else if ($(this).val() != $(
										"input[name='q_email']").val()) {
									$(this).next(".text_contactus_err").text(
											"email 주소가 일치하지 않습니다.").show()
									checkForm_cemail = 0
								} else {
									$(this).next(".text_contactus_err").hide()

									checkForm_cemail = 1
								}
							})
					$("input[name='q_title']").focusout(
							function() {
								console.log("q_title")
								console.log($(this).val())
								if ($(this).val() == "") {
									$(this).next(".text_contactus_err").text(
											"제목을 입력하세요.").show()
									checkForm_title = 0
								} else {
									$(this).next(".text_contactus_err").hide()

									checkForm_title = 1
								}
							})
					$("[name='q_content']").focusout(
							function() {
								console.log("m_id")
								console.log($(this).val())
								if ($(this).val() == "") {
									$(this).next(".text_contactus_err").text(
											"내용을 입력하세요.").show()
									checkForm_content = 0

								} else {
									$(this).next(".text_contactus_err").hide()
									checkForm_content = 1
								}
							})

					$("#boxContactus button")
							.click(
									function(event) {
										event.preventDefault();
										if ($("input[name='m_id']").val() != ""
												&& $("input[name='q_email']")
														.val() != ""
												&& $("input[name='q_email_confirm']")
														.val() != ""
												&& $("input[name='q_title']")
														.val() != ""
												&& $("[name='q_content']")
														.val() != ""
												&& checkForm_cemail == 1) {
											console.log("============")
											$("#boxContactus form").submit()

										} else {
											alert("입력내용을 확인하세요.")
											return false
										}
									})
				})