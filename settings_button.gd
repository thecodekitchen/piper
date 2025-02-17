extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(go_to_settings)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func go_to_settings()->void:
	get_tree().change_scene_to_file("res://settings.tscn")
