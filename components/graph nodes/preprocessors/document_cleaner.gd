extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready() # Replace with function body.
	inputs = [Pipeline.DataType.DocumentList]
	outputs = [Pipeline.DataType.DocumentList]
	slot(0,Pipeline.DataType.DocumentList,Pipeline.DataType.DocumentList)
	data["import"] = "haystack.components.preprocessors.document_cleaner.DocumentCleaner"
	data["component_name"] = "cleaner"
	data["receivers"] = ["cleaner.documents"]
	data["senders"] = ["cleaner.documents"]
