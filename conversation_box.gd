extends VBoxContainer

@onready var system_message:PackedScene = preload("res://components/system_message.tscn")
@onready var user_message:PackedScene = preload("res://components/user_message.tscn")

func _ready() -> void:
	if not Globals.conversation:
		Globals.conversation = [
			ChatMessage.new("assistant","Sup nerd. What's your deal?")
		]
	render_conversation()
	Globals.updated_messages.connect(render_conversation)
	
func render_conversation()->void:
	for child in get_children():
		child.queue_free()
	for message in Globals.conversation:
		var msg_node:Node
		match message._role:
			"assistant":
				msg_node = system_message.instantiate()
			"user":
				msg_node = user_message.instantiate()
		if msg_node:
			add_child(msg_node)
			var label = msg_node.get_child(0)
			label.text = message._content[0]["text"]
