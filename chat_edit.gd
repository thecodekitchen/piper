class_name ChatEdit
extends TextEdit

@onready var conversation_box:VBoxContainer = $"../ScrollContainer/ConversationBox"
@onready var collection_picker:OptionButton = $"../SubmissionRow/CollectionSelect"
@onready var system_message:PackedScene = preload("res://components/system_message.tscn")
@onready var user_message:PackedScene = preload("res://components/user_message.tscn")

var req:HTTPRequest

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("submit_chat"):
		send()
	
func send()->void:
	var query = text
	Globals.conversation.append(ChatMessage.new("user", query))
	Globals.emit_signal("updated_messages")
	clear()
	set_caret_column(0)
	set_caret_line(0)
	req = HTTPRequest.new()
	add_child(req)
	var history = []
	for msg in Globals.conversation:
		history.append(msg.to_dict())
	var body = JSON.stringify({"query": query, "history": history})
	print(body)
	req.request_completed.connect(on_request_complete)
	if not Globals.selected_collection:
		collection_picker.select(0)
	print("selected collection: ", Globals.selected_collection)
	req.request(Globals.pipeline_url+"/chat/"+Globals.selected_collection,[],HTTPClient.METHOD_POST,body)
		
		
func on_request_complete(result,code,headers,body:PackedByteArray)->void:
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("chat request failed!")
		print(body.get_string_from_utf8())
		return
	var data = HTTP.parse_json(body)
	if not data.has("answer_builder") || not data["answer_builder"].has("answers"):
		push_error("answer not found in chat response: ")
		print(data)
		return
	var answer = data["answer_builder"]["answers"][0]
	if answer.has("data"):
		var chat_message = ChatMessage.new("assistant", answer["data"])
		Globals.conversation.append(chat_message)
		Globals.emit_signal("updated_messages")
		if answer.has("documents"):
			var documents: Array[Dictionary] = []
			for doc in answer["documents"]:
				documents.append(doc)
			Globals.sources = documents
			Globals.emit_signal("updated_sources")
