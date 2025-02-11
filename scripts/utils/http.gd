class_name HTTP

static func parse_json(body:PackedByteArray) -> Dictionary:
	var json = JSON.new()
	var parse_result = json.parse(body.get_string_from_utf8())
	if parse_result != OK:
		push_error("JSON Parse Error: " + json.get_error_message())
		return {"error": json.get_error_message()}
	var response = json.get_data()
	return response

static func reset_request(req: HTTPRequest) -> HTTPRequest:
	req.queue_free()
	return HTTPRequest.new()
