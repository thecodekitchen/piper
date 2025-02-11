extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_separator("Python Scalar Types")
	add_item("str")
	add_item("int")
	add_item("bool")
	add_item("dict")
	add_separator("Python List Types")
	add_item("List[str]")
	add_item("List[int]")
	add_item("List[bool]")
	add_item("List[dict]")
	add_separator("Pipeline Scalar Types")
	add_item("Path")
	add_item("ChatMessage")
	add_separator("Pipeline List Types")
	add_item("List[Path]")
	add_item("List[ChatMessage]")
	var graph_node = $"../.." as PipelineGraphNode
	if graph_node.graph_editor != null && graph_node.graph_editor.data_models.size()>0:
		add_separator("Custom Data Models")
		for model in graph_node.graph_editor.data_models:
			add_item(model._name)
	else:
		graph_node.graph_editor = graph_node.get_parent()
		add_separator("Custom Data Models")
		for model in graph_node.graph_editor.data_models:
			add_item(model._name)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
