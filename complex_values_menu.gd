extends GraphNodeMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/complex values/PromptTemplate.tscn"),
		preload("res://components/graph nodes/complex values/StringList.tscn"),
		preload("res://components/graph nodes/complex values/Args.tscn")
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
