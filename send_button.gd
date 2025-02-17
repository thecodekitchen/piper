extends Button

@onready var chat_edit:ChatEdit = $"../../ChatEdit"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(chat_edit.send)
