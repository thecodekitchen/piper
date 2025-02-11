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
	data["receivers"] = ["retriever.embedding"]
	data["senders"] = ["retriever.documents"]
