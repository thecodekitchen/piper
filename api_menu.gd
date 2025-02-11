extends GraphNodeMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/api/API Param.tscn"),
		preload("res://components/graph nodes/api/Response.tscn"),
		preload("res://components/graph nodes/api/Route.tscn"),
		preload("res://components/graph nodes/api/DataModel.tscn")
	]
