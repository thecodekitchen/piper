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
