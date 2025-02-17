extends OptionButton

@onready var parent_node = $"../.."
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
	if parent_node is PipelineGraphNode:
		if parent_node.data.has("value"):
			var found_selection = false
			for i in item_count:
				if get_item_text(i) == parent_node.data["value"]:
					found_selection = true
					select(i)
					break
				if not found_selection:
					select(0)
		
func get_models(req: HTTPRequest) -> void:
	var err = req.request("http://localhost:11434/api/tags")
	if err != OK:
		push_error("Failed to get models: " + err)
