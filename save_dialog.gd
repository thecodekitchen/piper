extends FileDialog


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	file_selected.connect(save_graph_to_file)

func save_graph_to_file(path:String)->void:
	var graph_editor = $"../ColorRect/VBoxContainer/GraphEdit" as PipelineGraphEdit
	var graph_data = {}
	graph_data["connections"] = graph_editor.get_connection_list()
	graph_data["nodes"] = []
	graph_data["frames"] = []
	for child in graph_editor.get_children():
		if child is PipelineGraphNode:
			var node_data = {
				"name": child.name,
				"data": child.data,
				"input_types": [],
				"output_types": [],
				"position_offset": child.position_offset
			}
			for type in child.inputs:
				node_data["input_types"].append(Pipeline.DataType.keys()[type])
			for type in child.outputs:
				node_data["output_types"].append(Pipeline.DataType.keys()[type])
			graph_data["nodes"].append(node_data)
		if child is PipelineGraphFrame:
			var attached_nodes = graph_editor.get_attached_nodes_of_frame(child.name)
			var frame_data = {
				"name": child.name,
				"title": child.title,
				"attached": attached_nodes,
				"position_offset": child.position_offset,
				"size": child.size
			}
			graph_data["frames"].append(frame_data)
			
	var graph_data_string = JSON.stringify(graph_data)
	print(graph_data_string)
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_string(graph_data_string)
	file.close()
