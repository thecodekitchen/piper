extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(go_home)

func go_home()->void:
	get_tree().change_scene_to_file("res://main_scene.tscn")
