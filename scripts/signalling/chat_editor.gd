extends TextEdit
var scroll_window: VBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scroll_window = $"../ChatScrollWindow/ChatWindow"
	size.x = scroll_window.size.x - 20

func _process(_delta: float) -> void:
	size.x = scroll_window.size.x - 20

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		var new_text = self.text
		if text.begins_with("\r\n"):
			new_text = text.substr(2)
		elif text.begins_with("\n"):
			new_text = text.substr(1)
		new_text = new_text.strip_edges()
		print("about to set text: "+ new_text)
		self.set_text(new_text)
		call_deferred("reset_input")
		
func reset_input():
	self.clear()
	self.set_caret_line(0)
	self.set_caret_column(0)
