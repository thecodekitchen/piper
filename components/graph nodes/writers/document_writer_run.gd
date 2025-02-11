extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs = [Pipeline.DataType.DocumentList]
	outputs = [Pipeline.DataType.Int]
	data["component_name"] = "document_writer"
	data["receivers"] = ["document_writer.documents"]
	data["senders"] = ["document_writer.count"]
	slot(0,Pipeline.DataType.DocumentList,Pipeline.DataType.Int)
	
