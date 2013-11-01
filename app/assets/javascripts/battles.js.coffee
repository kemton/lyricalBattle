jQuery ->
	$("#chatWrap").animate { scrollTop: $("#chat").height() }, "fast"

	channel = document.URL.split('/').slice(-1)[0]
	faye = new Faye.Client "http://localhost:9292/faye"

	battleSubscription.cancel if battleSubscription? # cancel previous battle subscriptions

	battleSubscription = faye.subscribe "/channels/#{channel}", (data) ->
		switch data.type
			when "message"
				$("#chat").append "<li>#{data.object.content}</li>"
				$("#chatWrap").animate { scrollTop: $("#chat").height() }, "fast"
			when "online"
				$("#online").text "#{data.object.number_of_users}"
		console.log data

	$('#new_message')
	.bind "ajax:success", (event, data, status, xhr) ->
		$("#new_message")[0].reset()

	return