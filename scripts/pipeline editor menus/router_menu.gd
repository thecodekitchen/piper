extends GraphNodeMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/routers/ConditionalRouter.tscn"),
		preload("res://components/graph nodes/routers/FileTypeRouter.tscn"),
		preload("res://components/graph nodes/routers/MetadataRouter.tscn"),
		preload("res://components/graph nodes/routers/TextLanguageRouter.tscn"),
		preload("res://components/graph nodes/routers/TransformersTextRouter.tscn"),
		preload("res://components/graph nodes/routers/TransformersZeroShotTextRouter.tscn")
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
