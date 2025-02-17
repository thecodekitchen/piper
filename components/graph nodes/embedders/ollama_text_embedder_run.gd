extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs=[
		Pipeline.DataType.PlainString
	]
	outputs=[
		Pipeline.DataType.Embedding,
		Pipeline.DataType.MetaDict
	]
	slot(0,Pipeline.DataType.PlainString, Pipeline.DataType.Embedding)
	slot(1,Pipeline.DataType.None,Pipeline.DataType.MetaDict)
	data["receivers"] = ["text_embedder.text"]
	data["senders"] = ["text_embedder.embedding", "text_embedder.meta"]
	data["component_name"] = "text_embedder"
	if not data.has("api_variables"):
		data["api_variables"] = {}
	
func handle_param_assignment(port:int,param_data)->void:
	if param_data.has("name"):
		var param = param_data["name"]
		data["api_variables"]["text"] = param
