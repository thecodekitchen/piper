extends PipelineGraphNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs = [
		Pipeline.DataType.Embedding
	]
	outputs = [
		Pipeline.DataType.DocumentList
	]
	slot(0,Pipeline.DataType.Embedding,Pipeline.DataType.DocumentList)
	data["receivers"] = ["retriever.query_embedding"]
	data["senders"] = ["retriever.documents"]
	if not data.has("api_variables"):
		data["api_variables"] = {}
		
func handle_param_assignment(port:int,param_data)->void:
	if param_data.has("name"):
		data["api_variables"]["embedding"] = param_data["name"]
