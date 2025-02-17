extends HBoxContainer

@onready var dismiss_button:Button = $Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dismiss_button.pressed.connect(dismiss)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func dismiss()->void:
	hide()
