extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs = [Pipeline.DataType.DocumentList]
	outputs = [Pipeline.DataType.DocumentList]
	slot(0,Pipeline.DataType.DocumentList,Pipeline.DataType.DocumentList)
	data["import"] = "haystack.components.preprocessors.document_splitter.DocumentSplitter"
	data["component_name"] = "splitter"
	data["receivers"] = ["splitter.documents"]
	data["senders"] = ["splitter.documents"]
