extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs = [Pipeline.DataType.PathList]
	outputs = [Pipeline.DataType.DocumentList]
	slot(0,Pipeline.DataType.PathList,Pipeline.DataType.DocumentList)
	data["import"] = "haystack.components.converters.html.HTMLToDocument"
	data["component_name"] = "html"
	data["receivers"] = ["html.sources"]
	data["senders"] = ["html.documents"]
	data["deps"] = ["trafilatura"]
func conn_request(from:StringName,from_port:int,to:StringName,to_port:int)->void:
	var origin = graph_editor.get_node(NodePath(from))
	if origin.data.has("output_types"):
		var output_types = origin.data["output_types"]
		if output_types.find("text/html") != from_port:
			print("incorrect output type: ", output_types[from_port])
			return
	super.conn_request(from,from_port,to,to_port)
