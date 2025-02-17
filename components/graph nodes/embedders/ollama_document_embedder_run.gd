extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs = [Pipeline.DataType.DocumentList]
	outputs = [Pipeline.DataType.DocumentList, Pipeline.DataType.MetaDict]
	slot(0,Pipeline.DataType.DocumentList,Pipeline.DataType.DocumentList)
	slot(1,Pipeline.DataType.None,Pipeline.DataType.MetaDict)
	data["receivers"] = ["doc_embedder.documents"]
	data["senders"] = ["doc_embedder.documents","doc_embedder.meta"]
	data["component_name"] = "doc_embedder"
	if not data.has("api_variables"):
		data["api_variables"]={}

func handle_param_assignment(port:int,param_data)->void:
	if param_data.has("name"):
		data["api_variables"]["documents"] = param_data["name"]
