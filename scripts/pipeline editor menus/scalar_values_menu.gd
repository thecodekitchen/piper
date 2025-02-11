extends GraphNodeMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/scalar values/api_key.tscn"),
		preload("res://components/graph nodes/scalar values/model.tscn"),
		preload("res://components/graph nodes/scalar values/bool.tscn"),
		preload("res://components/graph nodes/scalar values/Integer.tscn"),
		preload("res://components/graph nodes/scalar values/string.tscn"),
		preload("res://components/graph nodes/scalar values/url.tscn")
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
