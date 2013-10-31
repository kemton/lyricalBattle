jQuery ->
	$("#chatWrap").animate { scrollTop: $("#chat").height() }, "fast"

	channel = document.URL.split('/').slice(-1)[0]
	faye = new Faye.Client "http://localhost:9292/faye"

	battleSubscription.cancel if battleSubscription? # cancel previous battle subscriptions

	battleSubscription = faye.subscribe "/channels/#{channel}", (data) ->
		if data.type is "message"
			$("#chat").append "<li>#{data.object.content}</li>" 
			$("#chatWrap").animate { scrollTop: $("#chat").height() }, "fast"
		console.log data