extends OptionButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self.models_request_completed)
	self.get_models(http_request)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func models_request_completed(result, _response_code, _headers, body) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Model list request failed: " + str(result))
		return
	var response = HTTP.parse_json(body)
	var models = response.get("models") as Array[String]
	for model in models:
		self.add_item(model.name)

func get_models(req: HTTPRequest) -> void:
	var err = req.request("http://localhost:11434/api/tags")
	if err != OK:
		push_error("Failed to get models: " + err)
