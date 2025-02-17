extends VBoxContainer

func _ready() -> void:
	Globals.updated_conversations.connect(refresh_conversation_list)

func refresh_conversation_list()->void:
	for child in get_children():
		child.queue_free()
	for conv in Globals.saved_conversations:
		var label = Label.new()
		label.text = conv
		add_child(label)
