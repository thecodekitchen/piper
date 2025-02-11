extends GraphNodeMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/preprocessors/DocumentCleaner.tscn"),
		preload("res://components/graph nodes/preprocessors/DocumentSplitter.tscn"),
		preload("res://components/graph nodes/preprocessors/RecursiveSplitter.tscn"),
		preload("res://components/graph nodes/preprocessors/TextCleaner.tscn")
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
