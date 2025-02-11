extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs = [Pipeline.DataType.DocumentList]
	outputs = [Pipeline.DataType.DocumentList]
	slot(0,Pipeline.DataType.DocumentList,Pipeline.DataType.DocumentList)
	data["import"] = "haystack.components.joiners.document_joiner.DocumentJoiner"
	data["component_name"] = "doc_joiner"
	data["receivers"] = ["doc_joiner.documents"]
	data["senders"] = ["doc_joiner.documents"]
