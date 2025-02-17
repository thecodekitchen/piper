extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(go_to_pipeline)

func go_to_pipeline()->void:
	get_tree().change_scene_to_file("res://pipeline_editor.tscn")
