extends VBoxContainer

var current_query:String
var user_message_scene: PackedScene
var system_message_scene: PackedScene
var api_key = "4>GAK~YV+m-eZ5YO,9,O"
var chat_history:Array[Dictionary] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	user_message_scene = preload("res://components/user_message.tscn")
	system_message_scene = preload("res://components/system_message.tscn")
	add_system_message("Sup nerd. What's your deal?")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func chat_editor_set() -> void:
	print("chat_editor_set called")
	var chat_editor = $"../../ChatEditor" as TextEdit
#	Assume anything less than 3 characters was probably an accidental entry
	if chat_editor.text.length() >2:
		print("Sending query: "+ chat_editor.text)
		add_user_message(chat_editor.text)

func add_system_message(message: String) -> void:
	var msg_node = system_message_scene.instantiate()
	var label = msg_node.get_child(0) as RichTextLabel
	label.text = message
	self.add_child(msg_node)
	var msg_obj = ChatMessage.new("system", message).to_dict()
	chat_history.append(msg_obj)
	
	
func add_user_message(message: String) -> void:
	var msg_node = user_message_scene.instantiate()
	var label = msg_node.get_child(0) as RichTextLabel
	label.text = message
	self.add_child(msg_node)
	var msg_obj = ChatMessage.new("user", message).to_dict()
	current_query=message
	chat_history.append(msg_obj)
	send_chat_request()
	
func send_chat_request() -> void:
	add_spinner()
	var headers = PackedStringArray(["qdrant-key: " + api_key])
	var body = {
		"query": current_query,
		"chat_history": chat_history,
		"collection": $"../../ChatOptionsRow/CollectionPicker".text,
		"model": $"../../ChatOptionsRow/ModelPicker".text
	}
	var body_string = JSON.stringify(body)
	var req = HTTPRequest.new()
	add_child(req)
	req.request_completed.connect(self.chat_request_completed)
	var err = req.request("http://localhost:8000/chat",headers,HTTPClient.METHOD_POST,body_string)
	if err != OK:
		push_error("Failed to send chat message: " + err)
	
func chat_request_completed(result, _response_code, _headers, body) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Chat request failed: " + str(result))
		return
	var response = HTTP.parse_json(body)
	var raw_answer = response.answer_builder.answers[0].data
	var parsed_answer = parse_llm_response(raw_answer)
	add_system_message(parsed_answer.content)
	remove_spinner()
	remove_req()
	
func add_spinner():
	var spinner = Spinner.new()
	spinner.anchor_left = 0.5
	spinner.anchor_right = 0.5
	spinner.offset_left = -spinner.size.x / 2
	spinner.offset_right = spinner.size.x / 2
	add_child(spinner)
	
func remove_spinner():
	for child in get_children():
		if child is Spinner:
			child.queue_free()

func remove_req():
	for child in self.get_children():
		if child is HTTPRequest:
			child.queue_free()
	
func parse_llm_response(text: String) -> Dictionary:
	var result = {
		"thinking": "",
		"content": ""
	}
	
	# Extract thinking section with multiline support
	var think_regex = RegEx.new()
	# (?s) enables dot-all mode where . matches newlines
	# (?m) enables multiline mode
	think_regex.compile("(?s)(?m)<think>\\s*(.+?)\\s*</think>")
	var matches = think_regex.search(text)
	
	if matches:
		result.thinking = matches.get_string(1).strip_edges()
		# Remove thinking section and any "Thinking:" or "Content:" labels
		text = think_regex.sub(text, "", true)
		text = text.replace("Thinking:", "").replace("Content:", "")
	
	result.content = text.strip_edges()
	return result
