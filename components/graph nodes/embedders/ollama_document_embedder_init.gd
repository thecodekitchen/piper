extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs = [Pipeline.DataType.ModelName, Pipeline.DataType.URL]
	outputs = []
	slot(0,Pipeline.DataType.ModelName)
	slot(1,Pipeline.DataType.URL)
	data["import"] = "haystack_integrations.components.embedders.ollama.document_embedder.OllamaDocumentEmbedder"
	data["deps"] = [
		"ollama-haystack"
	]
	data["component_name"] = "doc_embedder"
func handle_port_change(port:int,val)->void:
	match port:
		0:
			if val is String:
				print("model updated: ", val)
				data["model"] = val
		1:
			if val is String:
				print("url updated: ", val)
				data["url"] = val
