extends MenuButton

var pipeline_editor:PackedScene
var chat: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pipeline_editor = preload("res://pipeline_editor.tscn")
	chat = preload("res://main_scene.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _pipeline_editor() -> void:
	pipeline_editor.show()
	
func _chat() -> void:
	chat.show()
