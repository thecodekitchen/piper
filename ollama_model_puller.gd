extends HBoxContainer

@onready var editor = $LineEdit
@onready var pull_button = $Button
@onready var success_row = $"../SuccessRow"

var model:String

var progress_bar:ProgressBar
var request:HTTPRequest
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	editor.text_changed.connect(update_model)
	pull_button.pressed.connect(initiate_model_pull)
	
func update_model(new:String)->void:
	model = new
	
func initiate_model_pull()->void:
	progress_bar = ProgressBar.new()
	progress_bar.indeterminate = true
	add_sibling(progress_bar)
	request = HTTPRequest.new()
	request.request_completed.connect(request_completed)
	add_child(request)
	request.request("http://localhost:11434/api/pull",[],HTTPClient.METHOD_POST,JSON.stringify({
		"name": editor.text,
		"streaming": true
	}))
	
#func stream_chunk_received(chunk:Dictionary):
	#if chunk.has("completed") and chunk.has("total"):
		#progress_bar.value = chunk["completed"]/chunk["total"]
		#if chunk["completed"] == chunk["total"]:
			#progress_bar.queue_free()
				
func request_completed(result, _response_code, _headers, body)->void:
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Model pull request failed: " + str(result))
		return
	print(body)
	var data = HTTP.parse_json(body)
	if data.has("status") and data["status"] == "success":
		success_row.show()
		request.queue_free()
	#else:
		#stream_chunk_received(body)
